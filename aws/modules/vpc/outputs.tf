
# Output the VPC ID
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "private_subnets" {
  value       = aws_subnet.private.*.id
  description = "The IDs of the private subnets."
}