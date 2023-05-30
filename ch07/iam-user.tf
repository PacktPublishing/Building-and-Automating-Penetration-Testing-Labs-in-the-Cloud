variable "user_name" {
  type    = string
  default = "sagemaker-workshop-user"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_user" "workshop_user" {
  name = var.user_name
}

resource "aws_iam_user_policy_attachment" "sagemaker_policy_attachment" {
  user       = aws_iam_user.workshop_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_iam_user_login_profile" "profile" {
  user                    = aws_iam_user.workshop_user.name
  password_length         = 10
  password_reset_required = false
}

output "username" {
  value = aws_iam_user.workshop_user.name
}

output "signin_url" {
  value = "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console"
}

output "password" {
  value = aws_iam_user_login_profile.profile.password
}

