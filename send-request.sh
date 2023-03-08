# get CloudFormation API URL endpoint value
OUTPUT_VALUE=$(aws cloudformation describe-stacks \
  --stack-name api-gw-to-sqs \
  --region us-east-1 \
  --query "Stacks[0].Outputs[?(@.OutputKey=='ApiRootUrl')].OutputValue")
# echo ${OUTPUT_VALUE}

# remove needless chars
ENDPOINT=$(echo "$OUTPUT_VALUE" | tr -d '[ "\n' | tr -d '" ]')
echo "Sending sample data to API Gateway endpoint: ${ENDPOINT}\n"

# send a test request
curl -X 'POST' ${ENDPOINT} \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'user-agent: MyAgent' \
  -d $'type=test&foo=bar'