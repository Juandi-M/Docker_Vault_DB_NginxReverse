# AWS Settings
variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

# Backend Settings
variable "backend_bucket" {
  description = "S3 bucket for Terraform backend"
  type        = string
}

variable "backend_key" {
  description = "S3 key for Terraform backend"
  type        = string
}

# ECS Cluster and Service
variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "task_cpu" {
  description = "CPU value for ECS task"
  type        = string
}

variable "task_memory" {
  description = "Memory value for ECS task"
  type        = string
}

# Network
variable "subnets" {
  description = "List of subnet IDs for resources"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

# Container Images
variable "nginx_image" {
  description = "Docker image for Nginx"
  type        = string
}

variable "vault_image" {
  description = "Docker image for Vault"
  type        = string
}

# Secrets
variable "mysql_username" {
  description = "MySQL username"
  type        = string
}

variable "mysql_password" {
  description = "MySQL password"
  type        = string
}

variable "mysql_host" {
  description = "MySQL host"
  type        = string
}

# S3 Configuration
variable "nginx_conf_path" {
  description = "Path to nginx.conf file"
  type        = string
}

# IAM Role
variable "ecs_task_role_name" {
  description = "Name of the IAM role for ECS tasks"
  type        = string
}

variable "vault_mysql_secret_arn" {
  description = "ARN of the Secrets Manager secret for Vault MySQL config"
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC"
  type        = string
}

variable "public_subnet_tier" {
  description = "Tier tag for public subnets"
  type        = string
  default     = "public"
}

variable "private_subnet_tier" {
  description = "Tier tag for private subnets"
  type        = string
  default     = "private"
}
