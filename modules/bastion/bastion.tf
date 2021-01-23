resource "aws_instance" "bastion" {
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = var.subnet_id

  tags = {
    Name        = "${var.application}-bastion-instance"
    Application = var.application
  }

  # connection {
  #   user        = var.connection_user
  #   private_key = var.private_key
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo touch /var/log/bastion.tf.log",
  #   ]
  # }
}

resource "aws_security_group" "bastion_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.application}-bastion-sg"
  description = "Allow SSH to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.application}-bastion-sg"
    Application = var.application
  }
}
