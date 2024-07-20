terraform{
    required_providers {
      azurerm = {
        source ="hashicorp/azurerm"
        version = "=3.0"
      }
    }
  backend "azurerm" {
  subscription_id="8df6808f-a8fb-4c7f-8f95-5d8baa1355f9"
  resource_group_name   = "rg-terraform"
  storage_account_name  = "teostorageunitbv"
  key                   = "terraform.tfstate"
  container_name        = "teocontainer"
  use_azuread_auth      = true
}
}
provider "azurerm"{
    features{}
}