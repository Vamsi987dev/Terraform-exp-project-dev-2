resource "aws_key_pair" "openvpn" {
    key_name = "openvpn"
    public_key = file("~/.ssh/openvpn.pub")
} 

# module "ec2_instance" {
#   source = "terraform-aws-modules/ec2-instance/aws"
#   key_name = aws_key_pair.openvpn.key_name
#   ami                    = local.ami
#   name                   = local.resource_name
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [local.vpn_sg_id]
#   subnet_id              = local.public_subnet_id
#   user_data= file("user-data.sh")

#   tags = merge(
#     var.common_tags,
#     var.vpn_tags,
#     {
#       Name = local.resource_name
#     }
#   )
# }

resource "aws_instance" "vpn" {
  ami                    = local.ami
  key_name = aws_key_pair.openvpn.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_id
  #Giving the userdata path
  user_data = file("user-data.sh")
  tags = merge(
     var.common_tags,
     var.vpn_tags,
    {
      Name = local.resource_name
    }
  )
}