provider "aws" {
  region = "us-west-2"
}

# has to be done because cloudfront requires acm certificates to be created in us-east-1 region
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}