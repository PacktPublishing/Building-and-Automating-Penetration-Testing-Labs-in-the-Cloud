data "aws_caller_identity" "current" {}

resource "aws_iam_user" "workshop_user" {
  name = var.username
}

resource "aws_iam_user_policy_attachment" "sagemaker_policy_attachment" {
  user       = aws_iam_user.workshop_user.name
  
  policy_arn = join("", [
    "arn:aws:iam::aws:policy/",
    "AmazonSageMakerFullAccess"
  ])
}

resource "aws_iam_user_login_profile" "profile" {
  user                    = (
    aws_iam_user.workshop_user.name
  )
  
  password_length         = 10
  password_reset_required = false
}
