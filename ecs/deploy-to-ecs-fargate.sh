#!/bin/bash

# Replace these variables
CLUSTER_CONFIG="my-cluster-config"
ECS_PROFILE="my-ecs-profile"
VPC_ID="Your-VPC-ID"
SUBNET_IDS="Your-Subnet-IDs"
COMPOSE_FILE="docker-compose.yml"
ECS_PARAMS="ecs-params.yml"

# Create ECS Cluster
echo "Creating ECS Cluster..."
ecs-cli up \
  --cluster-config $CLUSTER_CONFIG \
  --ecs-profile $ECS_PROFILE \
  --launch-type FARGATE \
  --vpc $VPC_ID \
  --subnets $SUBNET_IDS

# Deploy Services
echo "Deploying services..."
ecs-cli compose \
  --file $COMPOSE_FILE \
  --ecs-params $ECS_PARAMS \
  service up \
  --cluster-config $CLUSTER_CONFIG \
  --ecs-profile $ECS_PROFILE \
  --launch-type FARGATE

# Check Service Status
echo "Checking service status..."
ecs-cli compose \
  --file $COMPOSE_FILE \
  service ps \
  --cluster-config $CLUSTER_CONFIG \
  --ecs-profile $ECS_PROFILE

# Uncomment below lines if you want to clean up resources after checking
# echo "Cleaning up..."
# ecs-cli compose --file $COMPOSE_FILE service down \
#   --cluster-config $CLUSTER_CONFIG \
#   --ecs-profile $ECS_PROFILE
# ecs-cli down --force --cluster-config $CLUSTER_CONFIG --ecs-profile $ECS_PROFILE
