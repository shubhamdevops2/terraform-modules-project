resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${aws_ecs_service.test-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}


resource "aws_appautoscaling_policy" "scale_down_policy" {
  name               = "ecs-scale-down"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${aws_ecs_service.test-service.name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  
  
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 30
  }

  step_scaling_policy_configuration {
    adjustment_type       = "PercentChangeInCapacity"
    metric_aggregation_type = "Maximum"
    step_adjustment {
      scaling_adjustment = -1
      metric_interval_lower_bound = 0
    }
  }

}


resource "aws_appautoscaling_policy" "scale_up_policy" {
  name               = "ecs-scale-up"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${aws_ecs_service.test-service.name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  
  
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 60
  }

  step_scaling_policy_configuration {
    adjustment_type       = "PercentChangeInCapacity"
    metric_aggregation_type = "Maximum"
    step_adjustment {
      scaling_adjustment = 1
      metric_interval_lower_bound = 0
    }
  }

}
