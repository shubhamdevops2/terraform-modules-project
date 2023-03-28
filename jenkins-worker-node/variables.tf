variable "aws_region" {
  type    = string
  default = null
}

variable "AMIS" {
    type = map
    default = {
        ap-southeast-1 = "ami-0f74c08b8b5effa56"
        ap-east-1 = "ami-038ff3475cbb62351"
        ap-south-1 = "ami-0cca134ec43cf708f"
    }  
}

variable "key-name" {
    default = null
    type = string
}

variable "subnet-public" {
  
}

variable "vpc" {
  
}