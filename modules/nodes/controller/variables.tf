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

variable "controller_subnet_ids" {
  type = list(string)
  default = []
}

variable "application" {
  description = "The name or name prefix of the application and associated resources"
}

variable "vpc_id" {
  description = "vpc id"
}
