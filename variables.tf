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
