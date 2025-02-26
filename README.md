# AWS Serverless Terraform Boilerplate

2. **AWS Serverless Components**: 
 * DynamoDB Database
 * Lambda Functions
 * API Gateway
 * Cognito User pools
 * Amplify

## Order of Set up:
1. set terraform.tfvars

2. backend.tf (state file and lock table)

3. Set up the Dynamo DB tables
   1. User table
   2. Items table (songs are used here)
   3. Adjust the output.tf and variables.tf

4. Set up Lambda functions to interact with the DB
   1. Lambda function for getting user data from user table
   2. Lambda function for crud ops in the items table
   3. Set up/confirm Lambda permissions for apigateway integration
   4. Adjust the output.tf and variables.tf

5.  Set up API gateway
    1.  **API Gateway**: Creates an API Gateway with CORS configuration
    2.  **Integrations**: Connects API Gateway to Lambda functions.
    3.  **Staging and Logging**: Sets up a stage and enables logging to CloudWatch.
    4.  **Deployment**: Deploys the API and attaches routes.
    5.  **CloudWatch Logging**: Creates a log group for API Gateway logs
    6.  **Authorizer**: Configures a JWT authorizer using Cognito.
    7.  To configure thr API Gateway routes, by defining an `aws_apigatewayv2_route` resource specifying the `api_id`, `route_key`, and `target` integration.
   
6.  Set up cognito

7. Set up IAM  