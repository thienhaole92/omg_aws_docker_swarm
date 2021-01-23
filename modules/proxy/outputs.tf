output "proxy_ip" {
  description = "List of public ip of cicd instances"
  value       = aws_instance.proxy.*.public_ip
}