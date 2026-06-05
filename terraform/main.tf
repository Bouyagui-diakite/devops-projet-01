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
  name         = "nginx:latest"  # quelle image récupérer
  keep_locally = false           # supprimer l'image au "destroy"
}

# === BLOC 4 : la ressource conteneur (équivalent de "docker run") ===
resource "docker_container" "serveur_web" {
  name  = "mon-serveur-terraform"      # nom du conteneur
  image = docker_image.nginx.image_id  # ← on RÉFÉRENCE l'image du bloc 3

  ports {
    internal = 80    # port à l'intérieur du conteneur (nginx écoute sur 80)
    external = 8081  # port sur ta machine (http://localhost:8081)
  }
}
