output "manager_ip" {
  description = "Public ip of controller instances"
  value       = aws_instance.manager.*.public_ip
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = aws_instance.manager.*.availability_zone
}