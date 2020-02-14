<!DOCTYPE html>
<html>
<body>

<p>
Resources provisioned on AWS for CPWI infrastructure

1 - EC2 backend instance 1 - T3.Medium
2 - EC2 backend  instance 2 -  T3.Medium
3 - EC2 frontend  instance 1 -  T3.Medium
4 - RDS DB  instance 1 -  T3.Medium
5 - Elasticache instance : Redis 
6 - S3 Bucket with iam user policy
7 - Load Balancer (associated with 1 & 2 instances)
8 - Access key to access EC2 instances.
9 - VPC with public private subnets.</p>

<p>
Clone the files in your local system.
Please add secret and access key in secrets.tfvars file before start.
Run terraform init command in same directory.
</p>
