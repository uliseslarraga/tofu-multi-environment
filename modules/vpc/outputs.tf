output "vpc_id" {
  value = aws_vpc.this.id
}

output "pub_subnet_cidrs" {
  value = aws_subnet.public[*].cidr_block
}

output "pub_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "priv_subnet_cidrs" {
  value = aws_subnet.private[*].cidr_block
}

output "priv_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "priv_data_subnet_cidrs" {
  value = aws_subnet.data[*].cidr_block
}

output "priv_data_subnet_ids" {
  value = aws_subnet.data[*].id
}