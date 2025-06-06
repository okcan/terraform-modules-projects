provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source               = "./modules/network"
  network_name         = "oys-vpc-dev"
  subnet_name          = "oys-subnet-dev"
  subnet_ip            = "10.10.0.0/16"
  region               = var.region
  pods_range_name      = "pods-range"
  pods_ip_range        = "10.20.0.0/16"
  services_range_name  = "services-range"
  services_ip_range    = "10.30.0.0/20"
}

module "gke" {
  source              = "./modules/gke"
  cluster_name        = "oys-test-cluster"
  region              = var.region
  network             = module.network.network
  subnet              = module.network.subnet
  authorized_network  = var.authorized_ip
  pods_range_name     = var.pods_range_name
  services_range_name = var.services_range_name
}

module "nat" {
  source      = "./modules/nat"
  nat_name    = "oys-nat"
  router_name = "oys-nat-router"
  network     = module.network.network
  region      = var.region
}
