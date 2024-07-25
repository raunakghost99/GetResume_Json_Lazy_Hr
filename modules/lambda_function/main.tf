data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = "python_code/get"
  output_path = "resume_cloud_api_challenge.zip"
}

data "archive_file" "lambda_zip_2" {
  type        = "zip"
  source_dir = "python_code/post"
  output_path = "resume_cloud_api_challenge_post.zip"
}

resource "aws_lambda_function" "resume_lambda_function"  {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = "resume_challenge.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  runtime = "python3.10"
  depends_on = [var.dynamodb_policy_attachment_arn , var.cloudwatch_policy_attachment_arn ]
  environment {
    variables = {
      "TABLE_NAME" = var.dynamodb_table_name
    }
  }
}
resource "aws_lambda_function" "resume_post_function" {
  filename = data.archive_file.lambda_zip_2.output_path
  function_name = var.function_name_2
  role          = var.lambda_role_arn
  handler       = "resume_challenge.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip_2.output_path)
  runtime = "python3.10"
  depends_on = [var.dynamodb_policy_attachment_arn , var.cloudwatch_policy_attachment_arn ]
  environment {
    variables = {
      "TABLE_NAME" = var.dynamodb_table_name
    }
  }
}
