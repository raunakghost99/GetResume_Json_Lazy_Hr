resource "aws_dynamodb_table" "resume_table" {
  name           = var.name_dynamodb
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "resumeId"

  attribute {
    name = "resumeId"
    type = "S"
  }
  tags = {
    Name = var.name_dynamodb
  }
}
