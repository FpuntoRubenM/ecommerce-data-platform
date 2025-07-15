resource "aws_kinesis_analytics_application" "analytics_app" {
  name = var.application_name
  runtime_environment = "FLINK-1_15"
  service_execution_role = aws_iam_role.analytics_role.arn

  application_configuration {
    application_code_configuration {
      code_content {
        text_content = var.application_code
      }
      code_content_type = "PLAINTEXT"
    }

    sql_application_configuration {
      input {
        name_prefix = "SOURCE_SQL_STREAM"
        kinesis_streams_input {
          resource_arn = var.input_stream_arn
        }
        input_schema {
          record_format {
            record_format_type = "JSON"
            mapping_parameters {
              json_mapping_parameters {
                record_row_path = "$"
              }
            }
          }
          record_columns {
            name = "data"
            sql_type = "VARCHAR(65536)"
          }
        }
      }
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "analytics_role" {
  name = "${var.application_name}-analytics-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
      },
    ],
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "analytics_policy" {
  name = "${var.application_name}-analytics-policy"
  role = aws_iam_role.analytics_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
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

output "application_name" {
  description = "El nombre de la aplicación Kinesis Data Analytics."
  value       = aws_kinesis_analytics_application.analytics_app.name
}

output "application_arn" {
  description = "El ARN de la aplicación Kinesis Data Analytics."
  value       = aws_kinesis_analytics_application.analytics_app.arn
}
