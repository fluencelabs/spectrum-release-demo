variable "network" {
  type    = string
  default = "main"
}

variable "cluster" {
  type    = string
  default = "default"
}

variable "cluster_flavour" {
  type = string
  default = "talos"
}

variable "cilium_hubble_enabled" {
  type    = bool
  default = false
}

variable "flux_variables" {
  type    = map(string)
  default = {}
}
