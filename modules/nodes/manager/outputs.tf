output "manager_ip" {
  description = "Public ip of controller instances"
  value       = aws_instance.manager.*.public_ip
}
