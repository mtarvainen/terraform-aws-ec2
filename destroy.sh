#!/bin/bash
set +e
terraform_bin=`command -v terraform || echo './terraform'`
if ! [ -x "$(command -v $terraform_bin)" ]; then
    echo 'Error: terraform is not installed.' >&2
    exit 1
fi

touch ./key.pem
chmod 755 ./key.pem
$terraform_bin destroy -auto-approve
chmod 400 ./key.pem

function cleanup {
    remove_files="ssh-database.sh ssh-application.sh"
    for file in $remove_files
    do
        test -f ./$file && rm ./$file
    done
}
trap cleanup EXIT
