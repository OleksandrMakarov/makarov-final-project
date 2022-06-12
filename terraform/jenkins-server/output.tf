output "instance-id" {
  value = aws_instance.jenkins_server.id
}

output "name" {
  value = var.name
}

output "private-ip" {
  value = aws_instance.jenkins_server.private_ip
}