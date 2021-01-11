output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "controller_subnet_ids" {
  description = "List of IDs of controller subnets"
  value       = aws_subnet.controller_subnet.*.id
}

output "manager_subnet_ids" {
  description = "List of IDs of manager subnets"
  value       = aws_subnet.manager_subnet.*.id
}

output "public_subnet_id" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnet.id
}

output "worker_subnet_ids" {
  description = "List of IDs of worker subnets"
  value       = aws_subnet.worker_subnet.*.id
}

output "nat_ip" {
  value = aws_instance.nat.public_ip
}
