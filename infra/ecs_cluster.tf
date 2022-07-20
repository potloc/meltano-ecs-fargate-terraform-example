# Notes & Examples
# https://github.com/anrim/terraform-aws-ecs
# https://github.com/arminc/terraform-ecs

# https://registry.terraform.io/modules/terraform-aws-modules/ecs/aws/latest
module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  version = "~> 4.0"

  cluster_name = "meltano"

  cluster_settings = {
    name = "containerInsights"
    value = "enabled"
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 1
      }
    }
  }

  tags = {
    Terraform = "true"
  }
}
