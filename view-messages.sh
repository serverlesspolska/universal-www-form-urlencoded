# get CloudFormation SQS URL endpoint
OUTPUT_VALUE=$(aws cloudformation describe-stacks \
  --stack-name api-gw-to-sqs \
  --region us-east-1 \
  --query "Stacks[0].Outputs[?(@.OutputKey=='SqsUrl')].OutputValue")
# echo ${OUTPUT_VALUE}

ENDPOINT=$(echo "$OUTPUT_VALUE" | tr -d '[ "\n' | tr -d '" ]')
echo "Receive messages from SQS: ${ENDPOINT}\n"


aws sqs receive-message --queue-url ${ENDPOINT} \
--region us-east-1 \
--attribute-names All --message-attribute-names All --max-number-of-messages 10 |jq