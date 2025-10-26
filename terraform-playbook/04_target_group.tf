# Создание динамической таргет-группы для балансировки нагрузки
resource "yandex_lb_target_group" "web_target_group" {
  name      = "web-target-group-${var.flow}"
  region_id = "ru-central1"

# Динамическое добавление целей на основе созданных виртуальных машин
  dynamic "target" {
    for_each = yandex_compute_instance.web
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}