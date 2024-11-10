# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "aws_vpc.vpc"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create application subnet
resource "aws_subnet" "application_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr.application
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "aws_subnet.application_subnet"
  }
}

# Create database subnet
resource "aws_subnet" "database_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr.database
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "aws_subnet.database_subnet"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "aws_internet_gateway.igw"
  }
}

# Create public route to internet
resource "aws_route" "public_rt" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}


# Create Security Groups
resource "aws_security_group" "sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
