terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0" # AWS provider version, not terraform version
    }
  }
  
   backend "s3" {
    bucket = "brahmam005-remote-state"
    key    = "provisioners"
    region = "us-east-1"
     dynamodb_table = "brahmam005-locking"
    }
}


provider "aws" {
  region = "us-east-1"
}