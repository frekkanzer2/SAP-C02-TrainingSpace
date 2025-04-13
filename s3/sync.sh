#! /bin/bash

if [ $# -lt 1 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
PROFILE=$2
REGION="eu-south-1"

AWS_COMMAND="aws s3 sync ./to_upload/ s3://$BUCKET_NAME/ --region $REGION"

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi

echo "INFO > Executing SYNC dryrun on bucket $BUCKET_NAME"
echo "EXEC > $AWS_COMMAND --dryrun"
sh -c "$AWS_COMMAND --dryrun"

read -p "INPUT > Approve execution? (y/n) > " APPROVE

if [ "$APPROVE" == "y" ]; then
    echo "INFO > SYNC approved"
    echo "EXEC > $AWS_COMMAND"
    sh -c "$AWS_COMMAND"
else
    echo "INFO > SYNC aborted"
    exit 1
fi