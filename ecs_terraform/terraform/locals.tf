locals {
  # General
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]

  # ECS
  ecs_cluster_name  = "${var.environment}-vault-nginx-cluster"
  ecs_service_name  = "${var.environment}-vault-nginx-service"
  ecs_task_family   = "${var.environment}-vault-nginx-family"

  # IAM
  iam_role_name = "${var.environment}-vault-nginx-execution-role"

  # S3
  s3_bucket_name = "${var.environment}-vault-nginx-config-bucket"

  # Secrets Manager
  secret_name = "${var.environment}-vault-mysql"
}
