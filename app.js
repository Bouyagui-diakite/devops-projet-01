// app.js — on définit l'application Express ICI, et on l'exporte.
const express = require("express");
const { pool } = require("./db");
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

// NOUVELLE route : incrémente un compteur de visites stocké en base.
// À chaque appel, on ajoute 1 et on renvoie la nouvelle valeur.
app.get("/visites", async (req, res) => {
  try {
    const resultat = await pool.query(
      "UPDATE visites SET compteur = compteur + 1 WHERE id = 1 RETURNING compteur"
    );
    res.json({ visites: resultat.rows[0].compteur });
  } catch (err) {
    res.status(500).json({ erreur: "Problème avec la base de données" });
  }
});

module.exports = app;
