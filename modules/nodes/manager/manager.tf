resource "aws_instance" "manager" {
  count                       = 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  subnet_id                   = element(var.manager_subnet_ids, count.index)
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.manager.id]
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name        = "${var.application}-manager-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_security_group" "manager" {
  name        = "${var.application}-manager-sg"
  description = "Security group for docker manager node"
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
