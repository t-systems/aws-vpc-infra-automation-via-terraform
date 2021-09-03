
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#setup-configuration">Setup Configuration</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#my-github-statistics">My GitHub Statistics</a></li>
  </ol>
</details>


***
 
<!-- ABOUT THE PROJECT -->

<details>
    <summary>AWS VPC Architecture</summary>
    
## About The Project
* [VPC Module Link](/aws-tf-modules/module.vpc)
* [VPC Endpoint Module Link](/aws-tf-modules/module.vpc-endpoints)

![VPC Automation via Terraform Modules][product-screenshot]

This project will provision a VPC with basic components as follows:
* VPC
* Subnets (Private, Public, DB)
* InternetGateway
* NAT Gateway (Highly Available)
* Route Tables
* VPC Endpoints (S3, EC2, ECR, CloudWatch)
* Bastion Host for SSH connection

</details>

***

### Built With

Used below tools:
* [Terraform](https://www.terraform.io/)
* [Packer](https://www.packerio/)



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
To run the terraform deployment from local we should have below installation in our local machine
* Terraform 
    - [Terraform Executable](https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip)
    - [Terraform Installation Doc.](https://learn.hashicorp.com/tutorials/terraform/install-cli)

* Install AWS Cli V2 
    - [AWS CLI Installation Doc.](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

* Install Packer
    - [Packer Executable](https://releases.hashicorp.com/packer/packer_1.7.4)

   

### Setup Configuration

* Configure IAM credentials for AWS access.
  
* Create bastion host AMI using packer
```
    cd packer/
    packer validate bastion-template.json    
    packer build bastion-template.json
```
* User can use below script to generate temporary credentials (Optional)
    ```sh
  #!/bin/bash
  
  AWS_REGION="us-east-1"
  token_duration="28800" # 8hrs
  role_arn='arn:aws:iam::AWS_ACCOUNT_ID:role/XXXX'
  
  STS=$(aws sts assume-role --role-arn $role_arn \
       --role-session-name TF-Session \
       --duration-seconds $token_duration \
       --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
       --output text --profile <PROFILE_NAME_IN_AWS_CREDENTIAL_FILE>)
  
  AWS_KEY=$(echo $STS | awk '{print $1}')
  AWS_SECRET=$(echo $STS | awk '{print $2}')
  AWS_TOKEN=$(echo $STS | awk '{print $3}')
  
  aws configure set profile.aws-admin.aws_access_key_id $AWS_KEY
  aws configure set profile.aws-admin.aws_secret_access_key $AWS_SECRET
  aws configure set profile.aws-admin.aws_session_token $AWS_TOKEN
  aws configure set profile.aws-admin.region $AWS_REGION
  ```
* If you are using any CI tool [GitLab pipelines, GitHub Action, Jenkins], then configure the aws credentials. In this example I am using GitHub Actions. 

  

<!-- CONTACT -->
## Contact

Vivek Mishra - [@linkedin](https://www.linkedin.com/in/vivek-mishra-22aa44bb55cc/) - vivekkmishra2020@gmail.com


<!-- GitHub Stats -->
## My GitHub Statistics

![Vivek Mishra github stats](https://github-readme-stats.vercel.app/api?username=vivek22117&show_icons=true&theme=tokyonight)
<img src="https://github-readme-streak-stats.herokuapp.com/?user=vivek22117&theme=tokyonight" alt="mystreak"/>
![Vivek's Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=vivek22117&theme=tokyonight&layout=compact)




<!-- MARKDOWN LINKS & IMAGES -->
[product-screenshot]: AWS-VPC.svg