# 👥 Équipe

> Cerveau Mère · [Orchestrateur](00_Orchestrateur.md). 8 membres, 8 cerveaux : chacun en tient un.

## Qui tient quoi

La source est le champ `cerveau:` des profils dans `equipe/` (écrit par `/setup`). Pour savoir qui tient un cerveau : `/point`, ou `grep -l "cerveau: 03_CERVEAU_FRONT" equipe/*.md`.

| Cerveau | Tient | Arbitre dans son lobe |
|---|---|---|
| 00 CERVEAU MÈRE | Raji (chef) | route, gates, arbitrage global, lance `/sujet` |
| 01 SUJET | un membre | le périmètre : ce qu'on fait et ce qu'on ne fait pas |
| 02 DESIGN | un membre | la maquette et les parcours |
| 03 FRONT | un membre | la structure de `app/` côté interface |
| 04 BACK | un membre | le contrat d'API et le modèle de données |
| 05 INFRA | un membre | l'hébergement et `main` déployable |
| 06 DÉFIS | un membre | le choix des défis et leurs rendus |
| 07 PITCH | un membre | la démo, la gate de livraison avec Raji |

**Tenir un cerveau** ne veut pas dire tout faire seul : les tâches vont à ceux dont le profil colle (pôle, points forts). Le responsable garde ses fichiers à jour, répond aux questions de son domaine et prévient Raji quand un jalon est en danger.

## Comment on se parle

- **Une question sur une tâche** → commentaire dans son issue (trace pour tous). Rien de perso : le repo est public.
- **Un blocage** → on le dit tout de suite à voix haute au responsable du cerveau concerné, puis dans l'issue.
- **Toutes les heures** : Raji lance `/point` et annonce les retards ; chacun lance `/sync`.
- **Une pause** (conseillé : 20 minutes entre 1h et 5h) → on la dit avant de partir, la tâche reste assignée.
- **Une idée nouvelle après 3h** → issue avec « plus tard » dans le titre, pas de code.
