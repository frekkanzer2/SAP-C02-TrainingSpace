#!/bin/bash

if [ "$1" == "help" ]; then
    echo "INFO > You must call '$0'"
    exit 1
fi

echo "EXEC > terraform destroy"
terraform destroy