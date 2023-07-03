# DotPay Development Infrastructure

## Technologies used:
1. Terraform
2. Kubernetes

<br/><br/>
<br/><br/>
#
---



See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes servers. Feel free to replace this as necessary.

```
terraform init

terraform plan

terraform destroy
```

This configuration was adapted from [Terraform - EKS: Getting Started](https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html)
