# data "aws_secretsmanager_secret" "example" {
#   name = "MySecret"
# }

# data "aws_secretsmanager_secret_version" "example" {
#   secret_id = data.aws_secretsmanager_secret.example.id
# }

# locals {
#   secrets = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)
# }

data "aws_s3_bucket" "appbucket" {
    bucket = "app-my-app-bucket" 
}

