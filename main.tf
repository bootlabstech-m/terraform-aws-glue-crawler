resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
count               = var.no_of_catalog_databases
name                = var.catalog_database_name[count.index]
}

resource "aws_glue_crawler" "crawler" {
  count         = var.no_of_glue_crawlers
  database_name = var.catalog_database_name[count.index]
  name          = var.crawler_name[count.index]
  role          = aws_iam_role.crawler_role.arn
  s3_target {
    path = var.s3_target
  }
}
resource "aws_iam_role" "crawler_role" {
  name = "crawler_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17"
    "Statement" : [
      { 
       # "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Principal": {
        "Service": "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
      #  "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Principal": {
        "Service": "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }
  )
}
resource "aws_iam_role_policy_attachment" "crawler_policy_01" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.crawler_role.name
}
resource "aws_iam_role_policy_attachment" "crawler_policy_02" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  role = aws_iam_role.crawler_role.name
}