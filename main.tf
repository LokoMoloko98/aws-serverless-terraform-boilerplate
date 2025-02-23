module "database" {
  source       = "./database"
  project_name = var.project_name
  region       = var.region
}

module "cognito" {
  source          = "./cognito"
  project_name    = var.project_name
  region          = var.region
  lambda-role-arn = module.iam.lambda-dynamodb-role-arn
  apigateway_arn  = module.networking.apigateway_arn
  domain_name     = var.domain_name
  amplify_app_id  = module.amplify.amplify_app_id
}

module "iam" {
  source                                 = "./iam"
  project_name                           = var.project_name
  region                                 = var.region
  music-catalogue-table-ops-function-arn = module.compute.music-catalogue-table-ops-function-arn
  music-catalogue-users-function-arn     = module.compute.music-catalogue-users-function-arn
  apigateway_id                          = module.networking.apigateway_id
}

module "networking" {
  source                                 = "./networking"
  project_name                           = var.project_name
  region                                 = var.region
  music-catalogue-table-ops-function-arn = module.compute.music-catalogue-table-ops-function-arn
  music-catalogue-users-function-arn     = module.compute.music-catalogue-users-function-arn
  cognito_user_pool_client_id            = module.cognito.cognito_user_pool_client_id
  cognito_user_pool_endpoint             = module.cognito.cognito_user_pool_endpoint
  domain_name                            = var.domain_name
}

module "compute" {
  source          = "./compute"
  region          = var.region
  project_name    = var.project_name
  lambda-role-arn = module.iam.lambda-dynamodb-role-arn
  apigateway_arn  = module.networking.apigateway_arn
}

module "amplify" {
  source                      = "./amplify"
  project_name                = var.project_name
  region                      = var.region
  lambda-role-arn             = module.iam.lambda-dynamodb-role-arn
  apigateway_arn              = module.networking.apigateway_arn
  domain_name                 = var.domain_name
  repository_url              = var.repository_url
  amplify-service-role-arn    = module.iam.amplify-service-role-arn
  cognito_user_pool_client_id = module.cognito.cognito_user_pool_client_id
}
