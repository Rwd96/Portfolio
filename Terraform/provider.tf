terraform {
  backend "s3" {
    bucket = "www.orsade.click-portfolio-terraform.tfstate"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"    
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

