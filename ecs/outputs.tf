# outputs you can kist required endpoints, ip or instanceid's

output "alb_hostname" {
  value = aws_alb.alb.dns_name
}

output "scale_up_policy_arn" {
  value = aws_appautoscaling_policy.scale_up_policy.arn
}

output "scale_down_policy_arn" {
  value = aws_appautoscaling_policy.scale_down_policy.arn
}

output "ecs-service-name" {
  value = aws_ecs_service.test-service.name
}
output "ecs-cluster-name" {
  value = aws_ecs_cluster.test-cluster.name
}