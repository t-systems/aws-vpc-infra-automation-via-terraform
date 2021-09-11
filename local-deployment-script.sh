#!/usr/bin/env bash


echo ====================================== Info =======================================================
echo "The below script will first create terraform backend resources that is S3 bucket and DynamoDB table.
They will be used in other modules to store the TF state file"
echo -e "===============================================================================================\n\n"


echo ============================== Reading AWS Default Profile ====================================
aws configure list --profile default >/dev/null 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -eq 256 ]; then
    echo "'default' aws profile does not exit, please create!"
    exit 1
else
  echo "'default' aws profile exists! Let's provision some AWS resources."
fi


echo -e "\n\n =========================== Fetch AWS Account Id ======================================"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text --profile default)
if [ -z $AWS_ACCOUNT_ID  ]; then
    echo "Credentials are not valid!"
    exit 1
else
  echo $AWS_ACCOUNT_ID
fi


echo -e "\n\n =========================== Choose Terraform Execution Type ==========================="

PS3="Select the terraform execution type: "

select EXEC_TYPE in apply destroy
do
    echo "You have decided to $EXEC_TYPE the AWS resources!"
    break
done


echo -e "\n\n ============================= Choose AWS Region ======================================="

PS3="Select aws region to deploy the resources: "

select AWS_REGION in us-east-1 us-east-2 eu-central-1 eu-west-1 eu-west-2 ap-south-1
do
    echo "You have selected $AWS_REGION to deploy the resources!"
    break
done


echo -e "\n\n ======================= Choose Environment To Deploy =================================="

PS3="Select environment to deploy: "

select ENV in qa test prod
do
    echo "You have selected $ENV environment for deployment"
    break
done


function terraform_backend_deployment() {
    echo -e "\n\n==================== Starting Terraform Backend Deployment ========================="

    cd aws-terraform-backend

    sed -i '/profile/s/^#//g' providers.tf
    sed -i '/backend/,+4d' providers.tf

    terraform init
    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION"
    terraform apply -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve

    cd ..

    echo -e "========================= Completed ================================================ \n\n"
}


function s3_bucket_resources_deployment() {
    echo -e "\n\n===================== Starting S3 Bucket Resource Deployment ========================="

    cd deployment/s3-buckets

    sed -i '/profile/s/^#//g' providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" config/$ENV-backend-config.config

    terraform init -backend-config="config/$ENV-backend-config.config" \
    -backend-config="bucket=$ENV-tfstate-$AWS_ACCOUNT_ID-$AWS_REGION"

    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION"
    terraform apply -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -auto-approve

    cd ../..

    echo -e "============================== Completed =============================================== \n\n"
}


function deploy_vpc_network() {
    echo -e "\n\n ====================== Creating Bastion host AMI using Packer ========================="
    echo "Checking whether AMI exists"
    BASTION_AMI_ID=$(aws ec2 describe-images --filters "Name=tag:Name,Values=Bastion-AMI" --query 'Images[*].ImageId' --region $AWS_REGION --profile default --output text)

    if [ -z $BASTION_AMI_ID ]; then
      echo "Creating AMI named bastion-host-YYYY-MM-DD using packer as it is being used in Terraform script"

      cd packer/bastion
      packer validate bastion-template.json
      packer build -var "aws_profile=default" -var "default_region=$AWS_REGION" bastion-template.json
      cd ../..
    else
      echo "AMI exits with id $BASTION_AMI_ID, now creating VPC resources.."
    fi


    echo -e "\n\n ========================= Starting vpc network deployment using TF ====================="

    cd deployment/vpc

    sed -i '/profile/s/^#//g' providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" config/$ENV-backend-config.config

    terraform init -backend-config="config/$ENV-backend-config.config" \
    -backend-config="bucket=$ENV-tfstate-$AWS_ACCOUNT_ID-$AWS_REGION"

    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
    terraform apply -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve

    cd ../..

    echo -e "============================== Completed ================================================ \n\n"
}

function deploy_vpc_endpoint_resources() {
    echo -e "\n\n ============================== Starting VPC Endpoint Deployment ========================"

    cd deployment/vpc-endpoints

    sed -i '/profile/s/^#//g' providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" config/$ENV-backend-config.config

    terraform init -backend-config="config/$ENV-backend-config.config" \
    -backend-config="bucket=$ENV-tfstate-$AWS_ACCOUNT_ID-$AWS_REGION"

    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
    terraform apply -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve

    cd ../..

    echo -e "=============================== Completed ================================================\n\n"
}


function deploy_ecs_cluster_resources() {
    echo -e "\n\n ============================== Creating ECS AMI using Packer ==========================="
    echo "Check whether AMI exists"
    ECS_AMI_ID=$(aws ec2 describe-images --filters "Name=tag:Name,Values=ECS-AMI" --query 'Images[*].ImageId' --region $AWS_REGION --profile default --output text)

    if [ -z $ECS_AMI_ID ]; then
      echo "Creating AMI named ecs-ami-YYYY-MM-DD using packer as it is being used in Terraform script"

      cd packer/ecs-ami
      packer validate ecs-template.json
      packer build -var "aws_profile=default" -var "default_region=$AWS_REGION" ecs-template.json

      cd ../..
    else
      echo "AMI exits with id $ECS_AMI_ID, now creating VPC resources.."
    fi



    echo -e "\n\n ============================== Starting ECS Cluster Deployment ========================="

    cd deployment/ec2-ecs-cluster

    sed -i '/profile/s/^#//g' providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" providers.tf
    sed -i "s/us-east-1/$AWS_REGION/g" config/$ENV-backend-config.config

    terraform init -backend-config="config/$ENV-backend-config.config" \
    -backend-config="bucket=$ENV-tfstate-$AWS_ACCOUNT_ID-$AWS_REGION"

    terraform plan -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV"
    terraform apply -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve

    cd ../..

    echo -e "============================== Completed =============================================\n\n"
}




if [ $EXEC_TYPE == 'apply' ]; then

    terraform_backend_deployment
    s3_bucket_resources_deployment
    deploy_vpc_network
    deploy_vpc_endpoint_resources
    deploy_ecs_cluster_resources
fi



if [ $EXEC_TYPE == 'destroy' ]; then
  echo -e "\n\n ============================ Destroying ECS Cluster Resources ========================="
  cd deployment/ec2-ecs-cluster
  terraform destroy -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve
  cd ../..

  echo -e "\n\n =========================== Destroying VPC Endpoint Resources ========================="
  cd deployment/vpc-endpoints
  terraform destroy -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve
  cd ../..

  echo -e "\n\n ========================== Destroying VPC Resources ==================================="
  cd deployment/vpc
  terraform destroy -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve
  cd ../..

  echo -e "\n\n ========================= Destroying S3 Resources ====================================="
  cd deployment/s3-buckets
  terraform destroy -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve
  cd ../..

  echo -e "\n\n ========================= Destroying Backend TF Resources =============================="
  cd aws-terraform-backend
  terraform destroy -var-file="$ENV.tfvars" -var="default_region=$AWS_REGION" -var="environment=$ENV" -auto-approve
  cd ..
  
  
  echo -e "\n\n ========================= =============================== =============================="
  PS3="Do you want to deregister & delete Bastion & ECS AMI? Select by inserting the number: "

  select AMI_DELETE_FLAG in Yes No
  do
      echo "Your input is $AMI_DELETE_FLAG, deleting AMIs..........."
      break
  done
  
  if [ $AMI_DELETE_FLAG=="true" ]; then

      BASTION_AMI_ID=$(aws ec2 describe-images --filters "Name=tag:Name,Values=Bastion-AMI" --query 'Images[*].ImageId' --region $AWS_REGION --profile default --output text)

      if [ -z $BASTION_AMI_ID ]; then
          aws ec2 deregister-image --image-id $BASTION_AMI_ID --region $AWS_REGION

          BASTION_SNAPSHOT=$(aws ec2 describe-snapshots --owner-ids self --filters Name=tag:Name,Values=Bastion-AMI --query "Snapshots[*].SnapshotId" --output text --region $AWS_REGION)
          for ID in $BASTION_SNAPSHOT;
          do
            aws ec2 delete-snapshot --snapshot-id $ID --region $AWS_REGION
            echo ====================== Bastion Host AMI Delete Successfully =============================
          done
      fi




      ECS_AMI_ID=$(aws ec2 describe-images --filters "Name=tag:Name,Values=ECS-AMI" --query 'Images[*].ImageId' --region $AWS_REGION --profile default --output text)

      if [ -z $ECS_AMI_ID ]; then
        aws ec2 deregister-image --image-id $ECS_AMI_ID --region $AWS_REGION

        ECS_SNAPSHOT=$(aws ec2 describe-snapshots --owner-ids self --filters Name=tag:Name,Values=ECS-AMI --query "Snapshots[*].SnapshotId" --output text --region $AWS_REGION)

        for ID in $ECS_SNAPSHOT;
        do
          aws ec2 delete-snapshot --snapshot-id $ID --region $AWS_REGION
          echo ======================== ECS AMI Deleted Successfully ======================================
        done
      fi

  fi

fi