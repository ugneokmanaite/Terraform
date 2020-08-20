# Infrastructure as code with Terraform

## What is Terraform?

There are 2 sides of IAC

1. Configuration Management - Ansible
2. Orchestration - Ochestration 


Kubernetes- used in orchestration in containerisation


Terraform
- Can be linked with any cloud providers

Creating Terraform files

1. Create main.tf
- This is to launch an AMI on AWS

2. Create file called variables.tf
- This creates reusable variables to use in main.tf

3. Edit main.tf 

```
provider "aws" {

# which region do we have the AMI available in?

  region = "eu-west-1"

}
```

4. ` terraform init`

![image](terraform_init)

5. Add AMI id in main.tf

```
resource "aws_instance" "Eng67.Ugne.App.Instance" {

          ami          = "ami-0b56fdde9568aee06"

}
```

5. Add info about the type of instance we would like to create in main.tf
- t2micro
`instance_type = "t2.micro"`

6. Enable public IP
```
associate_public_ip_address = true
          tags = {
            Name = "Eng67_Ugne_Terraform_EC2"
          }
```
7. Some commands

```terraform plan = checks the steps inside the code and lists successful or errors

terraform apply - will implement the code - deploy the infastructure
```

* make sure to run plan before apply




