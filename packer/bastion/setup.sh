#!/usr/bin/env bash

sudo yum update -y
sudo yum install unzip -y
sudo yum install -y yum-utils
sleep 5

sudo yum install git -y

echo "Install SSM-Agent"
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent


echo "Install Terrafrom"
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

terraform -v


echo "Install Packer"
sudo yum update -y
sudo wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip
sudo unzip packer_1.7.4_linux_amd64.zip
sudo mv packer /usr/local/bin/

echo "Install AWS Cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo  ./aws/install -i /usr/local/aws-cli -b /usr/local/bin


echo "SUCCESS! Installation succeeded!"
