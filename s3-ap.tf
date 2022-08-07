########################
# S3 on Outposts Bucket ----------------- # not defined
########################

/*
resource "aws_s3control_bucket" "example" {
  bucket = aws_s3_bucket.s3.bucket
}

resource "aws_s3_access_point" "example" {
  bucket = aws_s3control_bucket.example.arn
  name   = "example"

  # VPC must be specified for S3 on Outposts
  vpc_configuration {
    vpc_id = aws_vpc.example.id
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
*/

########################
# AWS Partition Bucket
########################

#--------------------------------------------------- Ap-1

resource "aws_s3_access_point" "user1-ap" {
  bucket = aws_s3_bucket.s3.bucket
  name   = "${var.ap1-name}"

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  lifecycle {
    ignore_changes = [policy]
  }
}

resource "aws_s3control_access_point_policy" "ap1-policy" {
  access_point_arn = aws_s3_access_point.user1-ap.arn

  policy = jsonencode({
    "Version":"2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::${var.account_id}:role/${var.iam-role1}"
        },
        "Action": "s3:listBucket",
        "Resource": "arn:aws:s3:${var.region}:${var.account_id}:accesspoint/${var.ap1-name}"
    }]
})
}

#--------------------------------------------------- Ap-2

resource "aws_s3_access_point" "user2-ap" {
  bucket = aws_s3_bucket.s3.bucket
  name   = "${var.ap2-name}"

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  lifecycle {
    ignore_changes = [policy]
  }
}

resource "aws_s3control_access_point_policy" "ap2-policy" {
  access_point_arn = aws_s3_access_point.user2-ap.arn

  policy = jsonencode({
    "Version":"2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::${var.account_id}:role/${var.iam-role2}"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:${var.region}:${var.account_id}:accesspoint/${var.ap2-name}/object/*"
    }]
})
}
