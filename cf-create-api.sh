aws cloudformation deploy \
  --stack-name api-gw-to-sqs \
  --template-file cf-api.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region us-east-1