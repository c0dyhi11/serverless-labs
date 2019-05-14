variable "auth_token" {
}

variable "hostname" {
  default = "detroit-k8s"
}

variable "project_id" {
}

variable "server_size" {
  default = "baremetal_0"
}

variable "facility" {
  default = "ewr1"
}

variable "operating_system" {
  default = "ubuntu_16_04"
}

variable "billing_cycle" {
  default = "hourly"
}

variable "server_count" {
  default = 10
}