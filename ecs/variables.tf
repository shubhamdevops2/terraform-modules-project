
variable "aws_region" {
  type    = string
  default = null
}

variable "vpc" {
}

variable "az_count" {
  default     = "2"
  description = "number of availability zones in above region"
}


variable "app_image" {
  default     = "sonarqube:latest"
  description = "docker image to run in this ECS cluster"
}

variable "app_port" {
  default     = "9000"
  description = "portexposed on the docker image"
}

variable "app_count" {
  default     = "2" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  default     = "2048"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "4096"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "subnet-private" {
  
}

variable "subnet-public" {
  
}

variable "aws_iam_role_ecs_task_execution_role_arn" {
  type = string
  default = null
}

variable "ecs_task_execution_role" {
    
}

