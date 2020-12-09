# API Gateway <> S3 proxy (upload / retrieve)

## Terraform

Create `secret.tfvars` and provide an AWS S3 bucket name for uploads:

```
upload_bucket = "s3-bucket-name"
```

### Plan

Terraform commands are run via Docker using a `Makefile`.

```sh
make plan
```

### Apply

```sh
make apply
```

## Making requests

Retrieve the API key from the API Gateway dashboard.

### PUT

```sh
curl -X PUT --data "@/path/to/file" -H "X-Api-Key: APIKEY" https://APIID.execute-api.us-east-1.amazonaws.com/prod/s3-key
```

### GET

```sh
curl -H "X-Api-Key: APIKEY" https://APIID.execute-api.us-east-1.amazonaws.com/prod/s3-key
```
