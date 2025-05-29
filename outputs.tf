output "portfolio_id" {
  description = "ID of the Service Catalog Portfolio"
  value       = aws_servicecatalog_portfolio.s3_portfolio.id
}

output "product_id" {
  description = "ID of the Service Catalog Product"
  value       = aws_servicecatalog_product.s3_product.id
}