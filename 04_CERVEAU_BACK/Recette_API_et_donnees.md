# Recette — API et données

> Cerveau [BACK](00_Cerveau_BACK.md).

1. **Modèle de données** (`domain-modeling`, 15 minutes) : les entités du glossaire, leurs champs, leurs liens. Le plus petit modèle qui permet le parcours principal.
2. **Contrat d'API avant 18h**, dans la tâche « contrat d'API » : pour chaque route, méthode + chemin + exemple de requête + exemple de réponse JSON + erreurs possibles. FRONT code contre ce contrat.
3. **Stockage le plus simple qui tient la démo :** fichier JSON ou SQLite si possible ; une base hébergée (PostgreSQL) seulement si le sujet l'exige. Vérifier avec INFRA que l'hébergeur le supporte : sur des fonctions serverless, SQLite perd ses données. Langage, framework et base : `00_CERVEAU_MERE/04_Choix_de_stack.md`.
4. **`tdd` sur la logique métier** (calculs, règles, filtres) : c'est ce qui casse en démo.
5. **Secrets** (clés d'API, mots de passe) : variables d'environnement, fichier `.env` local non commité (ajouter `.env` au `.gitignore` de `app/`). `check.sh` ne détecte pas une clé d'API : c'est à toi.
6. **CORS** ouvert au domaine du front dès le premier déploiement.
7. **Données de démo** : un script ou un fichier de seed, relancé avant 7h.

## Pièges
- Construire une authentification que le parcours n'exige pas.
- Changer le contrat d'API sans prévenir FRONT (toujours dans la tâche, à voix haute).
- Refaire le modèle de données après 23h.
