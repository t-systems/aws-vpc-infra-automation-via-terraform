
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

![VPC Automation via Terraform Modules][vpc-screenshot]

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

<details>
    <summary>AWS EC2 ECS Architecture Using VPC Endpoints</summary>
    
## About The Project
* [ECS Module Link](/aws-tf-modules/module.ec2-ecs-cluster)

![VPC Automation via Terraform Modules][ecs-screenshot]

This project will provision ECS cluster in private subnet and uses VPC endpoints for communication:
* EC2 ECS Cluster
* Security Groups
* Launch Template & Autoscaling Group
* Elastic LoadBalancer (Application)
* IAM role for ECS 

</details>

***

### Built With

Used below tools:
* [Terraform](https://www.terraform.io/)
* [Packer](https://www.packerio/)



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
To run the terraform deployment from local we should have below installation in our machine
* Terraform 
    - [Terraform Executable](https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip)
    - [Terraform Installation Doc.](https://learn.hashicorp.com/tutorials/terraform/install-cli)

* Install AWS Cli V2 
    - [AWS CLI Installation Doc.](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

* Install Packer
    - [Packer Executable](https://releases.hashicorp.com/packer/packer_1.7.4)



### Setup Configuration

* Configure IAM credentials to access AWS environment.
* To trigger the deployment of all the TF modules, please use below script.
    - [Local Deployment Script](local-deployment-script.sh)
  ```
    ./local-deployment-script.sh >> output-logs.txt
  ```
* User can use below script to generate temporary credentials (Optional)
    - [Generate AWS Temporary Credentials](/assume-role-script.sh)
* Terraform backend configuration using S3 & DynamoDB table (Optional)
    - [AWS Resources For TF Backend](aws-terraform-backend)
* If you are using any CI tool **GitLab pipelines, GitHub Action, Jenkins** then configure the aws credentials accordingly. In this example I am using GitHub Actions to provision AWS resources. 
    - [VPC Infra Automation](.github/workflows/vpc-infra-pipeline.yml)
    - [S3 Buckets](.github/workflows/s3-buckets-infra-pipeline.yml)
    - [VPC Endpoints Automation](.github/workflows/vpc-endpoints-pipeline.yml)
    - [EC2 ECS Cluster](.github/workflows/ec2-ecs-cluster-pipeline.yml)
* Some useful terraform & aws commands
    - [Terraform commands](terraform-aws-commands)


<!-- CONTACT -->
## Contact

Vivek Mishra - [@linkedin](https://www.linkedin.com/in/vivek-mishra-22aa44bb55cc/) - vivekkmishra2020@gmail.com


<!-- GitHub Stats -->
## My GitHub Statistics

![Vivek Mishra github stats](https://github-readme-stats.vercel.app/api?username=vivek22117&show_icons=true&theme=tokyonight)
<img src="https://github-readme-streak-stats.herokuapp.com/?user=vivek22117&theme=tokyonight" alt="mystreak"/>
![Vivek's Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=vivek22117&theme=tokyonight&layout=compact)




<!-- MARKDOWN LINKS & IMAGES -->
[vpc-screenshot]: images/AWS-VPC.svg
[ecs-screenshot]: images/AWS-ECS-Cluster.svg