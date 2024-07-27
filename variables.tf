variable "lambda_role_name" {
    type        = string
  description = "The name of the IAM role that the Lambda function will assume."
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\.\\-_]+$", var.lambda_role_name))
    error_message = "The provided role name does not match the expected pattern for an IAM role name."
  }
}
variable "lambda_policy_name" {
    type        = string
  description = "The name of the IAM policy that grants permissions to the Lambda function."
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\.\\-_]+$", var.lambda_policy_name))
    error_message = "The provided policy name does not match the expected pattern for an IAM policy name."
  }
}
variable "name_dynamodb" {
    type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = can(regex("^[a-z][a-z0-9/-]+$", var.dynamodb_table_name))
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "project_name" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = can(regex("^[a-z][a-z0-9/-]+$", var.dynamodb_table_name))
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "function_name" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = can(regex("^[a-z][a-z0-9/-]+$", var.dynamodb_table_name))
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "function_name_2" {
     type        = string
  description = "The name of the DynamoDB table."
  validation {
    condition     = can(regex("^[a-z][a-z0-9/-]+$", var.dynamodb_table_name))
    error_message = "The provided table name does not match the expected pattern for a DynamoDB table name."
  }
}
variable "region" {
     type        = string
  description = "The AWS region where the resources are located."
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-/d+$", var.region))
    error_message = "The provided region does not match the expected pattern for an AWS region name."
  }
}