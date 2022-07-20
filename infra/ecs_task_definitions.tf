# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition

resource "aws_ecs_task_definition" "meltano" {
  family = "meltano"
  container_definitions = templatefile("task-definitions/meltano.json", {
    aws_cloudwatch_log_router_log_group_name        = aws_cloudwatch_log_group.log_router.name,
    aws_cloudwatch_airflow_scheduler_log_group_name = aws_cloudwatch_log_group.airflow_scheduler.name,
    aws_cloudwatch_airflow_webserver_log_group_name = aws_cloudwatch_log_group.ariflow_webserver.name,
    aws_cloudwatch_meltano_ui_log_group_name        = aws_cloudwatch_log_group.meltano_ui.name,
    fluent_bit_config_arn                           = aws_ssm_parameter.fluent_bit_config.arn
    fluent_bit_parsers_config_arn                   = aws_ssm_parameter.fluent_bit_parsers_config.arn
    secrets_arn                                     = data.aws_secretsmanager_secret.main.arn
  })
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "arn:aws:iam::451041955630:role/aws-ecs-task-role"
  execution_role_arn       = aws_iam_role.ecs_meltano_execution_role.arn

  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
  cpu    = 2048
  memory = 4096

  volume {
    name = "fluent-bit"
  }

  volume {
    name = "meltano-logs"
  }

  volume {
    name = "meltano-airflow"
  }

  tags = {
    Terraform = "true"
  }
}

data "aws_ecs_task_definition" "meltano_latest" {
  task_definition = aws_ecs_task_definition.meltano.family
}

resource "aws_cloudwatch_log_group" "log_router" {
  name = "/aws/ecs/meltano/log-router"

  tags = {
    Terraform   = "true"
    Application = "app-potloc-com"
  }
}

resource "aws_cloudwatch_log_group" "airflow_scheduler" {
  name = "/aws/ecs/meltano/airflow-scheduler"

  tags = {
    Terraform   = "true"
    Application = "meltano"
  }
}

resource "aws_cloudwatch_log_group" "meltano_ui" {
  name = "/aws/ecs/meltano/meltano-ui"

  tags = {
    Terraform   = "true"
    Application = "meltano"
  }
}

resource "aws_cloudwatch_log_group" "ariflow_webserver" {
  name = "/aws/ecs/meltano/airflow-webserver"

  tags = {
    Terraform   = "true"
    Application = "meltano"
  }
}
