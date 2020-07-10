# The EKS, the Prometheus and the Wardrobe

Here we setup AWS-EKS and Prometheus as our playground to learn more!

*****Attention:** If you are looking to setup a production-grade Kubernetes cluster on AWS this is not the solution, please read [this](https://gruntwork.io/guides/kubernetes/how-to-deploy-production-grade-kubernetes-cluster-aws/#kubernetes-architecture) article.

## Setup EKS:

We are followin [this hashicorp article](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster) which will help us to set up an experimental EKS, in the time that I was trying to use it there was a bug inside it that they didn't fix, therefore, you can find a clone of it here without any problem, let's go to the steps:

```
git clone https://github.com/pesarkhobeee/The-EKS-the-Prometheus-and-the-Wardrobe.git
cd The-EKS-the-Prometheus-and-the-Wardrobe
head learn-terraform-provision-eks-cluster/vpc.tf
```
As you can see we are using `eu-central-1` as the default AWS region but you can change it to whatever suit you better, not it is time to check if we have all pre requirements, we need `aws cli`, `aws-iam-authenticator`, `kubectl`, `terraform` and `helm`, if you don't have them I create a script to install them, the assumption is that you are using a 64bit Linux OS otherwise you should find out how you should install them on you OS, but for the Linux users it is easy:

```
./pre_requirements.sh
```

The next step as it was written in the script output is:

```
Please go to this link and define a new access key:
https://console.aws.amazon.com/iam/home?#/security_credentials
Then run:
aws configure
```

Alright, we are ready to finally set up our AWS EKS by the help of Terraform, it will take around 15 minutes:

```
cd learn-terraform-pr******************************************************ovision-eks-cluster
terraform init
terraform apply
```

## Configure kubectl:

Now that you've provisioned your EKS cluster, you need to configure kubectl. Customize the following command with your cluster name and region, the values from Terraform's output. It will get the access credentials for your cluster and automatically configure kubectl

```
aws eks --region eu-central-1 update-kubeconfig --name training-eks-sR8eLIil
```

The Kubernetes cluster name and region correspond to the output variables showed after the successful Terraform run.

You can view these outputs again by running:

```
terraform output
```

At the end you should be able to see three nodes by running:

```
kubectl get nodes
```

## Setup Prometheus:

We are using Helm to setup [Prometheus operator](https://github.com/helm/charts/tree/master/stable/prometheus-operator) on our K8s cluster, I have created a script to make it simple, just run:

```
./monitoring.sh
```

After running this script you can see how you can go further, some output like these:

```
NOTES:
The Prometheus Operator has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=monitoring"

Visit https://github.com/coreos/prometheus-operator for instructions on how
to create & configure Alertmanager and Prometheus instances using the Operator.
############################################################
## You can access Prometheus after running below command: ##
############################################################
kubectl --namespace monitoring port-forward services/prometheus-operated 9090
############################################################
## You can access Grafana after running below command:    ##
############################################################
kubectl --namespace monitoring port-forward services/monitoring-grafana 9091:80
############################################################
## Grafana's Admin user password: ##########################
############################################################
prom-operator
```


