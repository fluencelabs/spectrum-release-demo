variable "virtual_ip" {
  type        = string
  description = "IP shared between control-plane nodes"
  default     = ""
}

variable "cluster_name" {
  type = string
}

variable "talos_version" {
  type    = string
  default = "v1.9"
}

variable "control_planes" {
  type = list(object({
    name           = string
    server_ip      = string
    config_patches = list(string)
  }))
}

variable "workers" {
  type = list(object({
    name           = string
    server_ip      = string
    config_patches = list(string)
  }))
  default = []
}
