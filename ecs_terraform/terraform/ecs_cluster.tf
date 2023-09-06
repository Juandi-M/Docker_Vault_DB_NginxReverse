# ECS Cluster
resource "aws_ecs_cluster" "vault_nginx_cluster" {
  name = local.ecs_cluster_name
}

# ECS Service
resource "aws_ecs_service" "vault_nginx_service" {
  name            = local.ecs_service_name
  cluster         = aws_ecs_cluster.vault_nginx_cluster.id
  task_definition = aws_ecs_task_definition.vault_nginx_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets = var.subnets
  }
}
