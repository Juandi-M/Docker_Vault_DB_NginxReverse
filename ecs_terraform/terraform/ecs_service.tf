resource "aws_ecs_service" "vault_nginx_service" {
  name            = "vault_nginx_service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = ["subnet-xxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyy"]
  }
}
