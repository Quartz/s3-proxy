//----------------------------------------------------------------------
// Shared Variables
//----------------------------------------------------------------------
variable "region" {}
variable "upload_bucket" {}

//----------------------------------------------------------------------
// API Gateway Variables
//----------------------------------------------------------------------

variable "supported_binary_media_types" {
  description = "Supported file types"
  type        = list

  default = [
    "application/json",
  ]
}
