# Task
To deploy a basic VPC with a subnet, internet gateway, and route table using Terraform, follow these steps. This setup is great for building a foundation for networking on AWS.

### Prerequisites
1. **AWS Account**: Ensure you have access credentials for your AWS account (Access Key and Secret Key).
2. **Terraform Installed**: Make sure Terraform is installed (`terraform -v`).

### Step-by-Step Guide

1. **Set Up the Directory**:
   - Create a new directory for this configuration:
     ```bash
     mkdir terraform-vpc
     cd terraform-vpc
     ```

2. **Create the Main Configuration File**:
   - Create a file called `main.tf` and add the following code:

   - **Explanation**:
     - The `aws_vpc` resource creates a VPC with a `/16` CIDR block (`10.0.0.0/16`).
     - The `aws_subnet` resource creates a subnet within this VPC (`10.0.1.0/24`).
     - The `aws_internet_gateway` resource provisions an internet gateway to allow internet access.
     - The `aws_route_table` resource sets up a route table, and the `aws_route_table_association` links the route table to the subnet.

3. **Initialize Terraform**:
   - Run the following command to initialize Terraform and download the necessary provider plugins:
     ```bash
     terraform init
     ```

4. **Plan the Deployment**:
   - To review what Terraform will create, run:
     ```bash
     terraform plan
     ```
   - This command shows you the execution plan and details of resources Terraform will provision.

5. **Apply the Configuration**:
   - Deploy the VPC and its components by running:
     ```bash
     terraform apply
     ```
   - Type `yes` when prompted to confirm.

6. **Verify the Deployment**:
   - Check the AWS console to see the VPC, subnet, internet gateway, and route table.
   - You can also verify using the AWS CLI:
     ```bash
     aws ec2 describe-vpcs --filters "Name=tag:Name,Values=MyBasicVPC"
     ```

7. **Clean Up (Optional)**:
   - To destroy all resources and clean up, run:
     ```bash
     terraform destroy
     ```
   - Confirm by typing `yes` when prompted.

This Terraform setup will give you a basic VPC with a public subnet that has internet access through the internet gateway. Let me know if you'd like further customization or have any questions!