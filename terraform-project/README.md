# VPC Module - Terraform AWS Infrastructure

This Terraform module sets up a Virtual Private Cloud (VPC) with associated networking components in AWS. It provides a scalable and reusable solution for deploying VPCs with subnets, an internet gateway, a NAT gateway, route tables, security groups, and network ACLs. This guide explains the module structure, the necessary files, and how to customize and use the configuration.

## Table of Contents
- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Components](#components)
- [Usage](#usage)
- [Variables](#variables)
- [Outputs](#outputs)
- [Customization](#customization)

## Overview

This module creates a VPC environment that includes:
- Public and private subnets
- An Internet Gateway (IGW)
- A NAT Gateway for internet access from private subnets
- Route tables for managing network traffic
- Security Groups (SGs) and Network ACLs (NACLs) for controlling access

This modular setup allows for flexibility and ease of management, making it suitable for various AWS infrastructure needs.

## Directory Structure

The `vpc` module is structured as follows:

```
terraform-project/
├── main.tf                # Root Terraform configuration
├── modules/
│   └── vpc/
│       ├── main.tf        # Central entry point (intentionally left empty)
│       ├── vpc.tf         # Defines the main VPC resource
│       ├── subnets.tf     # Defines public and private subnets
│       ├── internet_gateway.tf  # Defines the internet gateway
│       ├── nat_gateway.tf       # Defines the NAT gateway
│       ├── route_tables.tf      # Defines route tables and associations
│       ├── security_groups.tf   # Defines security groups
│       ├── nacls.tf        # Defines network ACLs
│       ├── outputs.tf      # Module outputs
│       └── variables.tf    # Module variables
```

Each component of the VPC is defined in its respective file, making it easy to manage and extend the module.

## Components

### 1. **VPC (`vpc.tf`)**
   - Defines the main VPC resource.
   - Takes a CIDR block and name as input.
   - Enables DNS support and hostnames.

### 2. **Subnets (`subnets.tf`)**
   - Creates public and private subnets based on input CIDR blocks and availability zones.
   - Uses a `count` to dynamically provision multiple subnets.

### 3. **Internet Gateway (`internet_gateway.tf`)**
   - Creates an internet gateway to allow internet access for public subnets.

### 4. **NAT Gateway (`nat_gateway.tf`)**
   - Creates a NAT gateway and associates it with an Elastic IP for internet access from private subnets.
   - Uses the first public subnet as the NAT gateway subnet.

### 5. **Route Tables (`route_tables.tf`)**
   - Sets up route tables for public and private subnets.
   - Associates the public route table with the internet gateway.
   - Associates the private route table with the NAT gateway.

### 6. **Security Groups (`security_groups.tf`)**
   - Configures security groups for controlling inbound and outbound traffic for instances.

### 7. **Network ACLs (`nacls.tf`)**
   - Configures network ACLs for public and private subnets.

## Usage

To use the `vpc` module in your Terraform configuration:

1. Add the module to your `main.tf` in the root of your Terraform project:

   ```hcl
   provider "aws" {
     region = "us-east-1"  # Change this to your preferred region
   }

   module "vpc" {
     source = "./modules/vpc"

     vpc_cidr            = "10.0.0.0/16"
     vpc_name            = "MyVPC"
     public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
     private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
     availability_zones  = ["us-east-1a", "us-east-1b"]
   }
   ```

2. Run `terraform init` in the root of your project to initialize the configuration.
3. Run `terraform plan` to see the changes that will be applied.
4. Run `terraform apply` to deploy the infrastructure.

## Variables

The module uses the following variables, defined in `variables.tf`:

## Outputs

The following outputs are provided by the module (defined in `outputs.tf`)
These outputs can be used in other modules or resources within your Terraform configuration.

## Customization

- **CIDR Blocks**: Update `vpc_cidr`, `public_subnet_cidrs`, and `private_subnet_cidrs` as needed to fit your IP address plan.
- **Availability Zones**: Adjust the `availability_zones` variable to match the availability zones in your chosen AWS region.
- **Security Groups and NACLs**: Modify the security group (`security_groups.tf`) and NACL (`nacls.tf`) rules to match your specific access and security requirements.

## Notes

- Make sure you have the necessary AWS permissions to create VPC resources.
- Remember to update the AMI ID when deploying instances to match the latest and appropriate operating system version for your needs.

