terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

# Creating an S3 bucket which uses the random pet resource for its name
resource "aws_s3_bucket" "test_s3_bucket" {
  bucket = random_pet.bucketname.id

  tags = {
    public_bucket = false
  }
}


resource "random_pet" "bucketname" {
    length = 4
}