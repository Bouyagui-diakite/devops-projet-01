# variables.tf — on déclare ici toutes les valeurs configurables.
# Une variable se déclare avec le bloc : variable "nom" { ... }

variable "nom_conteneur" {
  description = "Le nom du conteneur à créer"  # explication (pour l'humain)
  type        = string                         # le type de la valeur attendue
  default     = "mon-serveur-terraform"        # valeur par défaut si non fournie
}

variable "port_externe" {
  description = "Le port exposé sur ta machine"
  type        = number                         # ici un nombre, pas du texte
  default     = 9090
}

variable "image_docker" {
  description = "L'image Docker à utiliser"
  type        = string
  default     = "mon-api:1.0"   # ← TON application (au lieu de nginx)
}

variable "port_interne" {
  description = "Le port sur lequel l'app écoute À L'INTÉRIEUR du conteneur"
  type        = number
  default     = 3000            # ton app Node écoute sur 3000
}
