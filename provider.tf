provider "aws" {
  region                      = "us-east-1"
  access_key                  = "temp"
  secret_key                  = "temp"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true

  endpoints {
    dynamodb = "http://localhost:4566"
    lambda   = "http://localhost:4566"
    ec2      = "http://localhost:4566"
  }
}
