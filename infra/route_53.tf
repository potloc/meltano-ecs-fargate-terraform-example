# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
data "aws_route53_zone" "primary" {
  name = "potloc.com."
}

# resource "aws_route53_record" "meltano_potloc_com_A" {
#   zone_id = data.aws_route53_zone.primary.zone_id
#   name    = "meltano.potloc.com"
#   type    = "A"

#   alias {
#     name                   = module.alb_meltano.lb_dns_name
#     zone_id                = module.alb_meltano.lb_zone_id
#     evaluate_target_health = false
#   }
# }

resource "aws_route53_record" "airflow_potloc_com_A" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "airflow.potloc.com"
  type    = "A"

  alias {
    name                   = module.alb_airflow.lb_dns_name
    zone_id                = module.alb_airflow.lb_zone_id
    evaluate_target_health = false
  }
}
