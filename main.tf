provider "aws" {
  region = "us-east-1"
}

resource "aws_servicecatalog_portfolio" "s3_portfolio" {
  name          = "S3 Portfolio"
  description   = "Portfolio for provisioning S3 buckets"
  provider_name = "YourName"
}

resource "aws_servicecatalog_product" "s3_product" {
  name        = "S3 Bucket Product"
  owner       = "YourName"
  description = "S3 bucket provisioning product"
  distributor = "YourCompany"
  support_description = "Contact support@example.com"
  support_email       = "support@example.com"
  support_url         = "https://example.com/support"
  type        = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    name         = "v1"
    type         = "CLOUD_FORMATION_TEMPLATE"
    template_url = "https://s3.amazonaws.com/service-catlog-bucket/s3_template.yml"
  }
}

resource "aws_servicecatalog_portfolio_product_association" "association" {
  portfolio_id = aws_servicecatalog_portfolio.s3_portfolio.id
  product_id   = aws_servicecatalog_product.s3_product.id
}

resource "aws_servicecatalog_constraint" "template_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.s3_portfolio.id
  product_id   = aws_servicecatalog_product.s3_product.id
  type         = "TEMPLATE"
  parameters   = jsonencode({
    Rule = {
      RuleName = "RegionConstraint"
      Assertions = [
        {
          Assert = "Fn::Equals([!Ref 'AWS::Region', 'us-east-1'])"
          AssertDescription = "Only us-east-1 is allowed"
        }
      ]
    }
  })
}

resource "aws_servicecatalog_constraint" "launch_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.s3_portfolio.id
  product_id   = aws_servicecatalog_product.s3_product.id
  type         = "LAUNCH"
  parameters   = jsonencode({
    RoleArn = "arn:aws:iam::144317819575:role/AWS-CataLog-Permission"
  })
}

resource "aws_servicecatalog_tag_option" "env_tag" {
  key   = "env1"
  value = "dev1"
}

resource "aws_servicecatalog_tag_option_resource_association" "tag_association" {
  resource_id   = aws_servicecatalog_product.s3_product.id
  tag_option_id = aws_servicecatalog_tag_option.env_tag.id
}

resource "aws_servicecatalog_principal_portfolio_association" "user_access" {
  portfolio_id   = aws_servicecatalog_portfolio.s3_portfolio.id
  principal_arn  = "arn:aws:iam::144317819575:user/cataloguser"
  principal_type = "IAM"
}