resource "aws_guardduty_detector" "poc" {
  enable = true
}

resource "aws_guardduty_detector_feature" "poc" {
  detector_id = aws_guardduty_detector.poc.id
  name        = "RUNTIME_MONITORING"
  status      = "ENABLED"

  additional_configuration {
    name   = "ECS_FARGATE_AGENT_MANAGEMENT"
    status = "ENABLED"
  }

  lifecycle {
    ignore_changes = [
      additional_configuration
    ]
  }
}