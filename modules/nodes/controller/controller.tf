resource "aws_instance" "controller" {
  count                       = 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  subnet_id                   = element(var.controller_subnet_ids, count.index)
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.controller.id]

  tags = {
    Name        = "${var.application}-controller-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_security_group" "controller" {
  name        = "${var.application}-controller-sg"
  description = "Security group for docker controller node"
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
