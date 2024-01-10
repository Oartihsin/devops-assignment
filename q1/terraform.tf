terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
  registry_auth {
    address = "https://registry-1.docker.io/v2/"
    username = var.username
    password = var.password
  }
}

resource "docker_registry_image" "helloworld" {
  name          = docker_image.image.name
  keep_remotely = true
}

resource "docker_image" "image" {
  name = var.image_name
  build {
    context = "."
  }
}
