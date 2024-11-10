#!/bin/bash
set +e
terraform_bin=`command -v terraform || echo './terraform'`
if ! [ -x "$(command -v $terraform_bin)" ]; then
    echo 'Error: terraform is not installed.' >&2
    exit 1
fi
$terraform_bin init
$terraform_bin validate
touch ./key-application.pem ./key-database.pem
chmod 755 ./key-application.pem ./key-database.pem
$terraform_bin apply -auto-approve
chmod 400 ./key-application.pem ./key-database.pem

function write_helper_scripts() {
    application_ip=`$terraform_bin show -json | jq ".values.outputs.application_ec2_public_ip.value" | sed -r 's/"//g'`
    database_ip=`$terraform_bin show -json | jq ".values.outputs.database_ec2_private_ip.value" | sed -r 's/"//g'`
    proxy_command="ssh -l admin -i ./key-application.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p $application_ip"
    cat <<- EOF > ./ssh-database.sh
#!/bin/bash
set +e
ssh -l admin -i ./key-database.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand='$proxy_command' $database_ip
EOF
    chmod u+x ./ssh-database.sh
    cat <<- EOF > ./ssh-application.sh
#!/bin/bash
set +e
ssh -l admin -i ./key-application.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $application_ip
EOF
    chmod u+x ./ssh-application.sh
}
trap write_helper_scripts EXIT
