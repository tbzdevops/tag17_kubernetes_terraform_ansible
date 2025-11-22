terraform {
  backend "s3" {
    key            = "kubernetes/state.tfstate"
    encrypt        = true
  }
}

