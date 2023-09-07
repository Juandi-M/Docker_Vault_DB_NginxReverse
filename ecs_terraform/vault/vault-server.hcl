backend "mysql" {
  address = "${MYSQL_HOST}:1433"
  username = "${MYSQL_USERNAME}"
  password = "${MYSQL_PASSWORD}"
  plaintext_connection_allowed = true
}

listener "tcp" {
 address = "0.0.0.0:8200"
 tls_disable = 1
}

disable_mlock = true
ui = true

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.2:8200"