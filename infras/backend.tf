terraform {
  backend "s3" {
    bucket = "terraform-backup-test01"
    key    = "infra/terraform.tfstate"
    region = "us-east-2"
  }
}