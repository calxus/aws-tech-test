output "target_group" {
  description = "The ARN of the target group for the service"
  value       = aws_lb_target_group.poc.arn
}

output "security_group" {
  description = "The ID of the security group for the service"
  value       = aws_security_group.poc.id
}