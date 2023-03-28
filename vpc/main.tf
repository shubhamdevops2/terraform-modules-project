#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "demo" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = tomap({
    "Name" = "demo-vpc",
    
  })
}

resource "aws_subnet" "demo-public" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.1.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.demo.id
  depends_on = [aws_internet_gateway.demo]

  tags = tomap({
    "Name"                                      = "vpc-demo-subnet-public",
    
  })
}


resource "aws_subnet" "demo-private" {
  count = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.1.${count.index + 2}.0/24"
  vpc_id                  = aws_vpc.demo.id

  tags = tomap({
    "Name"                                      = "vpc-demo-subnet-private",
    
  })
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "vpc-demo-ig"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
  
  tags = {
    Name = "vpc-demo-rt-ig"
  }
}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo-public[count.index].id
  route_table_id = aws_route_table.demo.id
  

}


#for nat gateway
resource "aws_eip" "lb" {
  count = 2
  vpc      = true
  
  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "gw" {
  count = 2

  allocation_id = aws_eip.lb[count.index].id
  subnet_id     = aws_subnet.demo-private[count.index].id
  depends_on = [aws_internet_gateway.demo]

  tags = {
    Name = "demo-nat"
  }
}

resource "aws_route_table" "instance" {
  count = 2
  vpc_id = aws_vpc.demo.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw[count.index].id
  }
  
  tags = {
    Name = "vpc-demo-rt-nat"
  }
}

resource "aws_route_table_association" "instance" {
  count = 2
  subnet_id = aws_subnet.demo-private[count.index].id
  route_table_id = aws_route_table.instance[count.index].id
  
}

