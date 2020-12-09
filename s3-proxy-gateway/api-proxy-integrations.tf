resource "aws_api_gateway_integration" "itemPutMethod-ApiProxyIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.s3-proxy-api.id}"
  resource_id = "${aws_api_gateway_resource.itemResource.id}"
  http_method = "${aws_api_gateway_method.itemPutMethod.http_method}"

  type                    = "AWS"
  integration_http_method = "PUT"
  credentials             = "${aws_iam_role.s3_proxy_role.arn}"
  uri                     = "arn:aws:apigateway:${var.region}:s3:path/${aws_s3_bucket.file_upload_bucket.id}/{key}"

  request_parameters {
    "integration.request.header.x-amz-meta-fileinfo" = "method.request.header.x-amz-meta-fileinfo"
    "integration.request.header.Accept"              = "method.request.header.Accept"
    "integration.request.header.Content-Type"        = "method.request.header.Content-Type"

    "integration.request.path.key"   = "method.request.path.key"
  }
}

resource "aws_api_gateway_integration" "itemGetMethod-ApiProxyIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.s3-proxy-api.id}"
  resource_id = "${aws_api_gateway_resource.itemResource.id}"
  http_method = "${aws_api_gateway_method.itemGetMethod.http_method}"

  type                    = "AWS"
  integration_http_method = "GET"
  credentials             = "${aws_iam_role.s3_proxy_role.arn}"
  uri                     = "arn:aws:apigateway:${var.region}:s3:path/${aws_s3_bucket.file_upload_bucket.id}/{key}"

  request_parameters {
    "integration.request.path.key"   = "method.request.path.key"
  }
}

resource "aws_api_gateway_integration" "itemOptionsMethod-ApiProxyIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.s3-proxy-api.id}"
  resource_id = "${aws_api_gateway_resource.itemResource.id}"
  http_method = "${aws_api_gateway_method.itemOptionsMethod.http_method}"
  type        = "MOCK"
  depends_on  = ["aws_api_gateway_method.itemOptionsMethod"]

  request_templates {
    "application/json" = <<EOF
        {
        "statusCode" : 200
        }
    EOF
  }
}
