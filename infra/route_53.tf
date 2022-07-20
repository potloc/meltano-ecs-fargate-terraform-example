# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
data "aws_route53_zone" "primary" {
  name = "example.com"
}

resource "aws_route53_record" "<app_name>" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "<resource_name>"
  type    = "A"

  alias {
    name                   = module.alb_airflow.lb_dns_name
    zone_id                = module.alb_airflow.lb_zone_id
    evaluate_target_health = false
  }
}
