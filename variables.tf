
variable "region" {
    default = "ap-southeast-1"
}

variable "account_id" {
    default = "<account-id>"
}

variable "bucket-name" {
    type = string
    default = "bucket-ap20"
}

variable "ap1-name" {
    type = string
    default = "user1-ap"
}

variable "ap2-name" {
    type = string
    default = "user2-ap"
}

variable "iam-role1" {
    default = "user1"
}

variable "iam-role2" {
    default = "user2"
}

#-----------------------------------

variable "tag-value-bucket" {
    default = "s3-private"
}

variable "versioning_s3" {
    default = "Disabled"
}

variable "oject_owner" {
    description = "Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
    default = "BucketOwnerPreferred"
}

