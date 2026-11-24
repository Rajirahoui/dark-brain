# Dark Brain v2 — architecture en cerveaux

Date : 2026-11-24 · Complète `2026-11-24-dark-brain-design.md` (v1 : repo, branches, Issues, skills) · Statut : à valider

## 1. Intention

Donner à Dark Brain la même logique qu'Ecom Brain, adaptée à la Nuit de l'Info : **un chef qui route, des cerveaux spécialisés qui exécutent, un fil chronologique, des gates**. Chaque membre sait quel cerveau il tient, quoi lire, quels skills lancer et à quel moment de la nuit. On y ajoute les skills de dev de Matt Pocock, l'étape de maquettage dans Claude Design, et un maximum d'information utile pour la nuit.

## 2. Décisions de Raji (2026-11-24)

- Découpage **par pôle + un cerveau Défis** (un sous-dossier par défi, créé à 16h39).
- **Un responsable par cerveau** : 8 membres = Cerveau Mère (Raji, chef) + 7 cerveaux spécialisés, un chacun.
- **Markdown lisible sur GitHub** : liens markdown relatifs, pas de wikilinks, Obsidian non requis.
- **Routage par une table dans l'orchestrateur**, lue via `CLAUDE.md`. Pas de hook, rien à installer.
- Skills Matt Pocock via plugin proposé à l'ouverture du dossier ; `/maquette` via Claude Design ; guide de la nuit (devient le PLAYBOOK).

## 3. Correspondance avec Ecom Brain

| Ecom Brain | Dark Brain |
|---|---|
| `00_CERVEAU_MERE/00_Orchestrateur` (chef) | `00_CERVEAU_MERE/00_Orchestrateur.md` |
| BRIEF NICHE (racine d'artefact) | issue épinglée « Sujet NDLI 2026 » (produite par `/sujet`, consommée par tous) |
| GATE HALAL (veto) | `01_Regles_NDLI.md` (veto : enfreindre une règle de la Nuit = disqualifié) |
| SHIP GATE | `03_GATE_Livraison.md` (checklist obligatoire avant 7h45) |
| `📖 PLAYBOOK` (quand) | `📖 PLAYBOOK.md` : préparation J-9 puis 16h39 → 8h01 |
| `🗂️ DASHBOARD` (état) | `🗂️ DASHBOARD.md` : **liens** vers les Issues filtrées par cerveau + `/point`. Aucun état écrit à la main (il divergerait d'une branche à l'autre). |
| wiki/ + raw/ | `rag/` (privé) ; retro du matin → nouvelle note dans le RAG |
| ordre d'arbitrage HALAL > Brand > CRO > SEO > Perf | **Règles NDLI > Livré à l'heure > Expérience utilisateur > Code propre > Perf** |

## 4. Structure

```
dark-brain/
├── CLAUDE.md                 constitution : « on route d'abord » → orchestrateur ; règles d'équipe
├── README.md                 installation
├── 📖 PLAYBOOK.md            QUAND : préparation avant le 3/12, déroulé heure par heure, jalons
├── 🗂️ DASHBOARD.md           OÙ EN EST-ON : liens Issues par cerveau, PR, /point
├── 00_CERVEAU_MERE/
│   ├── 00_Orchestrateur.md   CHEF : table de routage, arbitrage, fil de la nuit (ne produit rien)
│   ├── 01_Regles_NDLI.md     règles publiques résumées + veto
│   ├── 02_Equipe.md          cerveaux ↔ responsables, pôles, comment on se parle
│   └── 03_GATE_Livraison.md  checklist de livraison (veto si un point manque)
├── 01_CERVEAU_SUJET/         analyse du sujet, specs, glossaire
├── 02_CERVEAU_DESIGN/        maquettes Claude Design, UX, mobile 390 px d'abord
├── 03_CERVEAU_FRONT/         intégration maquette → code
├── 04_CERVEAU_BACK/          API, données, logique métier
├── 05_CERVEAU_INFRA/         hébergement, déploiement depuis main, domaine
├── 06_CERVEAU_DEFIS/         un fichier par défi retenu (créé par /sujet)
├── 07_CERVEAU_PITCH/         démo, présentation au jury, rendus, retro
├── equipe/ app/ rag/ scripts/ .githooks/ docs/
└── .claude/ (skills + settings.json)
```

**Chaque cerveau** = un hub `00_Cerveau <NOM>.md` + une ou deux recettes. Le hub dit : mission · responsable (renvoie à `equipe/`) · ce qu'il consomme · ce qu'il produit · skills à lancer (nos skills + Matt Pocock) · checklist · fichiers du cerveau. Le contenu est pré-rempli avec le maximum d'information exploitable sans connaître le sujet (méthodes, pièges, critères).

**Liens** : chaque fichier lie les fichiers de son cerveau et son hub ; seuls les hubs lient l'orchestrateur et les hubs voisins dans le fil de la nuit (`01 → 02 → 03/04 → 05 → 06 → 07`). Même discipline qu'Ecom Brain, en liens markdown.

## 5. Table de routage (dans l'orchestrateur)

| Demande | Cerveau | Skills | Gate |
|---|---|---|---|
| le sujet tombe, découper, répartir | 00 → 01 | `/sujet`, `grill-me`, `domain-modeling` | Règles NDLI |
| maquette, écran, parcours | 02 | `/maquette` (Claude Design) | — |
| intégrer, page, composant | 03 | `prototype`, `codebase-design`, `tdd` | — |
| API, base, logique | 04 | `tdd`, `codebase-design` | — |
| mettre en ligne, hébergeur, domaine | 05 | `wizard` | Livraison |
| défi : lire, rendre | 06 | `/savoir` (règles), `research` | Règles NDLI |
| démo, pitch, rendu jury | 07 | `pr` | Livraison |
| ça marche pas | cerveau concerné | `diagnosing-bugs` | — |
| livrer mon travail | cerveau concerné | `code-review` puis `/sync livrer` | — |
| qui fait quoi, temps restant | 00 | `/point` | — |
| après 8h01 | 07 | `retro` → note RAG (Raji) | — |

## 6. Changements de skills et de configuration

- **`.claude/settings.json`** (versionné) : `extraKnownMarketplaces.mattpocock = github mattpocock/skills` + `enabledPlugins["mattpocock-skills@mattpocock"] = true`. Claude Code propose l'installation à l'ouverture du dossier. Rien n'est copié (licence MIT, mises à jour amont).
- **`/setup`** : nouvelle question « Quel cerveau tiens-tu ? » parmi les cerveaux libres (lus dans les profils sur `main`) ; champ de profil `cerveau: 03_CERVEAU_FRONT`. Raji = `00_CERVEAU_MERE`. Vérifie que les skills Matt Pocock sont disponibles, sinon donne `/plugin install mattpocock-skills@mattpocock`.
- **`/sujet`** : ajoute toujours la tâche 2 `pole:design` « Maquette des écrans clés (/maquette) » avant 18h, dont dépendent les tâches front ; crée `06_CERVEAU_DEFIS/<slug-defi>.md` par défi (modalités, rendu, propriétaire) et les livre par PR ; label `pole:sujet` pour les tâches d'analyse.
- **`/maquette`** (nouveau, cerveau 02) : lit l'issue sujet, liste 3-5 écrans clés et leur parcours, produit la maquette dans **Claude Design** (dans Claude : artifact de type Design), mobile 390 px puis desktop. Lien partagé à l'équipe dans la tâche maquette. Repli si Claude Design n'est pas disponible sur le compte : maquette HTML/CSS statique dans `app/maquette/`. Rien de perso, aucun extrait du RAG.
- **`/point`** : ajoute la colonne « cerveau ».
- **Label** `pole:sujet` en plus des 6 existants.

## 7. Hors périmètre

- Pas de hook de routage, pas de script Python.
- Pas de DASHBOARD écrit à la main ni généré par un bot.
- Pas de `to-tickets` / `triage` / `wayfinder` (doublons de `/sujet` et des Issues).

## 8. Laissé au builder

Formulation des hubs et recettes ; horaires fins du PLAYBOOK autour des jalons fixés (16h39 sujet, 18h maquette, 20h en ligne, 23h appli minimale qui marche, 3h gel des fonctions, 7h livraison, 7h45 gel final, 8h01 fin).
