resource "aws_security_group" "sg" {
  name        = "${var.component_name}-${var.env}-sg"
  description = "inbound allow for ${var.component_name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.id   # ✅ fixed
  instance_type          = var.instance_type     # ✅ fixed
  vpc_security_group_ids = [aws_security_group.sg.id]  # ✅ fixed

  tags = {
    Name = "${var.component_name}-${var.env}"
  }


  provisioner "remote-exec" {}
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.private_ip
  }

    inline = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/vishnureddy81/roboshop-ansible roboshop.yml -e env=${var.env} -e app_name=${component_name}"
    ]

  }






