# Блок настроек Terraform
terraform {
  # Определение необходимых провайдеров
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }

  # Минимальная версия Terraform
  required_version = ">=1.8.4"
}

# Настройка провайдера Yandex Cloud
provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = file("~/.authorized_key.json")
}