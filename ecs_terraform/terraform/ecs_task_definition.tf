resource "aws_ecs_task_definition" "vault_nginx_task" {
  family                   = "my-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

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
    portMappings = [{
      containerPort = 8200
      hostPort      = 8200
    }]
    environment = [{
      name = "MYSQL_PASSWORD",
      valueFrom = aws_secretsmanager_secret_version.vault_mysql.secret_id
    }]
  }])
}
