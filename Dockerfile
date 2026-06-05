# Dockerfile — la "recette" pour construire l'image de notre app.
# Chaque ligne crée une "couche" (layer) empilée.

# 1. On part d'une image de base : Node.js 22 en version "slim" (légère).
#    C'est comme dire "installe-moi un OS Linux avec Node déjà dedans".
FROM node:22-slim

# 2. On définit le dossier de travail à l'intérieur du conteneur.
#    Toutes les commandes suivantes s'exécutent depuis /app.
WORKDIR /app

# 3. On copie d'abord SEULEMENT package.json, puis on installe les dépendances.
#    Astuce de pro : on copie package.json avant le reste du code pour que
#    Docker garde en cache l'étape "npm install" tant que les dépendances
#    ne changent pas → builds beaucoup plus rapides.
COPY package.json ./
RUN npm install --omit=dev

# 4. Maintenant on copie le reste du code source.
COPY . .

# 5. On documente le port utilisé par l'app (informatif).
EXPOSE 3000

# 6. La commande lancée au démarrage du conteneur.
CMD ["node", "server.js"]
