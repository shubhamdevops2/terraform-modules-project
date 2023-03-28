resource "aws_instance" "example" {
  ami           = lookup(var.AMIS,var.aws_region)
  instance_type = "t2.small"
  key_name = var.key-name
  security_groups = [ aws_security_group.allow-ssh-only.id ]
  subnet_id     = var.subnet-public[0].id


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "jenkins-worker-node"
  }
}


resource "aws_security_group" "allow-ssh-only" {
    vpc_id = var.vpc.id
    name = "allow-ssh"
    description = "For ssh allowing only"
  
    egress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    } 

    ingress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    } 


    tags = {
        name = "allow-ssh"
    }
}