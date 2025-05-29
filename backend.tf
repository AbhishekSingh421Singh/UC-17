terraform {
  backend "s3" {
    bucket         = "service-catlog-bucket"
    key            = "UC-17/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = false
  }
}