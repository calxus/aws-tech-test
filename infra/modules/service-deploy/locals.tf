data "aws_region" "current" {}

locals {
  poc_definition = templatefile(
    "${path.module}/container_definition.tpl",
    {
      service   = var.name
      region    = data.aws_region.current.name
      image     = var.image
      cpu       = var.cpu
      memory    = var.memory
      ports     = jsonencode([var.port])
      log_group = var.log_group
      commands  = jsonencode([""])

      environment = jsonencode(concat([]))
    }
  )
}