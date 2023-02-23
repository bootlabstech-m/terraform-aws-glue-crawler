variable "role_arn" {
  description = "Role ARN"
  type        = string
}
variable "region" {
  description = "Region"
  type        = string
}
variable "crawler_name" {
  description = "Name of the crawlers"
  type        = list(string)
}
variable "s3_target" {
  description = "ARN of the bucket for the crawler."
  type        = list(string)
}
variable "catalog_database_name" {
  description = "catalog_database_name"
  type        =  string
}

variable "no_of_glue_crawlers" {
  description = "no of glue crawlers to be created."
  type        =  number
}


