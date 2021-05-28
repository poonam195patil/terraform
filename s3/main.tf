provider "aws" {
  region = "ap-south-1"
  

}
resource "aws_s3_bucket" "initial_account_bucket" {

  bucket = var.bucket_name
  acl    = "private"
  
  policy = <<POLICY
{
  "Id": "Policy1579857150363",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1579857148691",
      "Action": [
        "s3:DeleteBucket"
      ],
      "Effect": "Deny",
      "Resource": "arn:aws:s3:::${var.bucket_name}",
      "Principal": "*"
    }
  ]
}
POLICY

  versioning {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}
  

  


