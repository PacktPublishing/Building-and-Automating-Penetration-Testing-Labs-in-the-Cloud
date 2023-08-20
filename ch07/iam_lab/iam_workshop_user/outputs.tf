output "username" {
  value = aws_iam_user.workshop_user.name
}

output "signin_url" {
  value = join("",[
    "https://",
    data.aws_caller_identity.current.account_id,
    ".signin.aws.amazon.com/console"
  ])
}

output "password" {
  value = aws_iam_user_login_profile.profile.password
}
