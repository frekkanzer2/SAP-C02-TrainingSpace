#! /bin/bash

if [ $# -lt 1 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
PROFILE=$2
REGION="eu-south-1"

AWS_COMMAND="aws s3api list-objects --bucket $BUCKET_NAME --region $REGION --output table --query 'Contents[].Key'"

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi

echo "EXEC > $AWS_COMMAND"
sh -c "$AWS_COMMAND"