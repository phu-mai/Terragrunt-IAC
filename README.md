# TERRAFORM IaC Multi-Platform Cloud Deployments
The following cloud providers are supported by
* Amazon Web Services
* Microsoft Azure
* Google Cloud
## What is Terragrunt ?
Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.
* [Terragrunt Introduction](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/)
## Why Terragrunt ?
Terragrunt allows you to do the following items with ease:
* [Keep your Terraform code DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-backend-configuration-dry)
* [Keep your configuration DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-provider-configuration-dry)
* [Execute Terraform commands on multiple modules at once](https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/)
* [Work with multiple AWS accounts](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#promote-immutable-versioned-terraform-modules-across-environments)
* more and more...

## The architecture introduced

* Directory layouts

```text
terragrunt
├── README.md
├── atlantis.yaml
├── aws
│   ├── dev-account
│   │   ├── account.hcl
│   │   ├── environments
│   │   │   ├── dev
│   │   │   │   ├── env.hcl
│   │   │   │   └── shared
│   │   │   │       ├── ap-southeast-1
│   │   │   │       │   ├── networks
│   │   │   │       │   │   ├── tgw
│   │   │   │       │   │   └── vpc
│   │   │   │       │   ├── region.hcl
│   │   │   │       │   ├── services
│   │   │   │       │   │   ├── ec2
│   │   │   │       │   │   └── eks-clusters
│   │   │   │       └── project.hcl
│   │   │   └── staging
│   │   └── global
│   │       ├── iam
│   │       │   ├── groups
│   │       │   │   └── terragrunt.hcl
│   │       │   ├── policies
│   │       │   │   └── terragrunt.hcl
│   │       │   ├── roles
│   │       │   │   └── terragrunt.hcl
│   │       │   └── users
│   │       │       └── terragrunt.hcl
│   │       ├── region.hcl
│   │       └── route53
│   ├── prod-account
│   │   ├── account.hcl
│   │   ├── environments
│   │   │   └── prod
│   │   │       ├── env.hcl
│   │   │       └── project-name
│   │   │           ├── ap-southeast-1
│   │   │           │   └── region.hcl
│   │   │           └── project.hcl
│   │   └── global
│   │       └── region.hcl
│   └── terragrunt.hcl
├── azure
│   └── environments
├── generate_Atlantis_configs.py
└── requirements.txt

```

* Manage s3 backend for tfstate files
The tfstate files are stored in s3 backend bucket for different environments.


S3 bucket for terraform
- Name: terragrunt-terraform-remote-state
- Region: ap-southeast-1


```hcl
terraform {
  backend "s3" {
    encrypt = "true"
    region  = "ap-southeast-1"
    bucket  = "terragrunt-terraform-remote-state"
    key     = "aws/dev-account/environments/dev/shared/ap-southeast-1/networks/vpc/terraform.tfstate"
  }
}
```


* Use shared modules
Manage terraform resource with shared modules

## GENERATE ATLANTIS CONFIGURATIONS
* [Files](generate_Atlantis_configs.py)
* Purpose:
  * Create Atlantis config based on directory structure
* HowTo:
  * Please note that this script only supports **Python verion >= 3.5**
  * If you already have a `.env` folder, you do not have to do 2 steps below:
    * On your localhost, execute `pip3 install virtualenv`
    * `python3 -m venv .env` --> this will use module `virtualenv` to create a new virtual environment named `.env`
  * `source .env/bin/activate` to switch to virtual environment of Python
  * `pip3 install -r requirements.txt` to install Python dependencies
  * `python3 generate_Atlantis_configs.py --help` to show this script's description


(to be continued)
