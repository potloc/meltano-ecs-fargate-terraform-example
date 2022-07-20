data "aws_secretsmanager_secret" "main" {
  name = "app.potloc.com/production"
}
