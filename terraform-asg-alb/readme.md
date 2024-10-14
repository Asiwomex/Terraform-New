# TASK
Deploying an Auto Scaling Group (ASG) with an Application Load Balancer (ALB) is a great intermediate task that demonstrates how to build a scalable and resilient architecture using Terraform. Here’s a step-by-step guide.

### Prerequisites
1. **AWS Account**: Access credentials for an AWS account (Access Key and Secret Key).
2. **Terraform Installed**: Terraform should be installed and working (`terraform -v`).

### Overview
We will:
- Set up a VPC with public subnets.
- Create a security group for the instances and the ALB.
- Configure a Launch Template for EC2 instances.
- Create an ASG using the Launch Template.
- Set up an ALB and register the instances in the ASG with the ALB.

### Step-by-Step Guide

1. **Set Up the Directory**:
   - Create a directory for this configuration:
     ```bash
     mkdir terraform-asg-alb
     cd terraform-asg-alb
     ```

2. **Create the Main Configuration File**:
   - Create a file called `asg-alb.tf` and add the following code:

   - **Explanation**:
     - The code creates a VPC, subnet, and internet gateway for network setup.
     - An ALB and security groups for both ALB and instances are set up.
     - A Launch Template specifies the instance type, AMI ID, and a simple user data script to install and run Apache.
     - An Auto Scaling Group manages the EC2 instances and connects them to the ALB via a target group.

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

5. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   - Confirm with `yes` when prompted.

6. **Verify the Setup**:
   - Check your AWS console to see the ALB and instances running.
   - You can access the ALB’s DNS name in your browser to see the Apache web server running on the instances.

7. **Clean Up (Optional)**:
   ```bash
   terraform destroy
   ```
   - Confirm with `yes` to tear down the setup.

This setup should give you a scalable architecture with an ALB and an Auto Scaling Group managing EC2 instances. Let me know if you encounter any issues or have questions