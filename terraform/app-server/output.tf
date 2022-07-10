output "instance-id" {
  value = aws_instance.app-server.id
}

output "name" {
  value = var.name
}

output "private-ip" {
  value = aws_instance.app-server.private_ip
}

output "public-ip" {
  value = aws_instance.app-server.public_ip
}