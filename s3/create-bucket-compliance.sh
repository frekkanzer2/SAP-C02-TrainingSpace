#! /bin/bash
if [ $# -lt 1 ] || [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <BUCKET_NAME> <OPT_PROFILE>'"
    exit 1
fi

BUCKET_NAME=$1
REGION="us-east-1"
PROFILE=$2
AWS_CREATION_COMMAND="aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --object-lock-enabled-for-bucket"
AWS_VERSIONING_COMMAND="aws s3api put-bucket-versioning --bucket $BUCKET_NAME --region $REGION --versioning-configuration Status=Enabled"

if [ -n "$PROFILE" ]; then
    AWS_CREATION_COMMAND="$AWS_CREATION_COMMAND --profile $PROFILE"
    AWS_VERSIONING_COMMAND="$AWS_VERSIONING_COMMAND --profile $PROFILE"
fi

echo "EXEC > $AWS_CREATION_COMMAND"
sh -c "$AWS_CREATION_COMMAND"
echo "EXEC > $AWS_VERSIONING_COMMAND"
sh -c "$AWS_VERSIONING_COMMAND"
echo "INFO > Versioning enabled successfully"