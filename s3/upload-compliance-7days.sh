#! /bin/bash
if [ $# -lt 2 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <FILE_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
FILE_NAME=$2
PROFILE=$3
REGION="us-east-1"
AWS_COMMAND="aws s3api put-object --bucket $BUCKET_NAME --key $FILE_NAME --body ./to_upload/$FILE_NAME --object-lock-mode COMPLIANCE --region $REGION --object-lock-retain-until-date \"$(date -u -d '+7 days' +%Y-%m-%dT%H:%M:%SZ)\""

if [ -n "$PROFILE" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi

echo "EXEC > $AWS_COMMAND"
sh -c "$AWS_COMMAND"