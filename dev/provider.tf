provider "aws" {
  region = "${var.aws_region}"
}

#change bucket details below
terraform {
  backend "s3" {
    bucket = "balaterraformbucket"
    key = "dev.tfstate"
    region = "us-east-1"
  }
}