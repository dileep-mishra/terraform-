provider "aws" {

 access_key = "${var.aws_access_key}"
 secret_key = "${var.aws_secret_key}"
 region = "${var.region}"
}

resource "aws_vpc" "cpwi_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "cpwi_vpc"
  }
}

resource "aws_subnet" "subnet_priv1" {

   vpc_id = "${aws_vpc.cpwi_vpc.id}"
   cidr_block = "10.0.1.0/24"
   availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet_priv-1a"
  }
}

resource "aws_subnet" "subnet_priv2" {

   vpc_id = "${aws_vpc.cpwi_vpc.id}"
   cidr_block = "10.0.2.0/24"
   availability_zone = "ap-south-1b"

   tags = {
   Name = "subnet_priv-1b"
}
}

resource "aws_subnet" "subnet_pub1" {

   vpc_id = "${aws_vpc.cpwi_vpc.id}"
   cidr_block = "10.0.3.0/24"
   availability_zone = "ap-south-1a"

 tags = {
 Name = "subnet_pub-1a"
}
}

resource "aws_subnet" "subnet_pub2" {

   vpc_id = "${aws_vpc.cpwi_vpc.id}"
   cidr_block = "10.0.4.0/24"
   availability_zone = "ap-south-1b"
   tags = {
   Name = "subnet_pub-1b"
}

}

//gateways.tf
resource "aws_internet_gateway" "cpwi-gw" {
  vpc_id = "${aws_vpc.cpwi_vpc.id}"

}

resource "aws_route_table" "cpwi_route" {
  vpc_id = "${aws_vpc.cpwi_vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cpwi-gw.id}"
  }
}

resource "aws_route_table_association" "subnet-association1" {
  subnet_id      = "${aws_subnet.subnet_pub1.id}"
  route_table_id = "${aws_route_table.cpwi_route.id}"
}

resource "aws_route_table_association" "subnet-association2" {
  subnet_id      = "${aws_subnet.subnet_pub2.id}"
  route_table_id = "${aws_route_table.cpwi_route.id}"
} 

#CREATE ELASTIC IP FOR NAT GW

resource "aws_eip" "eip-nat" {
vpc      = true
}

#CREATE NAT GATEWAY IN EXISTING VPC

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.eip-nat.id}"
  subnet_id     = "${aws_subnet.subnet_pub2.id}"

  tags = {
    Name = "gw NAT"
  }
}

#CREATE ROUTE TABLE INCLUDE NAT

resource "aws_route_table" "route_NAT" {
  vpc_id = "${aws_vpc.cpwi_vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }
 tags = {
 Name = "route_with_NAT"
}
}

#ASSOCIATE PRIVATE SUBNET WITH THIS ROUTE TABLE

resource "aws_route_table_association" "subnet-association1a" {
  subnet_id      = "${aws_subnet.subnet_priv1.id}"
  route_table_id = "${aws_route_table.route_NAT.id}"
}

resource "aws_route_table_association" "subnet-association1b" {
  subnet_id      = "${aws_subnet.subnet_priv2.id}"
  route_table_id = "${aws_route_table.route_NAT.id}"
}

