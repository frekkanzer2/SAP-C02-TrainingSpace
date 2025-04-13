#! /bin/bash

if [ $# -lt 2 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <FILE_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
FILE_NAME=$2
PROFILE=$3
REGION="eu-south-1"

AWS_COMMAND="aws s3 cp ./to_upload/$FILE_NAME s3://$BUCKET_NAME/ --region $REGION"

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi

echo "EXEC > $AWS_COMMAND"
sh -c "$AWS_COMMAND"