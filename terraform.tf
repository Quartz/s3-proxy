provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "prod-us-newspicks-tf-state"
    key    = "s3-proxy-api/terraform.tfstate"
    region = "us-east-1"
  }
}

module "s3-proxy-gateway" {
  source        = "./s3-proxy-gateway"
  region        = var.region
  upload_bucket = var.upload_bucket
}
