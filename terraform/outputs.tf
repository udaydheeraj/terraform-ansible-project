output "instance_id" {
  value       = aws_instance.web.id
  sensitive   = true
  description = "description"
  depends_on  = []
}

output "public_ip" {
    value = aws_instance.web.public_ip
}
