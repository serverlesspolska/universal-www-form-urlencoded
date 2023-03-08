echo "Updating CloudFormation stack"
aws cloudformation update-stack \
  --stack-name api-gw-to-sqs \
  --template-body file://cf-api.yaml \
  --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region us-east-1

echo "Waiting for update to complete"
aws cloudformation wait stack-update-complete \
  --stack-name api-gw-to-sqs \
  --region us-east-1

echo "Update done"
# get CloudFormation API URL endpoint value
OUTPUT_VALUE=$(aws cloudformation describe-stacks \
  --stack-name api-gw-to-sqs \
  --region us-east-1 \
  --query "Stacks[0].Outputs[?(@.OutputKey=='ApiId')].OutputValue")
# echo ${OUTPUT_VALUE}

# remove needless chars
API_ID=$(echo "$OUTPUT_VALUE" | tr -d '[ "\n' | tr -d '" ]')
echo "Re-deploying API Gateway to make sure changes are applied"
aws apigateway create-deployment --rest-api-id ${API_ID} \
  --stage-name dev \
  --region us-east-1