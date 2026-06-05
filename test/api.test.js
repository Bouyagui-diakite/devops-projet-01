// test/api.test.js — des tests automatisés pour notre API.
// On utilise le testeur intégré de Node ("node:test", dispo depuis Node 18+)
// et "supertest" qui simule des requêtes HTTP sur l'app SANS démarrer un
// vrai serveur réseau.
const { test } = require("node:test");
const assert = require("node:assert");
const request = require("supertest");
const app = require("../app");

test("GET /health renvoie 200 et status ok", async () =>
   {
  const res = await request(app).get("/health");
  assert.strictEqual(res.statusCode, 200);
  assert.strictEqual(res.body.status, "ok");
});

test("GET / renvoie un message de bienvenue", async () => {
  const res = await request(app).get("/");
  assert.strictEqual(res.statusCode, 200);
  assert.ok(res.body.message.includes("Bonjour"));
});
