# Notes & Examples
# https://github.com/anrim/terraform-aws-ecs
# https://github.com/arminc/terraform-ecs

# https://registry.terraform.io/modules/terraform-aws-modules/ecs/aws/latest
module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = "meltano"

  container_insights = true

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight            = 1
    }
  ]
}
