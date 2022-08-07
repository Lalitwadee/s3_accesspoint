
#------------------------------------------------ Create IAM role (1)

resource "aws_iam_role" "user1" {
  name = "${var.iam-role1}"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
              "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
  tags = {
    name = "name"
    value = "${var.tag-value-bucket}-${var.iam-role1}"
  }
}

resource "aws_iam_instance_profile" "user1_profile" {
  name = "${var.iam-role1}"
  role = aws_iam_role.user1.name
}

#------------------------------------------------ Create IAM role (2)

resource "aws_iam_role" "user2" {
  name = "${var.iam-role2}"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
              "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

  inline_policy {
    name = "user2_inline_policy"


    policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket-name}",
        "arn:aws:s3:::${var.bucket-name}/*"
      ]

    }
  ]
})
}

  tags = {
    name = "name"
    value = "${var.tag-value-bucket}-${var.iam-role2}"
  }
}

resource "aws_iam_instance_profile" "user2_profile" {
  name = "${var.iam-role2}"
  role = aws_iam_role.user2.name
}
