-include ../.env

echo:
	echo ${wrkname}
	env | grep "TF"

## Initialize terraform remote state
init:
	[ -f .terraform/terraform.tfstate ] || tfenv terraform init
	tfenv terraform workspace select ${wrkname} || tfenv terraform workspace new ${wrkname}

## Clean up the project
clean:
	rm -rf .terraform *.tfstate*

## Pass arguments through to terraform which require remote state
apply console destroy graph plan output providers show: init
	tfenv terraform $@

## Pass arguments through to terraform which do not require remote state
get fmt validate version:
	tfenv terraform $@
