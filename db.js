// db.js — la connexion à la base de données PostgreSQL.
const { Pool } = require("pg");

// Un "Pool" gère un ensemble de connexions réutilisables vers la base.
// IMPORTANT : on lit tous les paramètres depuis des variables
// d'environnement. On ne code RIEN en dur. C'est Docker Compose qui les
// fournira. En local sans Docker, les valeurs par défaut prennent le relais.
const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER || "postgres",
  password: process.env.DB_PASSWORD || "postgres",
  database: process.env.DB_NAME || "appdb",
});

// Prépare la base au démarrage : crée la table si elle n'existe pas,
// et insère la ligne du compteur à 0 si elle n'existe pas encore.
// On RÉESSAIE plusieurs fois car la base peut mettre quelques secondes
// à être prête au tout premier démarrage.
async function initDb() {
  for (let tentative = 1; tentative <= 10; tentative++) {
    try {
      await pool.query(`
        CREATE TABLE IF NOT EXISTS visites (
          id INT PRIMARY KEY,
          compteur INT NOT NULL
        )
      `);
      await pool.query(
        `INSERT INTO visites (id, compteur) VALUES (1, 0)
         ON CONFLICT (id) DO NOTHING`
      );
      console.log("Base de données prête.");
      return;
    } catch (err) {
      console.log(`DB pas encore prête (tentative ${tentative}/10), réessai dans 2s...`);
      await new Promise((r) => setTimeout(r, 2000));
    }
  }
  throw new Error("Impossible de se connecter à la base de données.");
}

module.exports = { pool, initDb };
