resource "aws_lb_target_group" "poc" {
  name        = var.name
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc
  target_type = "ip"

  health_check {
    port = var.port
    path = var.health_endpoint
  }
}

resource "aws_lb_listener_rule" "poc" {
  listener_arn = var.listener

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.poc.arn
  }

  condition {
    query_string {
      key   = "app"
      value = var.name
    }
  }
}