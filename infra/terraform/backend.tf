terraform {
  backend "s3" {
    bucket         = "bimbo-terraform-state-devops"
    key            = "devops-stage-6/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}
