resource "aws_instance" "frontend_server" {
  ami = "${var.ami}"
  instance_type = "${var.instancetype}"
  key_name = "${aws_key_pair.cpwi_key.key_name}"
  subnet_id = "${aws_subnet.subnet_pub1.id}"
  vpc_security_group_ids = ["${aws_security_group.cpwi-sg.id}"]
  tags = {
    Name = "frontend_server"

    }

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

}

resource "aws_eip" "eip" {
instance = "${aws_instance.frontend_server.id}"
vpc      = true
}

resource "aws_instance" "backend_server1" {
  ami = "${var.ami}"
  instance_type = "t3.medium"
  key_name = "${aws_key_pair.cpwi_key.key_name}"
  subnet_id = "${aws_subnet.subnet_pub2.id}"
  vpc_security_group_ids = ["${aws_security_group.cpwi-sg.id}"]
  tags = {
    Name = "backend_server1"

    }

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

}

resource "aws_eip" "eip_bckend1" {
instance = "${aws_instance.backend_server1.id}"
vpc      = true
}

resource "aws_instance" "backend_server2" {
  ami = "${var.ami}"
  instance_type = "t3.medium"
  key_name = "${aws_key_pair.cpwi_key.key_name}"
  subnet_id = "${aws_subnet.subnet_pub1.id}"
  vpc_security_group_ids = ["${aws_security_group.cpwi-sg.id}"]
  tags = {
    Name = "backend_server2"

    }

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

}

resource "aws_eip" "eip_bckend2" {
instance = "${aws_instance.backend_server2.id}"
vpc      = true
}


