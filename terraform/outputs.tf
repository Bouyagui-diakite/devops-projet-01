# outputs.tf — les infos que Terraform affiche après "apply".
# Un output se déclare avec : output "nom" { value = ... }

output "nom_du_conteneur" {
  description = "Nom du conteneur créé"
  # On lit la valeur directement sur la ressource créée.
  value = docker_container.serveur_web.name
}

output "url_acces" {
  description = "L'adresse pour accéder au serveur dans le navigateur"
  # On construit une chaîne avec la variable du port.
  # La syntaxe ${...} insère une valeur dans du texte (interpolation).
  value = "http://localhost:${var.port_externe}"
}
