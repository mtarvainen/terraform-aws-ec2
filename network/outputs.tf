output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "application_sg" {
  value = aws_security_group.sg["application"].id
}
output "database_sg" {
  value = aws_security_group.sg["database"].id
}

output "application_subnet" {
  value = aws_subnet.application_subnet.id
}

output "database_subnet" {
  value = aws_subnet.database_subnet.id
}

