module "iam" {
  source             = "./modules/iam"
  dynamodb_table_arn = module.dynamo_db.dynamodb_table_arn
  lambda_role_name   = var.lambda_role_name
  lambda_policy_name = var.lambda_policy_name
  region = var.region
  dynamodb_table_name=module.dynamo_db.dynamodb_table_name
}

module "dynamo_db" {
  source        = "./modules/dynamo_db"
  name_dynamodb = var.name_dynamodb
  project_name  = var.project_name
}

module "lambda_function" {
  source                         = "./modules/lambda_function"
  lambda_role_name               = module.iam.lambda_role_name
  function_name                  = var.function_name
  lambda_role_arn                = module.iam.lambda_role_arn
  dynamodb_table_name            = module.dynamo_db.dynamodb_table_name
  dynamodb_policy_attachment_arn = module.iam.dynamodb_policy_attachment_arn
  cloudwatch_policy_attachment_arn = module.iam.cloudwatch_policy_attachment_arn

}


module "api_gateway" {
  source                   = "./modules/api_gateway"
  resume_lambda_invoke_arn = module.lambda_function.resume_lambda_invoke_arn
  lambda_function_name     = module.lambda_function.lambda_function_name
  region                   = var.region
  
}