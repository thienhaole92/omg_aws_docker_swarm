variable "cidr" {
  description = "CIDR subnet range"
}

variable "application" {
  description = "Application tag"
}

variable "region" {
  description = "The region to deploy to the resources to"
}

variable "key_name" {
  description = "The name of the Key Pair that can be used to SSH to each instance in the cluster"
}

variable "public_subnet_zone" {
  default = "ap-southeast-1a"
}

variable "public_subnet_cidr" {
  default = "10.0.5.0/24"
}

variable "nat_amis" {
  type = map(string)

  default = {
    ap-southeast-1 = "ami-0003ce8d47722ef67"
  }
}

variable "controller_count" {
  default = "1"
}

variable "controller_subnet_cidr" {
  type = list(string)

  default = ["10.0.4.0/24"]
}

variable "controller_subnet_zones" {
  type = list(string)

  default = ["ap-southeast-1b"]
}

variable "worker_count" {
  default = "2"
}

variable "worker_subnet_cidr" {
  type = list(string)

  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "worker_subnet_zones" {
  type = list(string)

  default = ["us-east-1a", "us-east-1b"]
}

variable "manager_count" {
  default = "1"
}

variable "manager_subnet_cidr" {
   type = list(string)

  default = ["10.0.3.0/24"]
}

variable "manager_subnet_zones" {
  type = list(string)

  default = ["us-east-1c"]
}