resource "yandex_vpc_network" "sentry" {
  name      = "vpc"
  folder_id = local.folder_id
}

resource "yandex_vpc_subnet" "sentry" {
  folder_id      = local.folder_id
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.sentry.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
