#! /bin/bash

# Install Java
sudo apt update -y
sudo apt install openjdk-11-jre -y

# Install jq and mc
sudo apt install jq -y
sudo apt install mc -y

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install Docker
sudo apt update -y
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli -y
sudo systemctl start docker
sudo systemctl enable docker

# AWS
sudo apt update 
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure set aws_access_key_id ${aws_access_key}
aws configure set aws_secret_access_key ${aws_secret_key}
aws configure set default.region ${aws_region}

# Let Jenkins and the current user use docker
sudo usermod -a -G docker ubuntu
sudo usermod -a -G docker jenkins

# Create the opt folder in the jenkins home
sudo mkdir /var/lib/jenkins/opt
sudo chown jenkins /var/lib/jenkins/opt
sudo chgrp jenkins /var/lib/jenkins/opt

# Download and install arachni as jenkins user
wget https://github.com/Arachni/arachni/releases/download/v1.6.1.3/arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz
tar -zxf arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz
rm arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz
sudo chown -R jenkins arachni-1.6.1.3-0.6.1.1/
sudo chgrp -R jenkins arachni-1.6.1.3-0.6.1.1/
sudo mv arachni-1.6.1.3-0.6.1.1 /var/lib/jenkins/opt

# Save the instance_id, repositories urls and bucket name to use in the pipeline
sudo /bin/bash -c "echo ${repository_url} > /var/lib/jenkins/opt/repository_url" &&
sudo /bin/bash -c "echo ${repository_test_url} > /var/lib/jenkins/opt/repository_test_url" &&
sudo /bin/bash -c "echo ${repository_staging_url} > /var/lib/jenkins/opt/repository_staging_url" &&
sudo /bin/bash -c "echo ${instance_id} > /var/lib/jenkins/opt/instance_id" &&
sudo /bin/bash -c "echo ${bucket_logs_name} > /var/lib/jenkins/opt/bucket_name"

# Change ownership and group of these files
sudo chown -R jenkins /var/lib/jenkins/opt/
sudo chgrp -R jenkins /var/lib/jenkins/opt/

# Wait for Jenkins to boot up
sudo sleep 60

# DEFINE THE GLOBAL VARIABLES
export url="http://${public_dns}:8080"
export user="${admin_username}"
export password="${admin_password}"
export admin_fullname="${admin_fullname}"
export admin_email="${admin_email}"
export remote="${remote_repo}"
export jobName="${job_name}"
export jobID="${job_id}"

# COPY THE CONFIG FILES FROM S3
sudo aws s3 cp s3://${bucket_config_name}/ ./ --recursive
sudo chmod +x *.sh

# RUN THE CONFIG FILES
./create_admin_user.sh
./download_install_plugins.sh
sudo sleep 120
./confirm_url.sh
./create_credentials.sh

# Output the credentials id in a credentials_id file
python3 -c "import sys;import json;print(json.loads(input())['credentials'][0]['id'])" <<< $(./get_credentials_id.sh) > credentials_id

./create_multibranch_pipeline.sh

# DELETE THE CONFIG FILES
sudo rm *.sh credentials_id

sudo reboot
