terraform {
  backend "s3" {
    bucket  = "devpanel-terraform"
    profile = "remote-account"
    region  = "us-east-2"
  }
}
