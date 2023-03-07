# Necessary for API Gateway Logging

**Give API Gateway permissions to write to CloudWatch logs**

Solves the CloudFormation error that yields the message:
```
CloudWatch Logs role ARN must be set in account settings to enable logging (Service: AmazonApiGateway; Status Code: 400; Error Code: BadRequestException; Request ID: ...)
```

NOTE: This is a one time process. As long as you have this enabled once in a region, you can
     deploy other stacks without the need for each stack to create this role. As a good
     practice, create a separate stack altogether with just the API Gateway logging role so
     none of your application stacks need them.

```YAML
---
AWSTemplateFormatVersion: '2010-09-09'
Resources:
  ApiGwAccountConfig:
    Type: "AWS::ApiGateway::Account"
    Properties:
      CloudWatchRoleArn: !GetAtt "ApiGatewayLoggingRole.Arn"
  ApiGatewayLoggingRole:
    Type: "AWS::IAM::Role"
    Properties:
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: Allow
            Principal:
              Service:
                - "apigateway.amazonaws.com"
            Action: "sts:AssumeRole"
      Path: "/"
      ManagedPolicyArns:
        - !Sub "arn:${AWS::Partition}:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
```

Based on [this gist](https://gist.github.com/villasv/4f5b62a772abe2c06525356f80299048)