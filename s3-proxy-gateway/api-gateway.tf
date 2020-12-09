resource "aws_api_gateway_rest_api" "s3-proxy-api" {
  name               = "qz-com-s3-proxy"
  description        = "Under certain conditions, allows code from qz.com to retrieve and upload objects from S3."
  binary_media_types = var.supported_binary_media_types
}

resource "aws_api_gateway_deployment" "s3-proxy-api-deployment" {
  depends_on = [
    aws_api_gateway_integration.itemPutMethod-ApiProxyIntegration,
    aws_api_gateway_integration.itemGetMethod-ApiProxyIntegration,
    aws_api_gateway_integration.itemOptionsMethod-ApiProxyIntegration,
  ]

  rest_api_id = aws_api_gateway_rest_api.s3-proxy-api.id

  stage_name = "prod"
}

resource "aws_api_gateway_usage_plan" "s3-proxy-usage-plan" {
  name        = "s3-proxy-usage-plan"
  description = "Usage plan for S3 proxy"

  api_stages {
    api_id = aws_api_gateway_rest_api.s3-proxy-api.id
    stage  = aws_api_gateway_deployment.s3-proxy-api-deployment.stage_name
  }
}

resource "aws_api_gateway_api_key" "s3-proxy-api-key" {
  name = "s3-proxy-api-key"

  stage_key {
    rest_api_id = aws_api_gateway_rest_api.s3-proxy-api.id
    stage_name  = aws_api_gateway_deployment.s3-proxy-api-deployment.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "s3-proxy-usage-plan-key" {
  key_id        = aws_api_gateway_api_key.s3-proxy-api-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.s3-proxy-usage-plan.id
}
