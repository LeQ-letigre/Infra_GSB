variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
  sensitive = true
}

variable "proxmox_api_token" {
  type = string
  sensitive = true
}

variable "target_node" {
  type = string  
}

variable "chemin_cttemplate" {
  description = "chemin iso ct template"
  type = string
  
}

variable "lxc_linux" {
  type = map(object({
    lxc_id = number
    name = string
    cores = number
    memory = number
    disk_size = string
    ipconfig0 = string
    gw = string
    network_bridge = string
  }))
  
}

variable "vms_linux" {
  type = map(object({
    vm_id = number
    name = string
    cores = number
    memory = number
    disk_size = string
    ipconfig0 = string
    network_bridge = string
  }))
  
}