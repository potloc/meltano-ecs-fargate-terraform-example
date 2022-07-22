data "aws_vpc" "main" {}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.main.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.main.id
}

resource "aws_security_group" "web" {
  name        = "web-access"
  description = "Grant HTTP & HTTPS access (Managed via Terraform)"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
