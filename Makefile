## Terraform ##
tf = docker run -i \
	-v $(HOME)/.aws:/.aws \
  -v $(shell pwd):/app \
  -e AWS_PROFILE=${AWS_PROFILE} \
	-e AWS_SHARED_CREDENTIALS_FILE=/.aws/credentials \
  -w /app \
  hashicorp/terraform:0.12.20

init:
	@echo "-- Terraform Init --"
	find . -name plan.out -delete
	$(tf) init -lock-timeout=180s -var-file="secret.tfvars"

plan: init
	@echo "-- Terraform Plan --"
	$(tf) plan -lock-timeout=180s -out=plan.out -var-file="secret.tfvars"

apply: pull plan
	@echo "-- Terraform Apply --"
	$(tf) apply -lock-timeout=180s plan.out -var-file="secret.tfvars"

destroy:
	@echo "-- Terraform destroy --"
	$(tf) destroy -var-file="secret.tfvars"
