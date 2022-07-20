terraform {
  backend "s3" {
    encrypt = true
    bucket  = "potloc-terraform-state-production"
    region  = "us-east-1"
    key     = "meltano/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13"
    }
  }
}
