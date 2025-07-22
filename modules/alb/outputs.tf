output "alb_sg_id" {
    value = aws_security_group.alb_security_group.id
}

output "target_group_arn" {
    value = aws_lb_target_group.target_group.arn
}

output "alb_public_url" {
  description = "Public URL"
  value       = aws_lb.alb.dns_name
}