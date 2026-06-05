// server.js — le point d'entrée qui DÉMARRE le serveur.
// Il importe l'app définie dans app.js et la met à l'écoute.
const app = require("./app");

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`API démarrée sur le port ${PORT}`);
});
