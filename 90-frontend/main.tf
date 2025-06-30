module "frontend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                    = local.ami
  name                   = local.resource_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    var.frontend_tags,
    {
      Name = local.resource_name
    }
  )
}

resource "null_resource" "frontend" {
    triggers = {
        instance_id = module.frontend.id
    }

    connection {
        host = module.frontend.private_ip
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
    }
    provisioner "file" {
        source = "${var.frontend_tags.Component}.sh"
        destination = "/tmp/frontend.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/frontend.sh",
            "sudo sh /tmp/frontend.sh ${var.frontend_tags.Component} ${var.environment}"

        ]
    }
}

resource "aws_ec2_instance_state" "frontend" {
  instance_id = module.frontend.id
  state = "stopped"
  depends_on = [null_resource.frontend]
}

resource "aws_ami_from_instance" "frontend" {
  name = local.resource_name
  source_instance_id = module.frontend.id
  depends_on = [aws_ec2_instance_state.frontend]
}

resource "null_resource" "frontend_delete" {
    triggers = {
        instance_id = module.frontend.id
    }

    provisioner "local-exec" {
        command = "aws ec2 terminate-instances --instance-ids ${module.frontend.id}"          
    }
  
  depends_on = [aws_ami_from_instance.frontend]
}


resource "aws_lb_target_group" "frontend" {
  name = local.resource_name
  port = 80
  protocol = "HTTP"
  vpc_id = local.vpc_id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 5
    matcher = "200-299"
    path = "/"
    port = 80
    protocol = "HTTP"
    timeout = 4
  }
}

resource "aws_launch_template" "frontend" {
  name = local.resource_name
  image_id = aws_ami_from_instance.frontend.id
  instance_initiated_shutdown_behavior = "terminate"
  update_default_version = true
  instance_type = var.instance_type

  vpc_security_group_ids = [local.frontend_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.resource_name
    }
  }
}

resource "aws_autoscaling_group" "frontend" {
  name = local.resource_name
  min_size = 2
  max_size = 10
  health_check_grace_period = 120
  health_check_type = "ELB"
  desired_capacity = 2
  target_group_arns = [aws_lb_target_group.frontend.arn]
  launch_template {
    id = aws_launch_template.frontend.id
    version = "$Latest"

  }
  vpc_zone_identifier = [local.public_subnet_id]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }
  tag {
    key = "Name"
    value = local.resource_name
    propagate_at_launch = true


  }

  timeouts {
    delete = "15m"
  }
  tag {
    key = "Project"
    value = "Expense"
    propagate_at_launch = false
  }

}

resource "aws_autoscaling_policy" "frontend" {
  name = local.resource_name
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type = "TargetTrackingScaling" 
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

resource "aws_lb_listener_rule" "frontend" {
  listener_arn = local.arn
  priority     = 100
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    host_header {
      values = ["expense-${var.environment}.${var.zone_name}"]
    }
  }
}

