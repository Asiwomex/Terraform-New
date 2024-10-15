# main.tf

provider "aws" {
  region = "us-east-2"  # Change this to your preferred AWS region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "MyVPC"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]  # Update CIDR blocks as needed
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"] # Update CIDR blocks as needed
  availability_zones  = ["us-east-2a", "us-east-2b"]     # Adjust based on your region
}

# Example usage: Deploy an EC2 instance in one of the public subnets
resource "aws_instance" "web" {
  ami           = "ami-0ea3c35c5c3284d82"  # Update with an appropriate AMI ID for Ubuntu LTS
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]  # Reference the first public subnet

  tags = {
    Name = "WebInstance"
  }

  security_groups = [module.vpc.web_sg]  # Assuming you have outputs for SGs in the vpc module
}

# # main.tf

# provider "aws" {
#   region = "us-east-2"  # Adjust the region as needed
# }

# module "vpc" {
#   source              = "./modules/vpc"
#   vpc_cidr            = "10.0.0.0/16"
#   vpc_name            = "MyVPC"
#   public_subnet_cidr  = "10.0.1.0/24"
#   availability_zone   = "us-east-2a"  # Adjust the availability zone as needed
# }

# resource "aws_instance" "ubuntu" {
#   ami           = "ami-0ea3c35c5c3284d82"  # Update to the latest Ubuntu LTS AMI ID for your region
#   instance_type = "t2.micro"
#   subnet_id     = module.vpc.public_subnet_id
#   security_groups = [module.vpc.web_sg_id]

#   tags = {
#     Name = "UbuntuInstance"
#   }
# }


#S3

# module "s3_bucket" {
#   source             = "./modules/s3"
#   bucket_name       = "my-unique-bucket-name"  # Update to a unique bucket name
#   acl                = "private"  # Change as necessary
#   versioning_enabled = true  # Enable versioning if needed
#   prevent_destroy    = true  # Prevent accidental destruction
#   tags               = {
#     Environment = "Dev"
#     Name        = "MyS3Bucket"
#   }
# }

# #EC2

# module "ubuntu_instance" {
#   source        = "./modules/ec2"
#   ami           = "ami-0ea3c35c5c3284d82"  # Update to the latest Ubuntu LTS AMI ID
#   instance_type = "t2.micro"
#   subnet_id     = module.vpc.public_subnet_id
#   security_groups = [module.web_sg.id]  # Use the security group module
#   instance_name = "UbuntuInstance"
# }