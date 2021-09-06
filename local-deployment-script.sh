#!/usr/bin/env bash


STATUS_CODE=$(aws configure list --profile default1)
echo $STATUS_CODE

if [ $STATUS_CODE -eq 256 ]; then
    echo "AWS profile named 'default' is required!"
    exit 1
fi

read -p "Enter aws profile name to access aws account: " AWS_PROFILE
read -p "Enter default region: " AWS_REGION
read -p "Environment to deploy, valid values 'qa', 'test', 'prod':" ENV

read -p "Do you want to deploy TF backend resources? Valid values 'yes' OR 'no':" ENABLE_TF_BACKEND


function terraform_backend_deployment() {
    echo ============================== Starting Terraform Backend Deployment =========================

    cd aws-terraform-backend

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var="default_region=$AWS_REGION"
#    terraform apply -var="default_region=$AWS_REGION" -auto-approve

    cd ..
}


function s3_bucket_resources_deployment() {
    echo ============================== Starting S3 Bucket Resource Deployment =========================

    cd deployment/s3-buckets

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var="default_region=$AWS_REGION" -var-file=$ENV.tfvars
#    terraform apply -auto-approve

    cd ../..
}



terraform_backend_deployment
s3_bucket_resources_deployment
ls


