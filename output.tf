output "VPC-ID" {
  value = module.vpc.vpc_id
}

output "Public-Subnet-ID" {
  value = module.vpc.public_subnets
}
output "Instances" {
  value = module.ec2.public_ip
}

