# ECS Cluster
resource "aws_ecs_cluster" "vault_nginx_cluster" {
  name = local.ecs_cluster_name
}

resource "aws_lb" "nginx_lb" {
  name                             = "nginx-lb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.lb_sg.id]
  subnets                          = data.aws_subnet_ids.public.ids
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_lb.nginx_lb.id
  allocation_id = "44.219.177.107" # Replace with your Elastic IP's allocation ID
}

resource "aws_lb_listener" "nginx_lb_listener" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_lb_tg.arn
  }
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.vault_nginx_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = data.aws_subnet_ids.public.ids
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }

  load_balancers {
    target_group_arn = aws_lb_target_group.nginx_lb_tg.arn
    container_name   = "nginx-proxy"
    container_port   = 80
  }
}
