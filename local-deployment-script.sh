#!/usr/bin/env bash


aws configure list --profile default >/dev/null 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -eq 256 ]; then
    echo "'default' aws profile is required!"
    exit 1
fi

read -p "Enter default region: " AWS_REGION
echo
read -p "Environment to deploy, valid values 'qa', 'test', 'prod':" ENV
echo
read -p "Do you want to deploy TF backend resources? Valid values 'yes' OR 'no':" ENABLE_TF_BACKEND
echo

function terraform_backend_deployment() {
    echo ============================== Starting Terraform Backend Deployment =========================

    cd aws-terraform-backend

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var="default_region=$AWS_REGION"
#    terraform apply -var="default_region=$AWS_REGION" -auto-approve

    cd ..

    echo ================================ IMPORTANT ===================================================
    echo "Now update the Bucket Name & DynamoDB table name in the backend-config file for all
    other modules which you want to deploy. Config file path 'deployment/vpc', 'deployment/vpc-endpoints'
    , 'deployment/ec2-ecs-cluster'. After updating re-run this script with 'no' for backend resources!"
    echo ================================= ENDS =======================================================
    exit 1
}


function s3_bucket_resources_deployment() {
    echo ============================== Starting S3 Bucket Resource Deployment =========================

    cd deployment/s3-buckets

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION"
#    terraform apply -auto-approve

    cd ../..
}


function deploy_vpc_network() {
    echo ============================== Creating AMI using Packer =========================

    echo "First we will create AMI named bastion-host-YYYY-MM-DD using packer \n
          as it is used in Terraform script"

    cd packer/bastion

    packer validate bastion-template.json
    packer build -var "aws_profile=default" -var "default_region=$AWS_REGION" bastion-template.json

    cd ../..

    echo ========================= Starting vpc network deployment using TF ====================

    cd deployment/vpc

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" providers.tf

    terraform init
    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
#    terraform apply -auto-approve

    cd ../..
}

function deploy_vpc_endpoint_resources() {
    echo ============================== Starting VPC Endpoint Deployment =========================

    cd deployment/vpc-endpoints

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
#    terraform apply -auto-approve

    cd ../..
}


function deploy_ecs_cluster_resources() {
    echo ============================== Starting ECS Cluster Deployment =========================

    cd deployment/ec2-ecs-cluster

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
#    terraform apply -auto-approve

    cd ../..
}



if [ $ENABLE_TF_BACKEND -eq "yes" ]; then
    terraform_backend_deployment
fi

s3_bucket_resources_deployment
deploy_vpc_network


