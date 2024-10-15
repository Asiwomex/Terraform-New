# environments/prod/main.tf

module "networking" {
  source = "../../modules/networking"

  vpc_cidr             = "10.1.0.0/16"
  environment          = "prod"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnet_cidrs = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b", "us-west-2c"]
  enable_flow_logs     = true
}

module "s3_bucket" {
  source = "../../modules/s3"

  bucket_name        = "my-prod-bucket-${data.terraform_remote_state.global.outputs.account_id}"
  environment        = "prod"
  versioning_enabled = true
  logging_enabled    = true
  logging_bucket     = "my-prod-logging-bucket"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "global/terraform.tfstate"
    region = "us-west-2"
  }
}

module "compute" {
  source = "../../modules/compute"

  instance_name               = "prod-instance"
  instance_type               = "m5.large"
  environment                 = "prod"
  ami_id                      = "ami-87654321" # Replace with actual AMI ID
  vpc_id                      = module.networking.vpc_id
  subnet_id                   = module.networking.private_subnet_ids[0]
  associate_public_ip_address = false
}

module "rds" {
  source = "../../modules/rds"

  instance_class = "db.r5.large"
  multi_az       = true
  environment    = "prod"
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  origin_domain_name = module.s3_bucket.bucket_regional_domain_name
  environment        = "prod"
}

output "prod_instance_private_ip" {
  value = module.compute.private_ip
}

output "prod_vpc_id" {
  value = module.networking.vpc_id
}

output "prod_public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.networking.private_subnet_ids
}