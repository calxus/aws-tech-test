resource "aws_appautoscaling_policy" "cpu_policy" {
  name               = "${var.name}-cpu-policy"
  depends_on         = [aws_appautoscaling_target.scale_target]
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = 70
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_policy" "memory_policy" {
  name               = "${var.name}-memory-policy"
  depends_on         = [aws_appautoscaling_target.scale_target]
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = 70
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_target" "scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster}/${var.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = 2
  max_capacity       = 4
}