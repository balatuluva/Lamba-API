data "aws_vpc" "RDS_VPC" {
  # VPC ID
  id = "12345"
}

data "aws_subnets" "RDS_Subnets" {
  # SUBNET IDS
  id = ["id-1", "id-2"]
}

data "aws_security_group" "RDS_SG" {
  # SG IDS
  id = ["id-1", "id-2"]
}