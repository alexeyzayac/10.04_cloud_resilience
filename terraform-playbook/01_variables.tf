# Переменная для идентификации потока/версии
variable "flow" {
  type    = string
  default = "zayac-11-2025"
}

# Идентификатор облака в Yandex Cloud
variable "cloud_id" {
  type    = string
  default = "b1guknff8nknnqp3g18s"
}

# Идентификатор каталога в облаке Yandex Cloud
variable "folder_id" {
  type    = string
  default = "b1gb00710li9ve0ujpkm"
}