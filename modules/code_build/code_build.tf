resource "aws_codebuild_project" "main" {
  name        = var.app_name_dash
  description = "${var.app_name_dash} code build"

  concurrent_build_limit = 1

  service_role = aws_iam_role.code_build_role.arn

  # CodeBuild Source
  source_version = "main"
  source {
    type     = "GITHUB"
    location = "https://github.com/rrgks6221/terraform-practice-server.git"
  }

  # Environment
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:2.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    # application environment variable
    dynamic "environment_variable" {
      for_each = var.app_env
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }

    dynamic "environment_variable" {
      for_each = var.docker_account
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }

    # codebuild environment variable
    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_uri
    }
    environment_variable {
      name  = "PROJECT_NAME"
      value = var.app_name_dash
    }
    environment_variable {
      name  = "REGION"
      value = var.default_region
    }
  }

  artifacts {
    location  = var.s3.bucket
    type      = "S3"
    path      = "/codebuild"
    packaging = "ZIP"
  }
}

resource "aws_codebuild_source_credential" "credential" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_token
}

resource "aws_codebuild_webhook" "main" {
  project_name = aws_codebuild_project.main.name
  build_type   = "BUILD"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "refs/heads/main"
    }
  }
}
