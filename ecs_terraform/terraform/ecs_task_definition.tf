resource "aws_ecs_task_definition" "vault_nginx_task" {
  family                   = local.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.vault_nginx_execution_role.arn

  container_definitions = jsonencode([{
    name  = "nginx"
    image = "nginx:latest"
    portMappings = [{
      containerPort = 80
      hostPort      = 8080
    }]
    },
    {
      name  = "vault"
      image = "vault:latest"
      secrets = [
        {
          name      = "MYSQL_SECRET",
          valueFrom = aws_secretsmanager_secret_version.vault_mysql.secret_id
        }
      ],
      environment = [
        {
          name  = "VAULT_LOCAL_CONFIG",
          value = "{\"backend\": {\"mysql\": {\"address\": \"db:3306\", \"username\": \"foo\", \"password\": \"bar\", \"plaintext_connection_allowed\": true}}, \"listener\": {\"tcp\": {\"address\": \"0.0.0.0:8200\", \"tls_disable\": 1}}, \"disable_mlock\": true, \"ui\": true, \"api_addr\": \"http://127.0.0.1:8200\", \"cluster_addr\": \"https://127.0.0.2:8200\"}"
        }
      ]
  }])
}