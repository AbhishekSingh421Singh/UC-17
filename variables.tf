
variable "template_url" {
  description = "URL of the CloudFormation template"
  type        = string
  default = "https://service-catlog-bucket.s3.us-east-1.amazonaws.com/s2_template.yml"
}

variable "launch_role_arn" {
  description = "ARN of the IAM role for launching the product"
  type        = string
  default = "arn:aws:iam::144317819575:role/servicecatalogaccesss"
}

variable "user_arn" {
  description = "ARN of the IAM user for accessing the portfolio"
  type        = string
  default = "arn:aws:iam::144317819575:user/cataloguser"
}