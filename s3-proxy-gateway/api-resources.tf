resource "aws_api_gateway_resource" "itemResource" {
  rest_api_id = "${aws_api_gateway_rest_api.s3-proxy-api.id}"
  parent_id   = "${aws_api_gateway_rest_api.s3-proxy-api.root_resource_id}"
  path_part   = "{key}"
}
