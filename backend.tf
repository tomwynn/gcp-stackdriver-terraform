terraform {
  backend "gcs"{
    bucket      = "global-soc-logging-terraform-state"
  }
}