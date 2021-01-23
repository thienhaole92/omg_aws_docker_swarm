resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = lookup(var.amis, var.region)
  instance_type          = var.instance_type
  subnet_id              = element(var.worker_subnet_ids, count.index)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.worker.id]

  tags = {
    Name        = "${var.application}-worker-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_security_group" "worker" {
  name        = "${var.application}-worker-sg"
  description = "Security group for docker worker node"
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
