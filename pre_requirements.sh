#!/bin/bash

cat <<EOF
############################################################
## Install AWS CLI #########################################
############################################################
EOF
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

cat <<EOF
************************************************************
** Attention: **********************************************
************************************************************
Please go to and define a new access key:
https://console.aws.amazon.com/iam/home?#/security_credentials
Then run:
aws configure
EOF
rm -rf aws  awscliv2.zip


cat <<EOF
############################################################
## Install AWS IAM Authenticator ###########################
############################################################
EOF
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/local/bin
aws-iam-authenticator help


cat <<EOF
############################################################
## Install Kubectl #########################################
############################################################
EOF
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client


cat <<EOF
############################################################
## Install Helm ############################################
############################################################
EOF
wget https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz
tar -zxvf helm-v3.2.4-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
rm helm-v3.2.4-linux-amd64.tar.gz 
rm -rf linux-amd64
