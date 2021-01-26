resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = lookup(var.amis, var.region)
  instance_type          = var.instance_type
  subnet_id              = element(var.worker_subnet_ids, count.index)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.worker.id]

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      volume_size = lookup(root_block_device.value, "volume_size", null)
    }
  }

  tags = {
    Name        = "${var.application}-worker-instance-${count.index}"
    Application = var.application
  }
}

resource "aws_volume_attachment" "attachment" {
  count = var.worker_count

  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.volume[count.index].id
  instance_id = element(aws_instance.worker.*.id, count.index)
}

resource "aws_ebs_volume" "volume" {
  count             = var.worker_count
  availability_zone = element(aws_instance.worker.*.availability_zone, count.index)
  size              = var.gluster_volume_size
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
