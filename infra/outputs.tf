output "url" {
  description = "The URL for the applications"
  value       = aws_lb.poc.dns_name
}