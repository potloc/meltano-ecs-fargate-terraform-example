# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service

resource "aws_ecs_service" "meltano" {
  name            = "meltano"
  cluster         = module.ecs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.meltano.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = module.alb_meltano.target_group_arns[0]
    container_name   = "meltano-ui"
    container_port   = 5000
  }

  load_balancer {
    target_group_arn = module.alb_airflow.target_group_arns[0]
    container_name   = "airflow-webserver"
    container_port   = 8080
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [data.aws_security_group.default.id]
    subnets          = data.aws_subnet_ids.private.ids
  }

  tags = {
    Terraform = "true"
  }
}
