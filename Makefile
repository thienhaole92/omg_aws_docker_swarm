init:
	terraform init
apply:
	terraform apply -var-file="variables.tfvars"
destroy:
	terraform destroy -var-file="variables.tfvars"