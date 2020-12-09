variable "access_key" {}

variable "region" {
  default = "us-east-1"
}

variable "secret_key" {}

variable "tfstate_bucket" {}

variable "upload_bucket" {
  default = "s3-proxy-api-uploads"
}
