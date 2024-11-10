output "ec2_public_dns" {
  value = aws_instance.application.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.application.private_ip
}

output "ec2_public_ip" {
  value = aws_instance.application.public_ip
}
