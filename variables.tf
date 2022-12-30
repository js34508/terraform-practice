variable "region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform - Jeff"
}

