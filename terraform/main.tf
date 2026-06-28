# main.tf — notre première infrastructure décrite en code (Terraform).
# Objectif : créer un conteneur nginx (un serveur web) SANS docker run,
# uniquement en décrivant ce qu'on veut. Terraform se charge du reste.

# === BLOC 1 : de quels "fournisseurs" (providers) a-t-on besoin ? ===
# Un provider = un plugin qui permet à Terraform de piloter un système.
# Ici on veut piloter Docker, donc on déclare le provider Docker.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"  # d'où télécharger le plugin
      version = "~> 3.0"              # quelle version (3.x)
    }
  }
}

# === BLOC 2 : configurer le provider ===
# On configure la connexion à Docker. Vide = utilise le Docker local
# (Docker Desktop) par défaut. C'est tout ce dont on a besoin.
provider "docker" {}

# === BLOC 3 : une RESSOURCE = un objet qu'on veut créer ===
# Première ressource : l'image nginx (équivalent de "docker pull nginx").
# Syntaxe : resource "<type>" "<nom_interne>" { ... }
resource "docker_image" "nginx" {
  name         = var.image_docker  # ← la variable (maintenant "mon-api:1.0")
  keep_locally = true              # GARDER l'image au "destroy" (c'est la TIENNE,
                                   # construite localement : on ne veut pas la perdre)
}

# === BLOC 4 : la ressource conteneur (équivalent de "docker run") ===
resource "docker_container" "serveur_web" {
  name  = var.nom_conteneur            # ← la variable, au lieu du texte en dur
  image = docker_image.nginx.image_id  # ← on RÉFÉRENCE l'image du bloc 3

  ports {
    internal = var.port_interne    # port DANS le conteneur (ton app écoute sur 3000)
    external = var.port_externe    # port sur ta machine
  }
}
