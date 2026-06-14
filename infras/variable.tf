

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}


variable "aws_vpc_name" {
  description = "Name of the VPC to create"
  type        = string
}


variable "aws_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "aws_vpc_azs" {
  description = "List of availability zones for the VPC"
  type        = list(string)
}

variable "aws_private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "aws_public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "aws_project_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)

}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for data"
  type        = string
}



# DATA BASE VARIABLES
variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the database to create in RDS"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS PostgreSQL instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS PostgreSQL instance"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Port for the RDS PostgreSQL instance"
  type        = number
}


