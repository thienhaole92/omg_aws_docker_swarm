resource "aws_instance" "manager" {
  count                  = var.manager_count
  ami                    = lookup(var.amis, var.region)
  instance_type          = var.instance_type
  subnet_id              = element(var.manager_subnet_ids, count.index)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.manager.id]

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      volume_size = lookup(root_block_device.value, "volume_size", null)
    }
  }

  tags = {
    Name        = "${var.application}-manager-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_volume_attachment" "attachment" {
  count = var.manager_count

  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.volume[count.index].id
  instance_id = element(aws_instance.manager.*.id, count.index)
}

resource "aws_ebs_volume" "volume" {
  count             = var.manager_count
  availability_zone = element(aws_instance.manager.*.availability_zone, count.index)
  size              = var.gluster_volume_size
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
