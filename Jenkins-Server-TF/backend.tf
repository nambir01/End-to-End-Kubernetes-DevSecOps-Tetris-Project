terraform {
  backend "s3" {
    bucket         = "nambi-tf-270525-01"
    region         = "ap-south-1"
    key            = "End-to-End-Kubernetes-DevSecOps-Tetris-Project/Jenkins-Server-TF/terraform.tfstate"
    dynamodb_table = "Lock-File"
    encrypt        = true
  }

  required_version = ">=0.13.0"

  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
