variable "lambda_role_name" {
    type        = string
    description = "The name of the IAM role that the Lambda function will assume."
    validation {
    condition     = var.lambda_role_name != null && length(var.lambda_role_name) > 0 && length(var.lambda_role_name) <= 250 // Adjust the maximum length as needed
    error_message = "The provided role name does not match the expected pattern for an IAM role name."
    }
  
}
variable "lambda_policy_name" {
    type        = string
  description = "The name of the IAM policy that grants permissions to the Lambda function."
  validation {
    condition     = var.lambda_policy_name != null && length(var.lambda_policy_name) > 0 && length(var.lambda_policy_name) <= 250 // Adjust the maximum length as needed
    error_message = "The provided policy name does not match the expected pattern for an IAM policy name."
  }
}
variable "name_dynamodb" {
    type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = var.name_dynamodb != null && length(var.name_dynamodb) > 0 && length(var.name_dynamodb) <= 250 // Adjust the maximum length as needed
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "project_name" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = var.project_name != null && length(var.project_name) > 0 && length(var.project_name) <= 250 // Adjust the maximum length as needed
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "function_name" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = var.function_name != null && length(var.function_name) > 0 && length(var.function_name) <= 250 // Adjust the maximum length as needed
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "function_name_2" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = var.function_name_2 != null && length(var.function_name_2) > 0 && length(var.function_name_2) <= 250 // Adjust the maximum length as needed
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "region" {
     type        = string
  description = "The AWS region where the resources are located."
  validation {
    condition     = var.region != null && length(var.region) > 0 && length(var.region) <= 250 // Adjust the maximum length as needed
    error_message = "The provided region does not match the expected pattern for an AWS region name."
  }
}