resource "aws_secretsmanager_secret" "vault_mysql" {
  name = local.secret_name
}

resource "aws_secretsmanager_secret_version" "vault_mysql" {
  secret_id     = aws_secretsmanager_secret.vault_mysql.id
  secret_string = "{\"username\": \"admin\", \"password\": \"Sup3rP4ssw0rd\", \"host\": \"vault-devops-terraform-dev.c6bkmuvtgdqt.us-east-1.rds.amazonaws.com\"}"
}
