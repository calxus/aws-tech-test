resource "aws_security_group" "poc" {
  name        = "${var.name} Security Group"
  description = "Primary Security Group for the ${var.name} Service"
  vpc_id      = var.vpc
}

resource "aws_security_group_rule" "allow_ingress_poc" {
  description              = "Allow all inbound traffic"
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.poc.id
  source_security_group_id = var.loadbalancer_sg
}

resource "aws_security_group_rule" "allow_egress_poc" {
  description       = "Allow all inbound traffic"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.poc.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_poc_loadbalancer" {
  description              = "Allow outbound HTTP traffic"
  type                     = "egress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  security_group_id        = var.loadbalancer_sg
  source_security_group_id = aws_security_group.poc.id
}