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

vms_linux = {
    "AD-01" = {
    vm_id = 111
    name = "AD-01"
    cores = 2
    memory = 4096
    ipconfig0 = "ip=172.16.0.1/24,gw=172.16.0.254"
    disk_size = "30G"
    network_bridge = "vmbr0"
    }

    "AD-02" = {
    vm_id = 112
    name = "AD-02"
    cores = 2
    memory = 4096
    ipconfig0 = "ip=172.16.0.2/24,gw=172.16.0.254"
    disk_size = "30G"
    network_bridge = "vmbr0"
    }
}