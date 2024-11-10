locals { 
  cidr = {
    vpc = "10.0.0.0/16"
    application = "10.0.1.0/24"
    database = "10.0.2.0/24"
  }
}

locals {
  security_groups = {
    application = {
      name        = "application_sg"
      description = "Security group for application access from 0.0.0.0/0"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    },
    database = {
      name        = "database_sg"
      description = "Security group for database access from 10.0.1.0/24"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.cidr.application]
        },
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [local.cidr.application]
        }
      }
    }
  }
}
