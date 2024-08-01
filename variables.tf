########### Backend variables provider
variable "region" {
  type = string 
  default = "us-east-1"
    }

variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default = "terraform-s3-state"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default = "dynamodb-tf-tablename1"
}
###################
variable "iam_users" {
  type    = list(string)
  default = ["developer1", "developer2"]
}

variable "app-s3-bucket" {
  type = string
  description = "custom s3 bucket my-app-bucket"
  default = "app-my-app-bucket"
}

variable "vpc-id" {
  type = string
  default = "vpc-0a433d8ee084db71c"  
}
variable "ami-id" {
  type = string
  default = "ami-070b7c2988d4e2c89"
  }
