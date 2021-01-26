init:
	terraform init
plan:
	terraform plan -var-file="variables.tfvars"
apply:
	terraform apply -var-file="variables.tfvars"
destroy:
	terraform destroy -var-file="variables.tfvars"