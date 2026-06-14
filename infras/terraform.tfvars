aws_region = "us-east-2"

aws_vpc_name = "demo-vpc"
aws_vpc_cidr = "10.20.0.0/16"


aws_vpc_azs = ["us-east-2a", "us-east-2b", "us-east-2c"]

aws_private_subnets = [
  "10.20.1.0/24",
  "10.20.2.0/24",
  "10.20.3.0/24"
]

aws_public_subnets = [
  "10.20.101.0/24",
  "10.20.102.0/24",
  "10.20.103.0/24"
]

aws_project_tags = {
  Project     = "TerraformLab"
  Environment = "production"
}

s3_bucket_name = "terraform-data-example-2024"

# DATABASE VARIABLES
db_identifier = "demo-postgres-rds"
db_name       = "myappdb"
db_password   = "brasil2024"
db_username   = "postgres"
db_port       = 5432