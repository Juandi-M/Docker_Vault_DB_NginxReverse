# S3 Bucket for Vault and Nginx Configurations
resource "aws_s3_bucket" "vault_nginx_config_bucket" {
  bucket = local.s3_bucket_name
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
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:GetObject",
        Effect   = "Allow",
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
  source = "path/to/your/nginx.conf"          # Replace with the actual path to your nginx.conf
  etag   = filemd5("path/to/your/nginx.conf") # Replace with the actual path
}