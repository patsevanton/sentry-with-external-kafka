resource "yandex_iam_service_account" "sa-k8s-editor" {
  folder_id = local.folder_id
  name      = "sa-k8s-editor"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-editor-permissions" {
  folder_id = local.folder_id
  role      = "editor"

  member = "serviceAccount:${yandex_iam_service_account.sa-k8s-editor.id}"
}

resource "yandex_kubernetes_cluster" "sentry" {
  name       = "sentry"
  folder_id  = local.folder_id
  network_id = yandex_vpc_network.sentry.id

  master {
    version = "1.30"
    zonal {
      zone      = yandex_vpc_subnet.sentry.zone
      subnet_id = yandex_vpc_subnet.sentry.id
    }

    public_ip = true
  }
  service_account_id      = yandex_iam_service_account.sa-k8s-editor.id
  node_service_account_id = yandex_iam_service_account.sa-k8s-editor.id
  release_channel         = "STABLE"
  // to keep permissions of service account on destroy
  // until cluster will be destroyed
  depends_on = [yandex_resourcemanager_folder_iam_member.sa-k8s-editor-permissions]
}
