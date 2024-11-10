module "network" {
  source          = "./network"
  access_ip       = var.access_ip
  cidr        = local.cidr
  security_groups = local.security_groups
}

module "application" {
  source        = "./application"
  application_sg     = module.network.application_sg
  application_subnet = module.network.application_subnet
}

module "database" {
  source        = "./database"
  database_sg  = module.network.database_sg
  database_subnet = module.network.database_subnet
}
