# Create VPC
resource "aws_vpc" "brightlab-localstack" {
  cidr_block   = "${var.cidr_block[0]}" # calling a variable from variables.tf file

  tags = {
    Name       = "Demo-localstack-VPC"
    CreatedBy  = "Bright"
  }
}

# Create Subnet

resource "aws_subnet" "brightlab-localstack-SB1" {
  vpc_id = "${aws_vpc.brightlab-localstack.id}"
  cidr_block   = "${var.cidr_block[1]}" # calling a variable from variables.tf file
  tags = {
    Name = "brightlab-localstack-SB1"
    Purpose = "LocalStack Demo"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "brightlab-localstack-igw" {
  vpc_id = "${aws_vpc.brightlab-localstack.id}"
  tags = {
    Name = "brightlab-localstack-igw"
    Purpose = "LocalStack Demo"
  }
}

#Create Security Group

resource "aws_security_group" "brightlab-localstack-Secgrp" {
  name = "brightlab-localstack-Secgrp"
  description = "Allow Access to my Lab"
  vpc_id = "${aws_vpc.brightlab-localstack.id}"

  dynamic ingress {
    iterator = bright
    for_each = var.ports
      content {
        from_port = bright.value
        to_port = bright.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "brightlab-localstack-Secgrp"
    Purpose = "LocalStack Demo"
  }
}

# Create A Route Table and associate with vpc

resource "aws_route_table" "brightlab-localstack-RT" {
  vpc_id = "${aws_vpc.brightlab-localstack.id}"
  route {
    cidr_block = "${var.cidr_block[2]}"
    gateway_id = "${aws_internet_gateway.brightlab-localstack-igw.id}"
  }
  tags = {
    Name = "brightlab-localstack-RT"
    Purpose = "LocalStack Demo"
  }
}

resource "aws_route_table_association" "brightlab-localstack-RT-association" {
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  route_table_id = "${aws_route_table.brightlab-localstack-RT.id}"
}

# EC2

resource "aws_instance" "brightlab-localstack-Jenkins" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  user_data = file("./installjenkins.sh")
 # ebs_block_device {
 #   device_name = "/dev/sda1"
 #   delete_on_termination = true
 # }

  tags = {
    Name = "brightlab-localstack-Jenkins-server"
    Purpose = "LocalStack Demo"
  }
}


resource "aws_instance" "brightlab-localstack-AnsiCtrller" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  user_data = file("./AnsictrlNode.sh")
 # ebs_block_device {
 #   device_name = "/dev/sda1"
 #   delete_on_termination = true
 # }
  tags = {
    Name = "brightlab-localstack-AnsiCtrller"
    Purpose = "LocalStack Demo"
  }
}


resource "aws_instance" "brightlab-localstack-AnsiMgedNode" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  #user_data = file("./AnsimgedNode.sh") 
  user_data = file("./installssm.sh")  
 # ebs_block_device {
 #   device_name = "/dev/sda1"
 #   delete_on_termination = true
 # }
  tags = {
    Name = "brightlab-localstack-Jenkins-AnsiMgedNode"
    Purpose = "LocalStack Demo"
  }
}

resource "aws_instance" "brightlab-localstack-AnsiMgedNode-Tomcat" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  user_data = file("./AnsimgedNode.sh")
 # ebs_block_device {
 #   device_name = "/dev/sda1"
 #   delete_on_termination = true
 # }

  tags = {
    Name = "brightlab-localstack-Jenkins-AnsiMgedNode-Tomcat"
    Purpose = "LocalStack Demo"
  }
}

resource "aws_instance" "brightlab-localstack-AnsiMgedNode-Docker" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  user_data = file("./Docker.sh")
#  root_block_device {
#    delete_on_termination = true
# }

  tags = {
    Name = "brightlab-localstack-Jenkins-AnsiMgedNode-Docker"
    Purpose = "LocalStack Demo"
  }
}

resource "aws_instance" "brightlab-localstack-AnsiMgedNode-Nexus" {
  ami = var.ami
  instance_type = var.instance_type_nuxus
  key_name = "dellatech-devops"
  vpc_security_group_ids = ["${aws_security_group.brightlab-localstack-Secgrp.id}"]
  subnet_id = "${aws_subnet.brightlab-localstack-SB1.id}"
  associate_public_ip_address = "true"
  user_data = file("./Installnexusoncentos.sh")
 # root_block_device {
 #   delete_on_termination = true
 #}

  tags = {
    Name = "brightlab-localstack-Jenkins-AnsiMgedNode-Nexus"
    Purpose = "LocalStack Demo"
  }
}
