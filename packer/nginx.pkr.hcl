packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "nginx_build" {
  image  = "nginx:latest"
  commit = true
}

build {
  sources = ["source.docker.nginx_build"]

  # Copie du fichier index.html du repo vers l'image
  provisioner "file" {
    source      = "./index.html"
    destination = "/usr/share/nginx/html/index.html"
  }

  post-processor "docker-tag" {
    repository = "my-custom-nginx"
    tag        = ["v1"]
  }
}