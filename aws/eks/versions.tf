terraform {
  required_version = ">=1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.45.0" # Allows the rightmost version to change, eg 5.45.1
    }
  }
}