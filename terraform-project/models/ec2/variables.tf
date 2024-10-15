# modules/ec2/variables.tf

variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "instance_name" {
  description = "The name to assign to the instance"
  type        = string
}
