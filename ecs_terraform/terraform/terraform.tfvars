# AWS Settings
region      = "us-east-1"
environment = "vault-nginx-dev"

# ECS Cluster and Service
desired_count = 1
task_cpu      = "256"
task_memory   = "512"

# Container Images
nginx_image = "nginx:1.21" # Specific tag
vault_image = "vault:1.8"  # Specific tag

# Secrets (if you've parameterized them in secrets_manager.tf)
vault_mysql_secret_arn = "arn:aws:secretsmanager:region:account-id:secret:secret-name"

# S3 Configuration (if you've parameterized it in s3_ecs_files.tf)
nginx_conf_path = "path/to/your/nginx.conf"

# IAM Role (if you've parameterized it in iam_role.tf)
ecs_task_role_name = "your-ecs-task-role-name"

# Existing VPC and Subnet settings
vpc_name            = "your-existing-vpc-name"
public_subnet_tier  = "public"
private_subnet_tier = "private"
