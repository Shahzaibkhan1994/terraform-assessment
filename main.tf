module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/24"

  azs                    = ["eu-west-1a"]
  public_subnets         = ["10.0.0.0/25"]
}

module "ec2_sg" {
	source = "terraform-aws-modules/security-group/aws"

  name        = "my-vpc-sg-ec2"
  description = "Security Group for ec2"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                        = "MY-EC2-INSTANCE"
  ami                         = "ami-0f98479f8cd5b63f6" #debian-os-ami-id
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = ["${module.ec2_sg.security_group_id}"]
  associate_public_ip_address = true
  user_data                   = file("./scripts/user-data.sh")
  key_name                    = aws_key_pair.key.key_name
}

resource "aws_key_pair" "key" {
  key_name   = "dev-key"
  public_key = file("./scripts/dev-key.pub")
}
