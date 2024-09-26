resource "aws_ecs_cluster" "poc" {
  name = "poc"
}

resource "aws_cloudwatch_log_group" "poc" {
  name = "poc"
}