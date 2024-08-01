resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}
# Create AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "RDS_Credentials"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = random_password.master.result
}

resource "aws_iam_policy" "SecretsManagerReadOnly" {
  name        = "SecretsManagerReadOnly"
  description = "Read-only access to the RDS_Credentials secret"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "${aws_secretsmanager_secret.rds_credentials.arn}"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "add-Developers_SecretsManagerReadOnly" {
  group      = aws_iam_group.group1.name
  policy_arn = aws_iam_policy.SecretsManagerReadOnly.arn
}