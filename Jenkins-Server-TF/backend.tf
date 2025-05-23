terraform {
  backend "s3" {
    bucket         = "k8s-tetris-proj"
    region         = "ap-south-1"
    key            = "jenkins-server/backend.tfstate"
    dynamodb_table = "k8s-tetris-Table"
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
