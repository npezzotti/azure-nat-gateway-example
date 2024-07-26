terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.113.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.2"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "random_id" "example" {
  byte_length = 8
}
