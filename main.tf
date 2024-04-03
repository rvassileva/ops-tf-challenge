provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Creating an AWS instance
resource "aws_instance" "ec2_test" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "My Test Instance"
  }
}

# Adding null resource; the trigger will only execute once when it detects the instance id of EC2 instance 
resource "null_resource" "null_resource_test" {
  triggers = {
    id = aws_instance.ec2_test.id
  }
  provisioner "local-exec" {
    command = "echo This is a great test!"
  }
}