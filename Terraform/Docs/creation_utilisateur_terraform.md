# Création d’un utilisateur Terraform sur Proxmox avec jeton API

Ce guide explique comment créer un utilisateur dédié **Terraform** sur Proxmox, lui attribuer les droits nécessaires et générer un **jeton API**. Vous pourrez ensuite renseigner ces informations dans votre fichier `secret.auto.tfvars`.

---

## 🔹 Étape 1 : Créer l’utilisateur Terraform

1. Connectez-vous à l’interface **Proxmox VE** avec un compte administrateur (ex. `root@pam`).
2. Allez dans **Centre de données** → **Permissions** → **Utilisateurs** → **Ajouter**.
3. Renseignez :
   - **Nom d’utilisateur** : `terraform`
   - **Royaume** : `Proxmox VE` 
   - **Mot de passe** : définissez un mot de passe (exigé à la création, même si vous utiliserez un jeton ensuite).
4. Cliquez sur **Créer** / **Ajouter**.

---

## 🔹 Étape 2 : Attribuer le rôle à l’utilisateur

1. **Centre de données** → **Permissions**.
2. Cliquez sur **Ajouter** → **Autorisation d’utilisateur**.
3. Renseignez :
   - **Chemin** : `/` (donne des droits sur l’ensemble du cluster) — ou ciblez un nœud/ressource précis si vous voulez restreindre.
   - **Utilisateur** : `terraform@pve`
   - **Rôle** : `Administrator`
   - **Propager** : **activé**
4. Validez avec **Ajouter**.

---

## 🔹 Étape 3 : Créer un **Jeton API**

1. **Centre de données** → **Permissions** → **Jetons API** → **Ajouter**.
2. Paramètres :
   - **Utilisateur** : `terraform@pve`
   - **ID de jeton** : `tf` (par exemple) → cela donnera l’ID complet `terraform@pve!tf`
   - **Séparation des privilèges** : **activé** 
   - (Optionnel) **Expiration** : définissez une date d’expiration.
3. Cliquez sur **Créer** puis **copiez immédiatement le secret du jeton** (il n’est affiché **qu’une seule fois**).

---

## 🔹 Étape 4 : Renseigner le fichier `secret.auto.tfvars`

Ouvrez (ou créez) le fichier `secret.auto.tfvars` sur votre machine et indiquez :

```hcl
proxmox_api_url      = "https://VOTRE_IP_PROXMOX:8006/api2/json"
proxmox_api_token_id = "terraform@pve!tf"
proxmox_api_token    = "VOTRE_JETON_SECRET"
