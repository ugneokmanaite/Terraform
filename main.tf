# This is to launch AMI on AWS

# What do we want to do and where would we like to create an instance

# Syntax for terraform is similar to json - we use {} to write block of code



provider "aws" {

# which region do we have the AMI available in?

  region = "eu-west-1"

}

# Create an instance - launch an instace from the AMI 

resource "aws_instance" "Eng67_Ugne_App_Terraform" {
	
# What did we create that we would like to launch our ECU from? - AMI- add the id !

          ami          = "ami-0b56fdde9568aee06"


# What type of EC2 instance we want to create?

          instance_type = "t2.micro"

# Do we want to enable public IP

          associate_public_ip_address = true
          tags = {
            Name = "Eng67_Ugne_Terraform_EC2"
          }
}

# create subnet block of code
# attach this subnet to VPC

resource "aws_subnet" "public" {
	vpc_id     = var.VPC_ID
	cidr_block = var.subnetCIDRblock
	availability_zone = "eu-west-1a"
	map_public_ip_on_launch = true
	tags = {
	    Name = "Eng67_Ugne_Subnet_via_Terraform"
	}
}


# create security group and attach to VPC 
  resource "aws_security_group" "app" {
  name         = "eng67_ugne_app_sq"
  description   = "Allow http and https traffic"
  vpc_id       = "vpc-07e47e9d90d2076da"

# create ingress block of code

    ingress {
      description = "https from VPC"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
 }
 # create egress block of code
       egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
 }

}

