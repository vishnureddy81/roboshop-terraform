# terraform {
#   required_providers {
#     null = {
#       source  = "hashicorp/null"
#       version = "3.2.3"
#     }
#   }
# }
resource "aws_security_group" "sg" {
  name        = "${var.component_name}-${var.env}-sg"
  description = "inbound allow for ${var.component_name}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.app_port
    to_port   = var.app_port
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "instance" {
  ami           = "data.aws_ami.ami.id"
  instance_type = "var.instance_type"
  vpc_security_group_ids = ["aws_seurity_group.sg.id"]
  tags = {
    name = "${var.component_name}-${var.env}"
  }
}

# resource "null_resource" "ansible_pull" {}
#
#
# provisioner "remote-exec" "ansible-pull" {
# }
# connection {
#   type     = "ssh"
#   user     = "ec2-user"
#   password = "DevOps321"
#   host     = "aws_instance.instance.private_ip"
# }
# inline = [
#  "sudo labauto ansible",
#   "ansible-pull -i localhost, -U https://github.com/Vishnureddy00111/roboshop-ansible-01 roboshop.yml -e env=${var.env} -e app_name=${var.component_name}"
# ]


# provisioner "local-exec" {
#   command = <<EOL
#   /home/ec2-user/roboshop-ansible
# ansible-playbook -i ${self.private_ip}, -e ansible_user=ec2-user -e ansible_password=Devops321-e app_name=${var.component_name} -e env=$(var.env) roboshop.yml
#  }
# }