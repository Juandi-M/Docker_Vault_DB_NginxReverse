resource "aws_secretsmanager_secret" "vault_mysql" {
  name = local.secret_name
}

resource "aws_secretsmanager_secret_version" "vault_mysql" {
  secret_string = jsonencode({
    username = var.mysql_username
    password = var.mysql_password
    host     = var.mysql_host
  })
}

