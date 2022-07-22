# For more info:
# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest
module "alb_airflow" {
  source = "terraform-aws-modules/alb/aws"

  name               = "airflow-potloc-com"
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 300

  vpc_id          = data.aws_vpc.main.id
  subnets         = data.aws_subnet_ids.public.ids
  security_groups = [data.aws_security_group.default.id, aws_security_group.web.id]

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
  target_groups = [
    {
      name                 = "airflow-potloc-com-target-group"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"
      deregistration_delay = 30
      health_check = {
        enabled             = true
        path                = "/"
        matcher             = "200,302"
        interval            = 10
        timeout             = 5
        healthy_threshold   = 3
        unhealthy_threshold = 3
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.star_potloc_com_certificate_arn
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform = "true"
  }
}
