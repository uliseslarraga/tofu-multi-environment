layer=$(layer)
env=$(env)

validate_workspace:
	cd $(layer); \
	tofu workspace select -or-create $(env)

init:
	@echo "Initializing layer with tofu init over $(layer) in $(env) environment"
	cd $(layer); \
	tofu init

destroy: validate_workspace
	@echo "Destroying $(layer) in $(env) environment"
	cd $(layer); \
	tofu destroy -var-file=../env/${env}/$(layer).tfvars

plan: 
	@echo "Performing tofu plan over $(layer) in $(env) environment"
	cd $(layer); \
	tofu plan -var-file=../env/${env}/$(layer).tfvars

apply: 
	@echo "Performing tofu apply over $(layer) in $(env) environment"
	cd $(layer); \
	tofu apply -var-file=../env/${env}/$(layer).tfvars -auto-approve
