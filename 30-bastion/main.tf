module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                    = local.ami
  name                   = local.resource_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    var.bastion_tags,
    {
      Name = local.resource_name
    }
  )
}