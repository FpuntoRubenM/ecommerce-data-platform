resource "aws_s3_bucket" "firehose_bucket" {
  bucket = "${var.project_name}-${var.environment}-firehose-bucket"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "firehose_bucket_acl" {
  bucket = aws_s3_bucket.firehose_bucket.id
  acl    = "private"
}

resource "aws_iam_role" "firehose_role" {
  name = "${var.project_name}-${var.environment}-firehose-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      },
    ],
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "firehose_policy" {
  name = "${var.project_name}-${var.environment}-firehose-policy"
  role = aws_iam_role.firehose_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.firehose_bucket.arn,
          "${aws_s3_bucket.firehose_bucket.arn}/*"
        ]
      },
      {
        Action = [
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:ListShards"
        ]
        Effect   = "Allow"
        Resource = var.input_stream_arn
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

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = var.delivery_stream_name
  destination = "s3"

  s3_configuration {
    role_arn           = aws_iam_role.firehose_role.arn
    bucket_arn         = aws_s3_bucket.firehose_bucket.arn
    buffer_size        = 5 # MB
    buffer_interval    = 300 # seconds
    compression_format = "UNCOMPRESSED"
  }

  # Si la fuente es Kinesis Data Stream
  kinesis_source_configuration {
    kinesis_stream_arn = var.input_stream_arn
    role_arn           = aws_iam_role.firehose_role.arn
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

output "delivery_stream_name" {
  description = "El nombre del Kinesis Firehose Delivery Stream."
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.name
}

output "delivery_stream_arn" {
  description = "El ARN del Kinesis Firehose Delivery Stream."
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.arn
}

output "firehose_bucket_name" {
  description = "El nombre del bucket S3 de destino de Firehose."
  value       = aws_s3_bucket.firehose_bucket.id
}
