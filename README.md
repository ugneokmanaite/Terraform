# Infrastructure as code with Terraform

![image](https://www.groupwaretech.com/wp-content/uploads/2018/10/Terraform-300x300.png)

There are 2 sides of IAC

1. Configuration Management - Ansible
2. Orchestration - Terraform

## What is Orchestration??
Orchestration is the automated configuration, coordination, and management of computer systems and software

## What is Terraform?
- Tool for building, changing and versioning infrastructure safely and efficiently

- Can manage popular service providers as well as custom in-house solutions

- Can be linked with any cloud providers- therefore Terraform is cloud-agnostic and allows single configuration to be used to manage multiple providers & to handle cross-cloud dependencies

- This simplifies management and orchestration, helping operators build large-scale multi cloud infrastructures 


-  Kubernetes- used in orchestration in containerisation

## Terraform vs Ansible
- https://selleo.com/blog/terraform-vs-ansible
- Terraform follows immutability = it is a provisioning tool that deals with immutable infrastructure
- This makes it a good choice when you reject conf mang tools
- More intuitive for infrastructureorchestration

- Ansible is optimized for config management 

- Can be used together or independantly 

# Introduction to Terraform set up

* Useful link in creating an AWS VPC, Subnet, SG, ACL using Terraform : https://medium.com/@brad.simonin/create-an-aws-vpc-and-subnet-usi

## Step 1: Create main.tf file
- This is to launch an AMI on AWS

## Step 2:Create file called variables.tf
- This creates reusable variables to use in main.tf

## Step 3: Edit main.tf 

```
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


```

## Step 4:
 ` terraform init`

![image](https://github.com/ugneokmanaite/Terraform-/blob/master/images/terraform_init.JPG)

## Step 5: ADD AWS Secret and access keys

- Add these to your machine environment variables
- in settings !
![image](https://github.com/ugneokmanaite/Terraform-/blob/master/images/edit%20system%20variables.JPG)

## Step 6: Add required variables 

```
variable "vpc_id" {
  type = string
  default = "vpc-0733dd8d62bc3d5eb"
}

variable "name" {
  type = string
  default = "Eng67_Ugne_Terraform_EC2"
}

 variable "vpcCIDRblock" {
   type = string
   default= "172.31.0.0/16"
 }

variable "subnetCIDRblock" {
	type = string
	default = "172.31.11.0/24"
}

variable "VPC_ID"{
	type = string
	default= "vpc-07e47e9d90d2076da"
}
```

## Step 7: Run the following commands to run

```terraform plan ```
 checks the steps inside the code and lists successful or errors

```terraform apply```
 will implement the code - deploy the infastructure







