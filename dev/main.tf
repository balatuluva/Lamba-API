resource "aws_lambda_function" "lambda" {
  function_name = "dev-lambda"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs22.x"
  memory_size   = 256
  timeout       = 30
  architectures = ["arm64"]

  environment {
    variables = {
      NODE_ENV        = "production"
      LOG_LEVEL       = "info"
      DD_API_KEY      = "datadog-api-key"
      DD_SERVICE      = "customs-api-purchase-orders"
      DD_TRACE_DEBUG  = "false"
      DB_DIALECT      = "mysql"
      DB_NAME         = "po_master"
      # DB cluster url
      DB_HOST         = "RDS.com"
      DB_PORT         = "3306"
      DB_USERNAME     = aws_secretsmanager_secret.db_secret.name
      DB_PASSWORD     = aws_secretsmanager_secret_version.db_secret_version.secret_string
      DB_SSL          = "false"
      DB_LOGGING      = "false"
    }
  }

  vpc_config {
    count = length(data.aws_subnets.RDS_Subnets)
    subnet_ids = "${element(data.aws_subnets.RDS_Subnets.ids, count.index)}"
    security_group_ids =
  }

  source_code_hash = "github.com"
  filename         = "deployment.zip"
}