output "cicd_ip" {
  description = "List of public ip of cicd instances"
  value       = aws_instance.cicd.*.public_ip
}