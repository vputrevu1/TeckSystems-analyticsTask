resource "aws_iam_role" "IamEC2Role" {
  name               = "EC2InstanceRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_customs3bucketpolicy" {
  role       = aws_iam_role.IamEC2Role.name
  policy_arn = aws_iam_policy.s3_read_write.arn
}

resource "aws_iam_role_policy_attachment" "IamEC2Role_SecretsManagerReadOnly" {
  role       = aws_iam_role.IamEC2Role.name
  policy_arn = aws_iam_policy.SecretsManagerReadOnly.arn
}
