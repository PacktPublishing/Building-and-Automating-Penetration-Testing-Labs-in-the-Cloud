resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lifecycle_config" {
  name = "lifecycle-config"

  on_create = (
    base64encode(
      file("${path.module}/lifecycle_script.sh")
    )
  )
}

locals {
  instance_role_arn = var.notebook_instance_role_arn

  lifecycle_config_name = aws_sagemaker_notebook_instance_lifecycle_configuration.lifecycle_config.name
}

resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                  = var.notebook_instance_name
  instance_type         = "ml.t3.medium"
  role_arn              = local.instance_role_arn
  lifecycle_config_name = local.lifecycle_config_name
  
  tags = {
    Name = "notebook-instance"
  }
}
