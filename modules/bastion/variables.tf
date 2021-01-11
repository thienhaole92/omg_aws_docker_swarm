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
  description = "Type of ec2 instance used for openvpn node"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The public key for the bastion host"
}

variable "subnet_id" {
}

variable "private_key" {
  default = ""
}

variable "application" {
  description = "The name or name prefix of the application and associated resources"
}

variable "vpc_id" {
  description = "vpc id"
}


variable "vpc_cidr" {
  default = ""
}

variable "connection_user" {
  default = "ubuntu"
}
