#CREATE RDS SUBNET GROUPS

resource "aws_db_subnet_group" "rds_subnet_groups" {
  name       = "cpwi_subnet_group"
  subnet_ids = ["${aws_subnet.subnet_pub1.id}", "${aws_subnet.subnet_pub2.id}"]

  tags = {
    Name = "cpwi_subnet_group"
  }
}

resource "aws_security_group" "rds" {
  name = "rds"

  description = "RDS postgres servers"
  vpc_id = "${aws_vpc.cpwi_vpc.id}"

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_db_instance" "cpwi_rds" {
  identifier           = "${var.rdsname}"
  allocated_storage    = "${var.rdsvolume}"
  storage_type         = "gp2"
  engine               = "${var.rdsengine}"
  engine_version       = "9.6.9"
  instance_class       = "${var.rdsinstance}"
  name                 = "${var.rdsdb}"
  username             = "${var.dbuser}"
  password             = "${var.dbpassword}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  db_subnet_group_name   = "cpwi_subnet_group"
  port                = "5432"
  backup_retention_period = "7"
  multi_az                = "false"
  publicly_accessible     = "true"
  tags = {
    Name = "cpwi_rdspostgres"
  }
}
