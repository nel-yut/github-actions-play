provider "aws" {
  region = "ap-northeast-1"
}

# EC2インスタンス (t2.micro)
resource "aws_instance" "t2_micro" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 の AMI ID (リージョンによって異なる)
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-t2-micro"
  }
}

# EC2インスタンス (t3.medium)
resource "aws_instance" "t3_medium" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 の AMI ID (リージョンによって異なる)
  instance_type = "t3.medium"

  tags = {
    Name = "Terraform-t3-medium"
  }
}

# S3 バケット (50GB ストレージ)
resource "aws_s3_bucket" "example" {
  bucket = "example-terraform-bucket"
}

# RDSインスタンス (db.t3.micro)
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = "password123" # パスワードは必要に応じて変更
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = {
    Name = "Terraform-RDS"
  }
}

# CloudWatch メトリクスとログの保存 (基本的な設定)
resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/terraform/example"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "example-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    InstanceId = aws_instance.t2_micro.id
  }

  alarm_actions = []
}
