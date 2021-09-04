#!/bin/bash

profile_name='default'
token_duration="14400"

# IAM role with required permission to create resources
role_arn='arn:aws:iam::AWS_ACCOUNT_ID:role/AWSInfrastructureAdministratorRole'

# MFA serial of user who is going to assume the above role
mfa_serial='arn:aws:iam::AWS_ACCOUNT_ID:mfa/default'
read -p "Enter MFA token: " MFA_TOKEN

STS=$(aws sts assume-role --role-arn $role_arn \
      --role-session-name TF-Session --duration-seconds $token_duration \
      --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
      --output text --serial-number $mfa_serial --token-code $MFA_TOKEN --profile $profile_name)

AWS_KEY=$(echo $STS | awk '{print $1}')
AWS_SECRET=$(echo $STS | awk '{print $2}')
AWS_TOKEN=$(echo $STS | awk '{print $3}')


# cg-admin profile will be created int the .aws/credentials file
aws configure set profile.cg-admin.aws_access_key_id $AWS_KEY
aws configure set profile.cg-admin.aws_secret_access_key $AWS_SECRET
aws configure set profile.cg-admin.aws_session_token $AWS_TOKEN
aws configure set profile.cg-admin.region us-east-1