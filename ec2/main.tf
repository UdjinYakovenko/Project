terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  version = "~>3.0"
  region   = var.region
}

resource "aws_instance" "Main" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = [aws_security_group.Security_Group.id]

  tags = {
    Name = "Main"
  }
}

resource "aws_instance" "Jenkins" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = [aws_security_group.Security_Group.id]

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "Docker" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = [aws_security_group.Security_Group.id]

  tags = {
    Name = "Docker"
  }
}

resource "aws_security_group" "Security_Group" {
  name        = "Security_Group"
  description = "Security_Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security_Group"
  }
}

output "jenkins_ip_address" {
  value = "${aws_instance.Jenkins.public_dns}"
}

output "docker_ip_address" {
  value = "${aws_instance.Docker.public_dns}"
}