output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_eip.app_eip.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = aws_instance.app_server.public_dns
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.app_sg.id
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i ${var.ssh_private_key_path} ubuntu@${aws_eip.app_eip.public_ip}"
}

output "application_url" {
  description = "Application URL"
  value       = "https://${var.domain_name}"
}