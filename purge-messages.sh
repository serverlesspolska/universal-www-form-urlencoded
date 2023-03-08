# get CloudFormation SQS URL endpoint
OUTPUT_VALUE=$(aws cloudformation describe-stacks \
  --stack-name api-gw-to-sqs \
  --region us-east-1 \
  --query "Stacks[0].Outputs[?(@.OutputKey=='SqsUrl')].OutputValue")
# echo ${OUTPUT_VALUE}

ENDPOINT=$(echo "$OUTPUT_VALUE" | tr -d '[ "\n' | tr -d '" ]')
echo "Deleting all messages in SQS: ${ENDPOINT}\n"


aws sqs purge-queue --queue-url ${ENDPOINT} \
  --region us-east-1