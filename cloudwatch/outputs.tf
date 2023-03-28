output "jenkins-cpu-high-alarm" {
    value = aws_cloudwatch_metric_alarm.cpu_high
}

output "jenkins-cpu-low-alarm" {
    value = aws_cloudwatch_metric_alarm.cpu_low
}