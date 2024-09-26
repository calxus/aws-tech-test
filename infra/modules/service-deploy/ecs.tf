resource "aws_ecs_service" "poc" {
  name                              = var.name
  cluster                           = var.cluster
  task_definition                   = aws_ecs_task_definition.poc.arn
  launch_type                       = "FARGATE"
  desired_count                     = 2
  force_new_deployment              = true
  health_check_grace_period_seconds = 30

  network_configuration {
    security_groups = [aws_security_group.poc.id]
    subnets         = var.subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.poc.arn
    container_name   = var.name
    container_port   = var.port
  }
}

resource "aws_ecs_task_definition" "poc" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.poc.arn
  task_role_arn            = aws_iam_role.poc.arn
  container_definitions    = "[ ${local.poc_definition} ]"
  skip_destroy             = true

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}