#!/bin/bash

if [ $# -lt 1 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
STACK_NAME="$BUCKET_NAME-stack"
PROFILE=$2
REGION="eu-south-1"

AWS_COMMAND="aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-file template.yaml \
    --region $REGION \
    --parameter-overrides BucketName=$BUCKET_NAME"

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi

echo "EXEC > $AWS_COMMAND"
eval $AWS_COMMAND