aws cloudformation deploy \
  --stack-name api-gateway-logging-permission \
  --template-file cloud-formation.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region us-east-1