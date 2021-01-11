output "controller_ip" {
  description = "List of public ip of controller instances"
  value       = aws_instance.controller.*.public_ip
}
