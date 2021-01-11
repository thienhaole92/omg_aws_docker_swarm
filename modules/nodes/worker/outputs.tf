output "worker_ip" {
  description = "Public ip of worker instances"
  value       = aws_instance.worker.*.public_ip
}
