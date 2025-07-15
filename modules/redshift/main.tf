resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = var.cluster_identifier
  node_type          = var.node_type
  cluster_type       = var.cluster_type
  master_username    = var.master_username
  master_password    = var.master_password
  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible = var.publicly_accessible
  db_name            = var.db_name
  iam_roles          = [aws_iam_role.redshift_role.arn]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "redshift_role" {
  name = "${var.cluster_identifier}-redshift-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      },
    ],
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "redshift_policy" {
  name = "${var.cluster_identifier}-redshift-policy"
  role = aws_iam_role.redshift_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

output "cluster_endpoint" {
  description = "El endpoint del clúster de Redshift."
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}

output "cluster_arn" {
  description = "El ARN del clúster de Redshift."
  value       = aws_redshift_cluster.redshift_cluster.arn
}
