# Получение данных об образе ОС Ubuntu 24.04 LTS
data "yandex_compute_image" "ubuntu_2404_lts" {
  family = "ubuntu-2404-lts"
}

# Создание веб-серверов с использованием count
resource "yandex_compute_instance" "web" {
  count       = 2
  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2404_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }

  scheduling_policy { 
    preemptible = true 
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.LAN.id,
      yandex_vpc_security_group.web_sg.id
    ]
  }
}

# Создание inventory-файла для Ansible
resource "local_file" "inventory" {
  content = <<-XYZ
  [webservers]
  web-1       ansible_host=${yandex_compute_instance.web[0].network_interface.0.nat_ip_address}
  web-2       ansible_host=${yandex_compute_instance.web[1].network_interface.0.nat_ip_address}
  XYZ

  filename = ".hosts.ini"
}