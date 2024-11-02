resource "yandex_iam_service_account" "instances" {
  folder_id   = ""
  name        = "instances"
  description = "service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = ""
  role      = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.instances.id}",
  ]
}

resource "yandex_kubernetes_cluster" "sentry" {
  name       = "sentry"
  folder_id  = ""
  network_id = yandex_vpc_network.sentry.id

  master {
    version = "1.30"
    zonal {
      zone      = yandex_vpc_subnet.sentry.zone
      subnet_id = yandex_vpc_subnet.sentry.id
    }

    public_ip = true
  }
  service_account_id      = yandex_iam_service_account.instances.id
  node_service_account_id = yandex_iam_service_account.instances.id


  release_channel = "STABLE"
}
