terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">=2.2.0"
    }
  }

  backend "azurerm" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true
    }

    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = true
    }

    virtual_machine_scale_set {
      force_delete                  = true
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = false
    }
  }
}

provider "cloudinit" {
}
