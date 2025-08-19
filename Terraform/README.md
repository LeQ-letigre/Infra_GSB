# Déploiement de conteneurs LXC sur Proxmox avec Terraform

Ce projet permet d’automatiser la création et la gestion de conteneurs **LXC** dans l’infrastructure **GSB** sur **Proxmox VE** à l’aide de **Terraform**.

---

## 📦 Prérequis

- Un serveur **Proxmox VE** accessible avec une API activée.
- Un **token API** (ID + secret) créé dans l’interface Proxmox ([Docs création token API](https://github.com/LeQ-letigre/Infra_GSB/blob/main/Docs/creation_utilisateur_terraform.md)).
- **Terraform** installé sur votre machine ([Télécharger Terraform](https://developer.hashicorp.com/terraform/downloads)).
- Accès SSH/HTTPS au serveur Proxmox.

---

## 📂 Organisation des fichiers

- **`main.tf`** → définit les ressources (LXC à déployer).
- **`provider.tf`** → configure le provider Proxmox (connexion à l’API).
- **`variables.tf`** → déclare toutes les variables utilisées.
- **`confs.auto.tfvars`** → contient les paramètres généraux de chaque LXC (IP, hostname, ressources, etc.).
- **`secret.auto.tfvars`** → contient les informations de connexion sensibles (URL Proxmox, ID API, token API).  

---

## ⚙️ Configuration

1. Copier le dépôt GitHub sur votre machine :
   ```bash
   apt install git
   git clone https://github.com/LeQ-letigre/Infra_GSB.git
   ```
2. Aller dans le répertoire `Terraform_LXC`.
   ```bash
   cd /Infra_GSB/Terraform_LXC/
   ```
3. Modifier le fichier `secret.auto.tfvars` pour ajuster vos informations de connexion (URL Proxmox, ID API, token API).
   ```bash
   nano secret.auto.tfvars
   ```

---

## 🚀 Utilisation

Une fois vos fichiers configurés (`secret.auto.tfvars`), vous pouvez lancer Terraform.  
Voici les étapes principales :

---

### 1. Initialiser Terraform
```bash
terraform init
```
- Cette commande prépare **Terraform** pour ce projet.  
- Elle télécharge automatiquement le **provider Proxmox** (le plugin qui permet à Terraform de communiquer avec l’API Proxmox).  
- Elle configure aussi le dossier `.terraform/` où sont stockées les dépendances.  

📌 **Quand l’utiliser ?**  
- La première fois que vous ouvrez ce projet.  
- Après avoir modifié un fichier `provider.tf`.  
- Après avoir mis à jour la version de Terraform.

---

### 2. Vérifier le plan d’exécution
```bash
terraform plan
```
- Cette commande affiche une **simulation des changements** que Terraform va appliquer.  
- Elle compare :
  - Ce qui existe déjà dans **Proxmox** (vos conteneurs actuels).  
  - Ce que vous avez décrit dans vos fichiers Terraform (`.tf` et `.tfvars`).  
- Elle affiche ensuite une liste d’actions :  
  - `+` → une ressource sera **créée**  
  - `-` → une ressource sera **supprimée**  
  - `~` → une ressource sera **modifiée**  

📌 **Pourquoi c’est utile ?**  
Cela vous permet de vérifier **avant d’exécuter** que Terraform va bien faire ce que vous voulez (et éviter des erreurs ou suppressions accidentelles).

---

### 3. Appliquer la configuration (créer/modifier les conteneurs)
```bash
terraform apply
```
- Cette commande applique réellement les changements planifiés.  
- Par défaut, Terraform va d’abord afficher le **plan d’exécution** (comme avec `plan`) puis vous demander confirmation :  
  ```bash
  Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: 
  ```
- Vous devez taper `yes` pour valider.  
- Ensuite, Terraform va créer vos conteneurs LXC dans Proxmox avec les paramètres définis (`hostname`, `IP`, `CPU`, `RAM`, etc.).

📌 **Exemple typique** :  
- Vous ajoutez un nouveau conteneur dans `main.tf` → `terraform apply` va le déployer automatiquement sur Proxmox.  

---

### 4. Détruire les conteneurs (nettoyage)
```bash
terraform destroy
```
- Cette commande supprime **toutes les ressources** gérées par ce projet Terraform.  
- Comme pour `apply`, Terraform vous montrera un plan avant de demander confirmation (`yes`).  
- Une fois validé, tous les conteneurs créés via ce projet seront supprimés de Proxmox.

📌 **Quand l’utiliser ?**  
- Pour libérer de la place.  
- Pour nettoyer un environnement de test.  
- Avant de tout redéployer proprement.

---

## 📌 Résumé des commandes Terraform

| Commande             | Description simplifiée                                              |
|----------------------|----------------------------------------------------------------------|
| `terraform init`     | Prépare Terraform (télécharge les plugins nécessaires).             |
| `terraform plan`     | Montre **ce qui va être fait** (créations, modifications, suppressions). |
| `terraform apply`    | Applique les changements et crée/modifie les ressources.            |
| `terraform destroy`  | Supprime toutes les ressources créées par Terraform.                |

---

⚠️ **Important pour les débutants :**
- Toujours exécuter `terraform plan` **avant** `terraform apply`.  
- Ne jamais modifier directement les conteneurs créés via Proxmox (hors Terraform), car cela peut désynchroniser l’état.  
- Le fichier `terraform.tfstate` contient l’état actuel connu par Terraform → ne le supprimez pas et ne le partagez jamais publiquement (il peut contenir des informations sensibles).

---

### 🔑 Gestion des clés SSH par Terraform

Lors du déploiement de conteneurs, Terraform génère des **paires de clés SSH** afin de permettre la connexion automatique aux ressources créées.  

- La **clé privée** est stockée dans le dossier `~/.ssh/` de l’utilisateur qui exécute Terraform.  
- La **clé publique** est copiée dans le conteneur lors de sa création.  

---

## 🔒 Sécurité

- Le fichier **`secret.auto.tfvars`** contient vos ID et tokens secrets. **Ne le partagez jamais.**
- Les fichiers **`.tfstate`** peuvent également contenir des secrets. **Ne les partagez jamais.**
- Le dossier `~/.ssh/` contient vos clés SSH. **Ne les partagez jamais.**

---

## 📌 Bonnes pratiques

- Utiliser des fichiers `*.auto.tfvars` pour séparer la configuration et les secrets.
- Ne pas partager vos fichiers d’état Terraform (`terraform.tfstate`).

---

## 📝 Licence

Projet personnel / éducatif. À adapter selon vos besoins.
