provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
}

