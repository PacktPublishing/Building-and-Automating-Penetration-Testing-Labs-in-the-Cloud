resource "aws_iam_role" "notebook_instance_role" {
  name               = var.notebook_instance_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "notebook_instance_role_sagemaker_policy" {
  role       = (
    aws_iam_role.notebook_instance_role.name
  )
  
  policy_arn = join("", [
    "arn:aws:iam::aws:policy/",
    "AmazonSageMakerFullAccess"
  ])
}


resource "aws_iam_role_policy" "notebook_instance_role_inline_policy" {
  name   = "create-function-policy"
  role   = aws_iam_role.notebook_instance_role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "lambda:CreateFunction",
                "lambda:InvokeFunction",
                "lambda:DeleteFunction",
                "iam:PassRole"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
