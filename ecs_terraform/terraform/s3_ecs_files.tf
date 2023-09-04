# S3 Bucket for Vault and Nginx Configurations
resource "aws_s3_bucket" "vault_nginx_config_bucket" {
  bucket = "vault-nginx-config-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  public_access_block_configuration {
    block_public_acls   = true
    block_public_policy = true
    ignore_public_acls  = true
    restrict_public_buckets = true
  }
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "vault_nginx_config_bucket_policy" {
  bucket = aws_s3_bucket.vault_nginx_config_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "s3:GetObject",
        Effect = "Allow",
        Resource = "${aws_s3_bucket.vault_nginx_config_bucket.arn}/*",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Upload nginx.conf to S3 Bucket
resource "aws_s3_bucket_object" "nginx_conf_object" {
  bucket = aws_s3_bucket.vault_nginx_config_bucket.id
  key    = "nginx/nginx.conf"
  source = "path/to/your/nginx.conf"  # Replace with the actual path to your nginx.conf
  etag   = filemd5("path/to/your/nginx.conf")  # Replace with the actual path to your nginx.conf
}

# Upload vault-server.hcl to S3 Bucket
resource "aws_s3_bucket_object" "vault_hcl_object" {
  bucket = aws_s3_bucket.vault_nginx_config_bucket.id
  key    = "vault/vault-server.hcl"
  source = "path/to/your/vault-server.hcl"  # Replace with the actual path to your vault-server.hcl
  etag   = filemd5("path/to/your/vault-server.hcl")  # Replace with the actual path to your vault-server.hcl
}