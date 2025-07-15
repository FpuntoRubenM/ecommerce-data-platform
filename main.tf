
provider "aws" {
  region = var.aws_region
}

module "kinesis_data_stream" {
  source        = "./modules/kinesis_data_streams"
  stream_name   = "${var.project_name}-${var.environment}-data-stream"
  shard_count   = 1
  project_name  = var.project_name
  environment   = var.environment
}

module "kinesis_data_analytics" {
  source             = "./modules/kinesis_data_analytics"
  application_name   = "${var.project_name}-${var.environment}-analytics-app"
  input_stream_arn   = module.kinesis_data_stream.stream_arn
  project_name       = var.project_name
  environment        = var.environment
}

module "kinesis_firehose" {
  source               = "./modules/kinesis_firehose"
  delivery_stream_name = "${var.project_name}-${var.environment}-firehose-stream"
  input_stream_arn     = module.kinesis_data_analytics.application_arn # Firehose lee de Kinesis Data Analytics
  project_name         = var.project_name
  environment          = var.environment
}

module "redshift_cluster" {
  source              = "./modules/redshift"
  cluster_identifier  = "${var.project_name}-${var.environment}-redshift-cluster"
  master_username     = "redshiftadmin"
  master_password     = "${var.project_name}Pass123!"
  s3_bucket_arn       = module.kinesis_firehose.firehose_bucket_arn
  project_name        = var.project_name
  environment         = var.environment
}
