# génération de la clé SSH pour les conteneurs LXC
resource "tls_private_key" "lxc_ssh_key" {
  for_each = var.lxc_linux
  algorithm = "ED25519"
}

# Enregistrement de la clé privée SSH dans un fichier local
resource "local_file" "private_key" {

  for_each = var.lxc_linux

 content  = tls_private_key.lxc_ssh_key[each.key].private_key_openssh
 filename = pathexpand("~/.ssh/${each.value.name}-ed25519")
 file_permission = "0600"
}

# Création des conteneurs LXC avec les configurations définies dans la variable lxc_linux
resource "proxmox_lxc" "lxc_linux" {

  for_each = var.lxc_linux

  target_node      = var.target_node
  hostname         = each.value.name
  vmid             = each.value.lxc_id
  ostemplate       = var.chemin_cttemplate
  password         = "Formation13@"
  start            = true
  cores            = each.value.cores
  memory           = each.value.memory
  ssh_public_keys  = tls_private_key.lxc_ssh_key[each.key].public_key_openssh
  unprivileged     = true
  nameserver       = "1.1.1.1 8.8.8.8"


  rootfs {
    storage = "local-lvm"
    size    = each.value.disk_size
  }

  network {
   name     = "eth0"
   bridge   = each.value.network_bridge
   ip       = each.value.ipconfig0
   gw       = each.value.gw
   firewall = false
  }


  features {
    nesting = true
  }
}

