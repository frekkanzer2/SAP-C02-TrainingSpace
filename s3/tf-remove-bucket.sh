#! /bin/bash

if [ "$1" == "help" ]; then
    echo "INFO > You must call '$0'"
    exit 1
fi

cd iac
cd terraform
./destroy.sh