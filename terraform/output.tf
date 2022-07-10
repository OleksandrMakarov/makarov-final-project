output "private-ip-app-server" {
  description = "Private IP (app server)"
  value          = module.app-server.private-ip
}

output "public-ip-app-server" {
  description = "Public IP (app server)"
  value          = module.app-server.public-ip
}
