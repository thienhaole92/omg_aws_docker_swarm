resource "aws_instance" "proxy" {
  count                       = 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.proxy.id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.application}-proxy-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_security_group" "proxy" {
  name        = "${var.application}-proxy-sg"
  description = "Security group for docker proxy node"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
