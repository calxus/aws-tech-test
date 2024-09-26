variable "name" {
  type = string
}

variable "cluster" {
  type = string
}

variable "vpc" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "image" {
  type = string
}

variable "port" {
  type = number
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "health_endpoint" {
  type = string
}

variable "log_group" {
  type = string
}

variable "loadbalancer_sg" {
  type = string
}

variable "listener" {
  type = string
}