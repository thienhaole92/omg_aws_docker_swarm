resource "aws_instance" "monitor" {
  count                       = 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.monitor.id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.application}-monitor-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_security_group" "monitor" {
  name        = "${var.application}-monitor-sg"
  description = "Security group for docker monitor node"
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
