provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
  version    = "1.7.1"
}

terraform {
  backend "s3" {
    bucket = "${var.tfstate_bucket}"
    key    = "s3-proxy-api/terraform.tfstate"
    region = "${var.region}"
  }
}

module "s3-proxy-gateway" {
  source        = "./s3-proxy-gateway"
  region        = "${var.region}"
  upload_bucket = "${var.upload_bucket}"
}
