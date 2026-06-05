// server.js — le point d'entrée qui DÉMARRE le serveur.
const app = require("./app");
const { initDb } = require("./db");

const PORT = process.env.PORT || 3000;

// On prépare la base AVANT de démarrer le serveur.
initDb()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`API démarrée sur le port ${PORT}`);
    });
  })
  .catch((err) => {
    console.error("Échec du démarrage :", err.message);
    process.exit(1);
  });
