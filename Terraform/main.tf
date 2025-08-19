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

# Création des machines virtuelles avec les configurations définies dans la variable vms_linux
resource "proxmox_vm_qemu" "vms" {

  for_each = var.vms_linux

  vmid        = each.value.vm_id
  name        = each.value.name
  target_node = var.target_node
  agent       = 1
  cpu {
      cores       = each.value.cores
    }

  memory      = each.value.memory
  boot        = "order=scsi0" # has to be the same as the OS disk of the template
  clone       = "TemplateWindowsServer"
  full_clone   = true
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = each.value.ipconfig0
  skip_ipv6  = true
  ciuser     = "Administrator"
  cipassword = "Formation13@"
  sshkeys    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoKv+RKVJkWdveH40aFzXAvqahx09jGI/4G3WO49D/f7/uQIopbOsXHkC4HxdGVYy/Jfbg5Io3acorLwKWy3xz5O9R0mERBPh6ZyCRv5uq+eRTttYPesdb8fisqJTwwmTJC0LzYb4w1R9MDhdU8LHrEatkNMuxWY52W4rWnomsBJCt0bzhrJ1zilvvsXvtGzbboVgDiysvVbIkHfFp2JSzO+G8kPoNCGRJjZ6Zef7LI91dHTtQAKhuTT8PRkQ9RxVfeM6vKbfQkEYBU47L2gdxx41AXRxBH0Teap1pC6yxMHJYxT4riehKLf+n9Q/yHmGDbiREtPQDI4hW1XJAqHIdj5XYLL+AxsyGXWKmZcgnyCwWKOfOF5/QFvqoB/BFBBs7fci/XJi/1pviuoRCdvVXIYjcEO9r7+RhHakIAp1jnn5Sb0tSdKNqFTxdfcgM86SYFqY86NLwu/6F7pEuYi6s77u/qFNLp3g1FS0xdD5EtPTI2tuf+r2p+ZJWyxk1AFy8ydRYDoZD+EggChQ6rFtM8bHtWFznqenIfxCpDQ8hq4NgdwunEPMOvWzKGMOrEUvW3EoUYhwCdjEuozWKAnIMlgXbe5qIlrxxEWomswZ+tfUOAqSQG8NvYRAuQqVsdmrFwSkDBRhLJv5XX9M/xyvlobRP5Zwtb4+iFj03ymxdYQ== admin@MacBook-Pro.local"

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = each.value.disk_size
          discard = true
          emulatessd = true
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id = 0
    bridge = each.value.network_bridge
    model  = "virtio"
  }
}