terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias  = "default"
  region = "us-east-1"
}

data "aws_canonical_user_id" "current" {}

locals {
  user = data.aws_canonical_user_id.current
  name = local.user.display_name
}

resource "null_resource" "debug" {
  provisioner "local-exec" {
    command = "echo NAME=${local.name}" 
  }
}
