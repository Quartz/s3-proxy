resource "aws_iam_role" "s3_proxy_role" {
  name               = "s3-proxy-api-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.s3_proxy_policy.json
}

data "aws_iam_policy_document" "s3_proxy_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "s3_proxy_role_file_upload_attachment" {
  depends_on = [
    "aws_iam_policy.s3_file_upload_policy",
  ]

  role       = aws_iam_role.s3_proxy_role.name
  policy_arn = aws_iam_policy.s3_file_upload_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_proxy_role_api_gateway_attachment" {
  depends_on = [
    aws_iam_policy.s3_file_upload_policy,
  ]

  role       = aws_iam_role.s3_proxy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
}

resource "aws_s3_bucket" "file_upload_bucket" {
  bucket = var.upload_bucket
  acl    = "private"

  tags {
    Name        = "s3-proxy-api"
  }

  depends_on = [
    aws_iam_policy.s3_file_upload_policy,
  ]
}

resource "aws_iam_policy" "s3_file_upload_policy" {
  name        = "s3-proxy-api-file-upload-policy"
  path        = "/"
  description = "S3 proxy API file upload policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.file_upload_bucket.id}/*" 
            ]
    }
  ]
}
EOF
}
