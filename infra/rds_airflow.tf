# For more info:
# https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest

resource "aws_db_instance" "airflow" {
  identifier                   = "airflow"
  instance_class               = "db.t4g.micro"
  performance_insights_enabled = true

  engine         = "postgres"
  engine_version = 14.1

  storage_type            = "gp2"
  allocated_storage       = 50
  storage_encrypted       = true
  skip_final_snapshot     = false
  backup_retention_period = 7
  deletion_protection     = true

  username = random_string.aws_db_instance_airflow_username.result
  password = random_password.aws_db_instance_airflow_password.result
  db_name  = "airflow"
  port     = "5432"

  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  apply_immediately           = true

  availability_zone                   = "us-east-1a"
  publicly_accessible                 = false
  iam_database_authentication_enabled = false
  db_subnet_group_name                = aws_db_subnet_group.meltano.name
  vpc_security_group_ids              = [local.default_security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_string" "aws_db_instance_airflow_username" {
  length  = 16
  special = false
}

resource "random_password" "aws_db_instance_airflow_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "aws_db_instance_airflow_credentials" {
  name = "airflow/rds"
}

resource "aws_secretsmanager_secret_version" "aws_db_instance_airflow_credentials" {
  secret_id = aws_secretsmanager_secret.aws_db_instance_airflow_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.airflow.username,
    password = random_password.aws_db_instance_airflow_password.result,
    engine   = aws_db_instance.airflow.engine,
    host     = aws_db_instance.airflow.address,
    port     = aws_db_instance.airflow.port,
    dbname   = aws_db_instance.airflow.name,
    url      = "postgres://${aws_db_instance.airflow.username}:${random_password.aws_db_instance_airflow_password.result}@${aws_db_instance.airflow.address}:${aws_db_instance.airflow.port}/${aws_db_instance.airflow.name}",
  })

  depends_on = [
    aws_db_instance.airflow,
  ]
}
