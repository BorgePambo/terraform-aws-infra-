terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# -----------------------------
# S3 Bucket (Terraform State)
# -----------------------------
resource "aws_s3_bucket" "data_bucket" {
  bucket = var.s3_bucket_name
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.aws_vpc_name
  cidr = var.aws_vpc_cidr

  azs             = var.aws_vpc_azs
  private_subnets = var.aws_private_subnets
  public_subnets  = var.aws_public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = var.aws_project_tags
}

# -----------------------------
# Security Group (CORRIGIDO v5)
# -----------------------------
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.db_name}-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"
      cidr_blocks = var.aws_vpc_cidr
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0" #cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = var.aws_project_tags
}

# -----------------------------
# RDS PostgreSQL
# -----------------------------
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = var.db_identifier

  engine         = "postgres"
  engine_version = "14"
  instance_class = "db.m5d.large"

  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  vpc_security_group_ids = [module.security_group.security_group_id]

  publicly_accessible = false
  #publicly_accessible = true

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  family               = "postgres14"
  major_engine_version = "14"

  backup_window      = "03:00-06:00"
  maintenance_window = "Mon:00:00-Mon:03:00"

  deletion_protection = false
  multi_az            = false

  tags = var.aws_project_tags
}