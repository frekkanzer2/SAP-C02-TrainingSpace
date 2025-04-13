#! /bin/bash

if [ "$1" == "help" ]; then
    echo "INFO > You must call '$0 <OPT_PROFILE|IGNORE_WITH_null> <OPT_FILTER|IGNORE_WITH_all> <OPT_MAX_RECORDS|IGNORE_WITH_all>'"
    exit 1
fi

PROFILE=$1
FILTER=$2
MAX_RECORDS=$3
REGION="eu-south-1"

AWS_COMMAND="aws s3api list-buckets --region $REGION"

if [ -n "$PROFILE" ] && [ "$PROFILE" != "null" ]; then
    AWS_COMMAND="$AWS_COMMAND --profile $PROFILE"
fi
if [ -n "$MAX_RECORDS" ] && [ "$MAX_RECORDS" != "all" ]; then
    AWS_COMMAND="$AWS_COMMAND --max-items $MAX_RECORDS"
fi
if [ -n "$FILTER" ] && [ "$FILTER" != "all" ]; then
    AWS_COMMAND="$AWS_COMMAND | jq -r '.Buckets[].Name | select(test(\"$FILTER\"))'"
else
    AWS_COMMAND="$AWS_COMMAND --query 'Buckets[].Name' --output table"
fi

echo "EXEC > $AWS_COMMAND"
sh -c "$AWS_COMMAND"