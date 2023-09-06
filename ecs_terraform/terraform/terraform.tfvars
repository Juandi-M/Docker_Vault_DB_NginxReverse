# AWS Settings
region      = "us-east-1"
environment = "vault-nginx-dev"

# ECS Cluster and Service
desired_count = 1
task_cpu      = "256"
task_memory   = "512"

# Network
subnets = ["subnet-xxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyy"]

# Container Images
nginx_image = "nginx:latest"
vault_image = "vault:latest"

