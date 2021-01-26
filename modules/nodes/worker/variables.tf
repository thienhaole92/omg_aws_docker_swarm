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
  default = "t2.medium"
}

variable "key_name" {
  description = "The name of the Key Pair that can be used to SSH to each instance in the cluster"
}

variable "worker_subnet_ids" {
  type = list(string)
  default = []
}

variable "application" {
  description = "The name or name prefix of the application and associated resources"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "worker_count" {
  default = "1"
}

variable "root_block_device" {
  type        = list(map(string))
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "gluster_volume_size" {
  type    = number
  default = 16
}