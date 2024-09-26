resource "aws_ecr_repository" "poc" {
  name = var.name

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "docker_registry_image" "poc" {
  name = "${aws_ecr_repository.poc.repository_url}:${var.service_version}"

  build {
    context    = "../app/"
    dockerfile = "Dockerfile"
  }
}