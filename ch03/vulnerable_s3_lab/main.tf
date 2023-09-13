terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

/*
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "<INSERT BUCKET NAME>"
    key = "terraform/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "<INSERT TABLE NAME>"
    encrypt = true
  }
}
*/

provider "aws" {
  alias  = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "<INSERT BUCKET NAME>"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "SampleStatement"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

locals {
  s3_policy = data.aws_iam_policy_document.policy
  au_uri = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
}

resource "aws_s3_bucket_policy" "allow_access_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = local.s3_policy.json
}

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    grant {
      grantee {
        type = "Group"
        uri  = local.au_uri
      }
      permission = "READ"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

/*
resource "null_resource" "s3_upload" {
  provisioner "local-exec" {
    command = "./upload.sh ${aws_s3_bucket.bucket.id}"
  }
}
*