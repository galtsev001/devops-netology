terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAAAAACi01KAATuwejtKPJgT0QEqrZpbORoEi4"
  cloud_id  = "b1g57d4rv7a3m4dmuhro"
  folder_id = "b1geodooefjvhq6dtnii"
  zone      = local.zone
}

locals {
  zone           = "ru-central1-a"
  public_subnet  = "192.168.10.0/24"
  private_subnet = "192.168.20.0/24"
  nat_image_id   = "fd80mrhj8fl2oe87o4e1"
  nat_gateway    = "192.168.10.254"
}