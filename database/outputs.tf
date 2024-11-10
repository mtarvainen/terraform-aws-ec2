output "ec2_private_dns" {
  value = aws_instance.database.private_dns
}

output "ec2_private_ip" {
  value = aws_instance.database.private_ip
}

output "ec2_public_ip" {
  value = aws_instance.database.public_ip
}
