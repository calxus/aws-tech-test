resource "aws_lb" "poc" {
  name               = "poc"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.poc_loadbalancer.id]
  subnets            = aws_subnet.poc_public.*.id

  enable_deletion_protection = false
  depends_on                 = [aws_internet_gateway.poc]
}

resource "aws_lb_listener" "poc" {
  load_balancer_arn = aws_lb.poc.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND"
      status_code  = "404"
    }
  }
}