resource "aws_instance" "nat" {
  ami                         = lookup(var.nat_amis, var.region)
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.nat.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name        = "${var.application}-nat"
    Application = var.application
  }
}

resource "aws_security_group" "nat" {
  name        = "${var.application}-nat-sg"
  description = "Security group for docker nat node"
  vpc_id      = aws_vpc.vpc.id

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
