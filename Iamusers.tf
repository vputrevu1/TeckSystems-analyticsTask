# Create an IAM user
resource "aws_iam_user" "iamuser1" {
  name = "developer1"  
}
resource "aws_iam_user" "iamuser2" {
  name = "developer2"  
}

# Attach the AWSCodeCommitFullAccess policy to the user
resource "aws_iam_user_policy_attachment" "AWSCodeCommitFullAccess" {
  user       = aws_iam_user.iamuser1.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}
# Attach the AWSCodeCommitFullAccess policy to the user
resource "aws_iam_user_policy_attachment" "AWSCodeCommitFullAccess2" {
  user       = aws_iam_user.iamuser2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

# create an access key for the users
 resource "aws_iam_access_key" "access_key1" {
   user = aws_iam_user.iamuser1.name
 }

resource "aws_iam_access_key" "access_key2" {
   user = aws_iam_user.iamuser2.name
 }

# Create a new secret in Secrets Manager for developer 1
resource "aws_secretsmanager_secret" "iam_access_key_secret1" {
  name        = "iam_access_key_secret_developer1"
  description = "Access key and secret key for developer1"
}

# Create a new secret in Secrets Manager for developer 2
resource "aws_secretsmanager_secret" "iam_access_key_secret2" {
  name        = "iam_access_key_secret_developer2"
  description = "Access key and secret key for developer2"
}


# Store the access key and secret key in the secret
resource "aws_secretsmanager_secret_version" "iam_access_key_secret_version1" {
  secret_id     = aws_secretsmanager_secret.iam_access_key_secret1.id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.access_key1.id
    secret_access_key = aws_iam_access_key.access_key1.secret
  })
}


# Store the access key and secret key in the secret
resource "aws_secretsmanager_secret_version" "iam_access_key_secret_version2" {
  secret_id     = aws_secretsmanager_secret.iam_access_key_secret2.id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.access_key2.id
    secret_access_key = aws_iam_access_key.access_key2.secret
  })
}

### Create IAM GROUP Developers
resource "aws_iam_group" "group1" {
  name = "Developers"
}

resource "aws_iam_group_membership" "group1membership" {  
  name = aws_iam_group.group1.name
  group = aws_iam_group.group1.name
  users = [aws_iam_user.iamuser1.name, aws_iam_user.iamuser2.name]
}

# Attach the AmazonEC2ReadOnlyAccess policy to the group
resource "aws_iam_group_policy_attachment" "AWS_EC2_read_only_access" {
  group      = aws_iam_group.group1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


# # create custom s3 bucket my-app-bucket
# resource "aws_s3_bucket" "s3-appbucket" {
#   bucket = "my-app-bucket"  
# }

resource "aws_iam_policy_attachment" "s3_read_write_policy_attachment" {
  name       = "s3-read-write-attachment"  
  groups     = [aws_iam_group.group1.name]
  policy_arn = aws_iam_policy.s3_read_write.arn  
}


# # Attach a policy to the user
# resource "aws_iam_user_policy_attachment" "example_policy_attachment" {
#   user       = aws_iam_user.iamuser1.name
#   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"  # Replace with your desired policy ARN
# }

# # Create an access key for the user
# resource "aws_iam_access_key" "example_access_key" {
#   user = aws_iam_user.example_user.name
# }

# # Optionally, create a group and add the user to the group
# resource "aws_iam_group" "example_group" {
#   name = "Developers"
# }

# resource "aws_iam_group_membership" "example_group_membership" {
#   group = aws_iam_group.example_group.name
#   users = [aws_iam_user.example_user.name]
# }