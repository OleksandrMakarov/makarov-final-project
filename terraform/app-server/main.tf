resource "aws_instance" "app-server" {
  ami                  = var.ami-id
  iam_instance_profile = var.iam-instance-profile
  instance_type        = var.instance-type
  key_name             = var.key-pair
  network_interface {
    device_index         = var.device-index
    network_interface_id = var.network-interface-id
  }

  user_data = templatefile("${path.module}/user_data.sh", {
    repository_url = var.repository-url,
    aws_access_key = var.aws_access_key,
    aws_secret_key = var.aws_secret_key,
    aws_region     = var.aws_region
  })

  tags = {
    Name = var.name
  }
}
