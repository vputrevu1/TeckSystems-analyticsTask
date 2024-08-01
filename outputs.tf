 output "developer1_access_key_id" {
   value = aws_iam_access_key.access_key1.id
   sensitive = false
 }

output "developer2_access_key_id" {
   value = aws_iam_access_key.access_key2.id
   sensitive = false
 }

 output "developer1_accessSecret" {
   value = aws_iam_access_key.access_key1.secret
   sensitive = true
 }

output "developer2_accessSecret" {
   value = aws_iam_access_key.access_key2.secret
   sensitive = true
 }

output "custom_S3_policy_arn" {
   value = aws_iam_policy.s3_read_write.arn
 }

output "custom_bucket_arn"{
  value = data.aws_s3_bucket.appbucket.arn
}


