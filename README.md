## Example Terraform repo for AWS web application
### Configuration
Configure AWS-credentials into the `terraform.tfvars` file.

    aws_access_key = "<YOUR_AWS_ACCESS_KEY>"
    aws_secret_key = "<YOUR_AWS_SECRET_KEY>"
    access_ip      = "0.0.0.0/0"

Limit public access to application host ports (22,80,443) using `access_ip` variable. Database host access is limited only for application host.

### Run easily using helper scripts
Use `apply.sh` and `destroy.sh` helper scripts for fast stack manaagement.

```bash
# create resources to aws
# generates helper scripts for direct ssh-access
$ ./apply.sh
#
# connect to application host
$ ./ssh-application.sh
#
# connect to database host
$ ./ssh-database.sh
#
# remove resources from aws
$ ./destroy.sh
```

### Run using terraform commands
```bash
# init modules
$ terraform init

# validate configuration
$ terraform validate

# plan configuration
$ terraform plan

# apply configuration
$ terraform apply

# destroy configuration
$ terraform destroy
```
