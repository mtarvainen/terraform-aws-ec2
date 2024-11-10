# Generate a Private Key and encode it as PEM.
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "database_key_pair" {
  key_name   = "key-database"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key-database.pem"
  }
}

# Create a EC2 Instance (Debian 12 (HVM), SSD Volume Type)
resource "aws_instance" "database" {
  instance_type          = "t2.micro" # free instance
  ami                    = "ami-05ee09b16a3aaa2fd"
  key_name               = aws_key_pair.database_key_pair.id
  vpc_security_group_ids = [var.database_sg]
  subnet_id              = var.database_subnet

  tags = {
    Name = "aws_instance.database"
  }

  user_data = file("${path.root}/database/userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}