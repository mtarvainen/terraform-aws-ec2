# output "database_ec2_public_ip" {
#   value = module.database.ec2_public_ip
# }

output "database_ec2_private_ip" {
  value = module.database.ec2_private_ip
}

output "database_ec2_private_dns" {
  value = module.database.ec2_private_dns
}

output "application_ec2_public_ip" {
  value = module.application.ec2_public_ip
}

output "application_ec2_public_dns" {
  value = module.application.ec2_public_dns
}
