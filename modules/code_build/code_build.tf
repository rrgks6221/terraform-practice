resource "aws_codebuild_project" "name" {
  name        = var.app_name_dash
  description = "${var.app_name_dash} code build"

  concurrent_build_limit = 1

  service_role = aws_iam_role.code_build_role.arn


  # CodeBuild Source
  source_version = "main"
  source {
    type     = "GITHUB"
    location = "https://github.com/rrgks6221/terraform-practice-server"
  }

  # Environment
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:2.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "DATABASE_TYPE"
      value = "postgres"
    }
    environment_variable {
      name  = "DATABASE_HOST"
      value = "terraform-practice.cupytdypyx7j.ap-northeast-2.rds.amazonaws.com"
    }
    environment_variable {
      name  = "DATABASE_PORT"
      value = "5432"
    }
    environment_variable {
      name  = "DATABASE_SCHEMA"
      value = "terraform_practice"
    }
    environment_variable {
      name  = "DATABASE_USERNAME"
      value = "seokho"
    }
    environment_variable {
      name  = "DATABASE_PASSWORD"
      value = "seokho_password"
    }
    environment_variable {
      name  = "DATABASE_DATABASE"
      value = "init_db"
    }
  }

  artifacts {
    location  = var.s3.bucket
    type      = "S3"
    path      = "/codebuild"
    packaging = "ZIP"
  }
}
