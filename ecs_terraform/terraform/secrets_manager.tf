resource "aws_secretsmanager_secret" "vault_mysql" {
  name = "vault_mysql"
}

resource "aws_secretsmanager_secret_version" "vault_mysql" {
  secret_id     = aws_secretsmanager_secret.vault_mysql.id
  secret_string = "{\"password\": \"yourpassword\"}"
}
