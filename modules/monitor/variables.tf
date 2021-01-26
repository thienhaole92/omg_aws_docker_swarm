variable "region" {
  default = "ap-southeast-1"
}

variable "amis" {
  type = map(string)

  default = {
    ap-southeast-1 = "ami-0c20b8b385217763f"
  }
}

variable "instance_type" {
  default = "t2.small"
}

variable "key_name" {
  description = "The name of the Key Pair that can be used to SSH to each instance in the cluster"
}

variable "subnet_id" {
}

variable "application" {
  description = "The name or name prefix of the application and associated resources"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "connection_user" {
  default = "ubuntu"
}

variable "private_key" {
  default = ""
}

variable "root_block_device" {
  type        = list(map(string))
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default = [
    {
      volume_type = "gp2"
      volume_size = 32
      encrypted   = true
    },
  ]
}