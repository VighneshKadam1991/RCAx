provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "gpt_key" {
  name = "rca-bot/gpt-api-key"
}

resource "aws_secretsmanager_secret_version" "gpt_key_version" {
  secret_id     = aws_secretsmanager_secret.gpt_key.id
  secret_string = var.gpt_api_key
}

variable "gpt_api_key" {
  type      = string
  sensitive = true
}
