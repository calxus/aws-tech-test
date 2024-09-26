module "jam" {
  source = "./modules/service-build"

  name            = "jam"
  service_version = "0.2"
}

module "jam_deploy" {
  source = "./modules/service-deploy"

  name            = "jam"
  cluster         = aws_ecs_cluster.poc.name
  vpc             = aws_vpc.poc.id
  subnets         = aws_subnet.poc_private.*.id
  image           = module.jam.image
  port            = 8000
  cpu             = 256
  memory          = 512
  health_endpoint = "/"
  log_group       = aws_cloudwatch_log_group.poc.name
  loadbalancer_sg = aws_security_group.poc_loadbalancer.id
  listener        = aws_lb_listener.poc.arn

  depends_on = [aws_lb.poc]
}