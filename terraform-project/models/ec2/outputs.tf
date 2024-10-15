# modules/ec2/outputs.tf

output "id" {
  value = aws_instance.this.id
}
