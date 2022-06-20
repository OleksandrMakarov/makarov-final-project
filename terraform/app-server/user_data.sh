#! /bin/bash

# Set timezone
sudo timedatectl set-timezone Europe/Warsaw

# Install Docker
sudo apt update -y
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli -y
sudo systemctl start docker
sudo systemctl enable docker

#AWS
sudo apt update
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure set aws_access_key_id ${aws_access_key}
aws configure set aws_secret_access_key ${aws_secret_key}
aws configure set default.region ${aws_region}

# Create a shell script to run the server by taking the image tagged as web-app:release from the ECR
cat <<EOT >start-website
/bin/sh -e -c 'echo $(aws ecr get-login-password --region ${aws_region}) | docker login -u AWS --password-stdin ${repository_url}'
sudo docker pull ${repository_url}:release
sudo docker run -d -p 80:8000 ${repository_url}:release
EOT

# Move the script into the specific amazon ec2 linux start up folder, in order for the script to run after boot
sudo mv start-website /var/lib/cloud/scripts/per-boot/start-website
sudo chmod +x /var/lib/cloud/scripts/per-boot/start-website

# Run the script
sudo /var/lib/cloud/scripts/per-boot/start-website
