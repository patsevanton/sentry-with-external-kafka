locals {
  folder_id = ""
  k8s_version = "1.30"
  number_of_k8s_hosts = 3
  boot_disk = 128 # GB
  memory_of_k8s_hosts = 20
  cores_of_k8s_hosts = 4
  kafka_user = "sentry"
  kafka_password = "your_password_here"
}
