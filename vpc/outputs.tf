output "vpc" {
  value = aws_vpc.demo
}


output "subnet-private" {
  value = aws_subnet.demo-private
  
}

output "subnet-public" {
  value = aws_subnet.demo-public
  
}

# output "subnet-private-cidr"{
#   value = aws_subnet.demo-private.*.cidr_block
# }


# output "subnet-public-cidr"{
#   value = aws_subnet.demo-public.*.cidr_block
# }

