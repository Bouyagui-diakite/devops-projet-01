// app.js — on définit l'application Express ICI, et on l'exporte.
// On ne la démarre PAS ici. Pourquoi ? Pour pouvoir l'importer dans
// les tests sans lancer un vrai serveur. C'est une bonne pratique clé :
// séparer "définir l'app" de "démarrer le serveur".
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.json({
    message: "Bonjour depuis mon conteneur Docker !",
    hostname: require("os").hostname(),
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});

module.exports = app; // on exporte l'app pour server.js ET pour les tests
