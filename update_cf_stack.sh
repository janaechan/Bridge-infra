#!/usr/bin/env bash

TEMPLATE_URL=$1

# double interpolate environment variables
eval export "InitNewUserPassword=\$InitNewUserPassword_$TRAVIS_BRANCH"
eval export "JacobianUserPassword=\$JacobianUserPassword_$TRAVIS_BRANCH"
eval export "NewRelicAccountId=\$NewRelicAccountId_$TRAVIS_BRANCH"
eval export "NewRelicExternalId=\$NewRelicExternalId_$TRAVIS_BRANCH"
eval export "OperatorEmail=\$OperatorEmail_$TRAVIS_BRANCH"

# deploy with evaluated vars
aws cloudformation update-stack \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_NAMED_IAM \
--template-url $TEMPLATE_URL \
--parameters \
ParameterKey=InitNewUserPassword,ParameterValue="$InitNewUserPassword" \
ParameterKey=JacobianUserPassword,ParameterValue="$JacobianUserPassword" \
ParameterKey=NewRelicAccountId,ParameterValue=$NewRelicAccountId \
ParameterKey=NewRelicExternalId,ParameterValue=$NewRelicExternalId \
ParameterKey=OperatorEmail,ParameterValue=$OperatorEmail
