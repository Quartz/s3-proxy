# API Gateway <> S3 proxy (upload / retrieve)

## Configuration

Create `secret.tfvars` and provide an AWS S3 bucket name for uploads:

```
upload_bucket = "s3-bucket-name"
```

## Plan

```sh
make plan
```

## Apply

```sh
make apply
```
