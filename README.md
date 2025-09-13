

<div align="center">
	<h1>🚀 Infra_GSB 🛠️</h1>
	<p>
		<img src="https://img.shields.io/badge/ansible-automation-blue?logo=ansible" alt="Ansible">
		<img src="https://img.shields.io/badge/terraform-infra-purple?logo=terraform" alt="Terraform">
		<img src="https://img.shields.io/badge/proxmox-virtualization-orange?logo=proxmox" alt="Proxmox">
	</p>
 	<p> Infrastructure automatisée pour le déploiement de services 🧩</p>
</div>

Ce projet fournit une infrastructure complète pour le déploiement et la gestion de services via <strong>Ansible</strong> et <strong>Terraform</strong>. Il inclut la gestion de rôles Ansible pour divers services (<span style="color:#00bfae">AdGuard</span>, <span style="color:#f9d923">GLPI</span>, <span style="color:#ff6f61">Uptime Kuma</span>, etc.) et l'automatisation de la création de machines virtuelles et conteneurs sous Proxmox via Terraform.


## 🗂️ Structure du projet

```text
Infra_GSB/
├── Ansible/
│   ├── 00_inventory.yml
│   ├── ansible.cfg
│   ├── Install_InfraGSB.yml
│   ├── requirements.yml
│   ├── group_vars/
│   └── roles/
│       ├── Adguard/
│       ├── GLPI/
│       ├── Install_Docker/
│       ├── MAJ/
│       ├── PromouvoirAD01/
│       ├── ReplicationAD02/
│       └── Uptime_Kuma/
└── Terraform/
	├── confs.auto.tfvars
	├── main.tf
	├── provider.tf
	├── secrets.auto.tfvars.exemple
	└── variables.tf
```


## 🧰 Prérequis

- [Ansible](https://www.ansible.com/) ⚙️
- [Terraform](https://www.terraform.io/) 🏗️
- Accès à un cluster Proxmox avec API activée 🖥️
- Accès sudo/root sur les machines cibles 🔑


## 🌱 Déploiement avec Terraform

1. <strong>Configurer les variables</strong> dans <code>Terraform/variables.tf</code> et créer un fichier <code>secrets.auto.tfvars</code> à partir de l’exemple.
2. Initialiser Terraform :
	```sh
	cd Terraform
	terraform init
	```
3. Appliquer la configuration :
	```sh
	terraform apply
	```


## 🤖 Déploiement avec Ansible

1. Installer les dépendances :
	```sh
	cd Ansible
	ansible-galaxy install -r requirements.yml
	```
2. Adapter l’inventaire dans <code>00_inventory.yml</code> et les variables dans <code>group_vars/all.yml</code>.
3. Lancer le playbook principal :
	```sh
	ansible-playbook Install_InfraGSB.yml
	```


## 🧩 Rôles Ansible disponibles

- <strong>🛡️ Adguard</strong> : Installation et configuration d’AdGuard Home ([Ansible/roles/Adguard](Ansible/roles/Adguard/README.md))
- <strong>📋 GLPI</strong> : Déploiement de GLPI ([Ansible/roles/GLPI](Ansible/roles/GLPI/README.md))
- <strong>🐳 Install_Docker</strong> : Installation de Docker ([Ansible/roles/Install_Docker](Ansible/roles/Install_Docker/README.md))
- <strong>🔄 MAJ</strong> : Gestion des mises à jour ([Ansible/roles/MAJ](Ansible/roles/MAJ/README.md))
- <strong>🏢 PromouvoirAD01</strong> : Promotion d’un contrôleur de domaine AD ([Ansible/roles/PromouvoirAD01](Ansible/roles/PromouvoirAD01/README.md))
- <strong>🧬 ReplicationAD02</strong> : Réplication d’un second contrôleur AD ([Ansible/roles/ReplicationAD02](Ansible/roles/ReplicationAD02/README.md))
- <strong>📈 Uptime_Kuma</strong> : Supervision avec Uptime Kuma ([Ansible/roles/Uptime_Kuma](Ansible/roles/Uptime_Kuma/README.md))


## 🎨 Personnalisation

- Modifiez les variables dans <code>group_vars/all.yml</code> pour adapter les rôles à vos besoins.
- Ajoutez ou retirez des rôles dans le playbook principal <code>Install_InfraGSB.yml</code>.


## 👨‍💻 Auteurs

Projet réalisé par des tigres et pour des tigres... J'ai nommé Nonow et Le Q
