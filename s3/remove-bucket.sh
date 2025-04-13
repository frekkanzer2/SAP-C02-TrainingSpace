#! /bin/bash

if [ $# -lt 1 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <OPT_FORCED|AGREE_WITH_y> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
REGION="eu-south-1"
FORCED=$2
PROFILE=$3

AWS_COMMAND="aws s3 rb s3://$BUCKET_NAME --region $REGION"

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi
if [ -n "$FORCED" ] && [ "$FORCED" == "f" ]; then
    AWS_COMMAND="$AWS_COMMAND --force"
fi

echo "EXEC > $AWS_COMMAND"
sh -c "$AWS_COMMAND"