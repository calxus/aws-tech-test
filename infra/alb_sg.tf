resource "aws_security_group" "poc_loadbalancer" {
  name        = "PoC Loadbalancer Security Group"
  description = "Primary Security Group for the PoC Loadbalancer"
  vpc_id      = aws_vpc.poc.id
}

resource "aws_security_group_rule" "allow_ingress_poc_loadbalancer" {
  description       = "Allow inbound HTTP traffic"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.poc_loadbalancer.id
  cidr_blocks       = ["0.0.0.0/0"]
}