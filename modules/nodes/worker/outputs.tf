output "worker_ip" {
  description = "Public ip of worker instances"
  value       = aws_instance.worker.*.public_ip
}


output "availability_zone" {
  description = "List of availability zones of instances"
  value       = aws_instance.worker.*.availability_zone
}