lxc_linux = {
  "Adguard" = {
    lxc_id = 113
    name = "Adguard"
    cores = 1
    memory = 1024
    ipconfig0 = "172.16.0.3/24"
    gw = "172.16.0.254"
    disk_size = "10G"
    network_bridge = "vmbr0"
    }

    "UptimeKuma" = {
    lxc_id = 114
    name = "UptimeKuma"
    cores = 1
    memory = 1024
    ipconfig0 = "172.16.0.4/24"
    gw = "172.16.0.254"
    disk_size = "10G"
    network_bridge = "vmbr0"
    }

    "GLPI" = {
    lxc_id = 115
    name = "GLPI"
    cores = 2
    memory = 2048
    ipconfig0 = "172.16.0.5/24"
    gw = "172.16.0.254"
    disk_size = "30G"
    disk_size = "20G"
    network_bridge = "vmbr0"
    }
}