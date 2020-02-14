variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
 default = "ap-south-1"
}

variable "instancetype" {
 default = "t3.medium"
}

variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "ami" {
 default = "ami-0123b531fc646552f"
}

variable "dbuser" {}
variable "dbpassword" {}

variable "rdsname" {
 default = "cpwi"
}

variable "rdsdb" {
 default = "cpwi"
}

variable "rdsvolume" {
 default = "30"
}

variable "rdsengine" {
 default = "postgres"
}

variable "rdsinstance" {
 default = "db.t3.small"
}

variable "rds_public_subnet_group" {
  default = "vpc-05a284e75ca40b0b3"
}
