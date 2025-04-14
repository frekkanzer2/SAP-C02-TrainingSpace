#!/bin/bash

if [ "$1" == "help" ]; then
    echo "INFO > You must call '$0'"
    exit 1
fi

echo "EXEC > terraform plan -out=plan.tfplan -detailed-exitcode"
terraform plan -out=plan.tfplan -detailed-exitcode
exitcode=$?

if [ $exitcode -eq 0 ]; then
    echo "INFO > No changes found."
elif [ $exitcode -eq 2 ]; then
    echo "INFO > Changes found. Approval is requested to proceed with apply."
    read -p "INPUT > Apply the changes? (y/n) > " CAN_APPLY
    if [ "$CAN_APPLY" == "y" ]; then
        echo "INFO > Apply approved"
        echo "EXEC > terraform apply plan.tfplan"
        sh -c "terraform apply plan.tfplan"
        rm plan.tfplan
    else
        echo "INFO > Apply aborted"
        rm plan.tfplan
        exit 1
    fi
else
    echo "ERROR > Terraform failed."
    rm plan.tfplan
    exit $exitcode
fi