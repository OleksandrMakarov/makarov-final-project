output "private-ip-jenkins-server" {
  description = "Private IP (Jenkins server)"
  value       = module.jenkins.private-ip
}

output "public-ip-jenkins-server" {
  description = "Public IP (Jenkins server)"
  value       = module.jenkins.public-ip
}

output "private-ip-app-server" {
  description = "Private IP (app server)"
  value       = module.app-server.private-ip
}

output "public-ip-app-server" {
  description = "Public IP (app server)"
  value       = module.app-server.public-ip
}
