resource "aws_iam_role" "ecs_meltano_execution_role" {
  name = "aws-ecs-meltano-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      },
    ],
  })

  inline_policy {
    name = "log-router-ssm-policy"

    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "ssm:GetParameters"
          ],
          Resource = [
            aws_ssm_parameter.fluent_bit_config.arn,
            aws_ssm_parameter.fluent_bit_parsers_config.arn,
          ]
        }
      ]
    })
  }

  managed_policy_arns = [
    data.aws_iam_policy.secrets_manager_read_write.arn,
    data.aws_iam_policy.ecs_task_execution_role.arn,
    data.aws_iam_policy.efs_full_access.arn,
    data.aws_iam_policy.efs_client_full_access.arn,
  ]
}

data "aws_iam_policy" "secrets_manager_read_write" {
  name = "SecretsManagerReadWrite"
}

data "aws_iam_policy" "ecs_task_execution_role" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy" "efs_full_access" {
  name = "AmazonElasticFileSystemFullAccess"
}

data "aws_iam_policy" "efs_client_full_access" {
  name = "AmazonElasticFileSystemClientFullAccess"
}
