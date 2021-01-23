output "monitor_ip" {
  description = "List of public ip of monitor instances"
  value       = aws_instance.monitor.*.public_ip
}