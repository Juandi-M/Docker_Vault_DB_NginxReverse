resource "aws_ecs_task_definition" "vault_nginx_task" {
  family                   = "vault_nginx_family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = var.nginx_image
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
      entryPoint = [
        "sh",
        "-c",
        "aws s3  s3://${aws_s3_bucket.vault_config.bucket}/certs /etc/nginx/certs/ --recursive && nginx -g 'daemon off;'"
      ]
    },
    {
      name      = "vault"
      image     = var.vault_image
      cpu       = 128
      memory    = 256
      essential = true
      entryPoint = [
        "sh",
        "-c",
        "aws s3 cp s3://${aws_s3_bucket.vault_config.bucket}/vault-config.hcl /vault/config/vault-config.hcl && vault server -config=/vault/config/vault-config.hcl"
      ],
      secrets = [
        {
          name      = "MYSQL_USERNAME"
          valueFrom = var.vault_mysql_username_secret_arn
        },
        {
          name      = "MYSQL_PASSWORD"
          valueFrom = var.vault_mysql_password_secret_arn
        },
        {
          name      = "MYSQL_HOST"
          valueFrom = var.vault_mysql_host_secret_arn
        }
      ],
      environment = [
        {
          name  = "VAULT_ADDR",
          value = "http://localhost:8200"
        },
        {
          name  = "VIRTUAL_PROTO",
          value = "http"
        },
        {
          name  = "VIRTUAL_PORT",
          value = "80"
        },
        {
          name  = "HTTPS_METHOD",
          value = "redirect"
        }
      ]
    }
  ])
}