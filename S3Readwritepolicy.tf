resource "aws_iam_policy" "s3_read_write" {
  name        = "S3ReadWritePolicy"
  description = "Provides read and write access to {var.app_s3_bucket}"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::${var.app-s3-bucket}"
      },
      {
        Effect = "Allow",
        Action = [          
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${var.app-s3-bucket}/*"
      }
    ]
  })
}