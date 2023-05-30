variable "notebook_instance_name" {
  type    = string
  default = "target-notebook-instance"
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lifecycle_config" {
  name = "my-lifecycle-config"

  on_create = base64encode(file("lifecycle_script.sh"))
}


resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                  = var.notebook_instance_name
  instance_type         = "ml.t3.medium"
  role_arn              = aws_iam_role.notebook_instance_role.arn
  lifecycle_config_name = aws_sagemaker_notebook_instance_lifecycle_configuration.lifecycle_config.name
  tags = {
    Name = "my-notebook-instance"
  }
}
