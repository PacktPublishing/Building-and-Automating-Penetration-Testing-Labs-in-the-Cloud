variable "notebook_instance_role_name" {
  type    = string
  default = "target-notebook-instance-role"
}

resource "aws_iam_role" "notebook_instance_role" {
  name               = "notebook-instance-role"
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
  role       = aws_iam_role.notebook_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
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

output "notebook_instance_role_arn" {
  value = aws_iam_role.notebook_instance_role.arn
}
