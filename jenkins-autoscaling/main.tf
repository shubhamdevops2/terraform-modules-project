
resource "aws_launch_configuration" "example" {
  name_prefix   = "jenkins"
  image_id      = lookup(var.AMIS,var.aws_region)
  instance_type = "t2.small"
  key_name = var.key-name
  security_groups = [ aws_security_group.allow-ssh.id ]
  user_data=var.jenkins-installation-user-data


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "jenkins-asg"
  max_size             = 2
  min_size             = 1
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = var.subnet-public.*.id

}


resource "aws_security_group" "allow-ssh" {
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


    ingress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 8080
      protocol = "tcp"
      to_port = 8080
    } 

    tags = {
        name = "allow-ssh,jenkins-port"
    }
}



resource "aws_autoscaling_policy" "scale_up_policy" {
  name                 = "scale-up-policy"
  scaling_adjustment   = 1
  adjustment_type      = "ChangeInCapacity"
  cooldown             = 300
  policy_type          = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.example.name

  #depends_on = [var.jenkins-cpu-high-alarm]
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                 = "scale-down-policy"
  scaling_adjustment   = -1
  adjustment_type      = "ChangeInCapacity"
  cooldown             = 300
  policy_type          = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.example.name

  #depends_on = [var.jenkins-cpu-low-alarm]
}