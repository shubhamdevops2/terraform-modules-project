# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "testapp_log_group" {
  name              = "/ecs/testapp"
  retention_in_days = 30

  tags = {
    Name = "cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "myapp_log_stream" {
  name           = "test-log-stream"
  log_group_name = aws_cloudwatch_log_group.testapp_log_group.name
}


resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "ecs-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Alarm for scaling up ECS tasks based on CPUUtilization metric"
  alarm_actions       = [var.scale_up_policy_arn]
  dimensions = {
    ServiceName = var.ecs-service-name
    ClusterName = var.ecs-cluster-name
  }

}


resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "ecs-scale-down-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "Alarm for scaling down ECS tasks based on CPUUtilization metric"
  alarm_actions       = [var.scale_down_policy_arn]
  dimensions = {
    ServiceName = var.ecs-service-name
    ClusterName = var.ecs-cluster-name
  }
}

# autoscalling for ec2 jenkins

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "60"
  alarm_description   = "This metric monitors ec2 cpu up utilization."
  alarm_actions       = [var.scale_up_policy-jenkins.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors ec2 cpu down utilization."
  alarm_actions       = [var.scale_down_policy-jenkins.arn]
}

