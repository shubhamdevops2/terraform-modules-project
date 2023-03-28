variable "aws_region" {
  default = null
  type = string
}



data "aws_availability_zones" "available" {}

