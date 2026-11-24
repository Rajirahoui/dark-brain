# Dark Brain v2 — cerveaux Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructurer `dark-brain` en Cerveau Mère + 7 cerveaux, avec PLAYBOOK, DASHBOARD, gates, skills Matt Pocock (plugin) et `/maquette` (Claude Design).

**Architecture:** Markdown pur lisible sur GitHub ; routage par table dans `00_CERVEAU_MERE/00_Orchestrateur.md` ; `CLAUDE.md` pointe vers elle. État vivant = Issues + `/point`.

**Tech Stack:** Markdown, Claude Code skills, `.claude/settings.json`, bash (`scripts/check.sh`).

**Spec:** `docs/superpowers/specs/2026-11-24-dark-brain-v2-cerveaux-design.md` (complète la v1)

## Global Constraints

- Noms de fichiers **sans espace ni emoji** (liens relatifs sûrs sur GitHub et Windows) : `PLAYBOOK.md`, `DASHBOARD.md`, hubs `00_Cerveau_<NOM>.md`. Les emojis restent dans les titres.
- Liens markdown relatifs uniquement. Fichier → fichiers de son cerveau + son hub. Hub → orchestrateur + hubs voisins (`01 → 02 → 03/04 → 05 → 06 → 07`). Racine (`CLAUDE.md`, `README.md`, `PLAYBOOK.md`, `DASHBOARD.md`) → hubs et fichiers racine seulement.
- Ordre d'arbitrage : Règles NDLI > Livré à l'heure > Expérience utilisateur > Code propre > Perf.
- Jalons : 16h39 sujet · 18h maquette · 20h en ligne · 23h appli minimale qui marche · 3h gel des fonctions · 7h livraison · 7h45 gel final · 8h01 fin.
- Repo public : aucun contact, aucun lien vers le formulaire de l'école, aucun extrait du RAG.
- Skills Matt Pocock retenus : `grill-me`, `domain-modeling`, `prototype`, `tdd`, `codebase-design`, `diagnosing-bugs`, `code-review`, `pr`, `wizard`, `research`, `retro`.

## Review Focus

1. Un lien relatif cassé (fichier renommé, chemin faux) → `scripts/check.sh` le signale. *(Task 1 : test.)*
2. Deux membres choisissent le même cerveau dans `/setup` → le second ne voit plus ce cerveau dans les choix libres. *(Task 3 : règle dans le skill.)*
3. Membre qui refuse l'install du plugin Matt Pocock → `/setup` donne la commande, ne bloque pas. *(Task 3.)*
4. Claude Design indisponible sur le compte → `/maquette` bascule sur `app/maquette/` en HTML statique. *(Task 3.)*
5. Défi au nom accentué → fichier `06_CERVEAU_DEFIS/<slug>.md` selon la règle de slug de `/setup`. *(Task 3.)*

---

### Task 1: Garde-fou des liens

**Files:** Modify `scripts/check.sh`, `scripts/test-check.sh`

- [ ] **Step 1: Tests** — dans `test-check.sh`, avant le bloc hook : `printf '[ok](a.txt)\n' > l.md` + add → `expect "lien relatif valide passe" 0` ; `printf '[ko](absent.md)\n' > l.md` + add → `expect "lien relatif cassé bloqué" 1` ; `git rm -qf l.md`. Les liens `http(s)://`, `mailto:`, `#ancre` sont ignorés ; `chemin#ancre` vérifie `chemin` ; `%20` décodé.
- [ ] **Step 2: RED** — `bash scripts/test-check.sh` → `FAIL lien relatif cassé bloqué`.
- [ ] **Step 3: `check.sh`** — pour chaque `.md` de `git ls-files -co --exclude-standard` (hors `rag`, hors `docs/superpowers`), extraire les cibles `](…)`, résoudre depuis le dossier du fichier, KO si absent.
- [ ] **Step 4: GREEN** — suite 11/11, `bash scripts/check.sh` → OK.
- [ ] **Step 5: Commit** — `feat(check): block broken relative markdown links`

### Task 2: Cerveau Mère, racine et 7 cerveaux

**Files:** Create `00_CERVEAU_MERE/{00_Orchestrateur,01_Regles_NDLI,02_Equipe,03_GATE_Livraison}.md`, `PLAYBOOK.md`, `DASHBOARD.md`, et pour chaque `0N_CERVEAU_<NOM>/` : `00_Cerveau_<NOM>.md` + recette(s). Modify `CLAUDE.md`, `README.md`.

- [ ] **Step 1:** Cerveau Mère (table de routage de la spec § 5, arbitrage, fil de la nuit ; règles publiques ; équipe ↔ `equipe/*.md` champ `cerveau:` ; gate livraison).
- [ ] **Step 2:** `PLAYBOOK.md` (préparation avant le 3/12, déroulé avec les jalons, qui fait quoi à chaque jalon, skills) et `DASHBOARD.md` (liens Issues filtrées par label, PR, `/point`).
- [ ] **Step 3:** 7 hubs (mission, responsable, consomme, produit, skills, checklist, fichiers) + recettes : SUJET « analyse du sujet », DESIGN « maquette Claude Design », FRONT « maquette vers code », BACK « API et données », INFRA « mise en ligne », DEFIS « traiter un défi » + `_modele_defi.md`, PITCH « démo et jury ».
- [ ] **Step 4:** `CLAUDE.md` : « on route d'abord » → orchestrateur, règles d'équipe conservées, carte des cerveaux. `README.md` : lien vers PLAYBOOK et structure.
- [ ] **Step 5: Vérifier** — `bash scripts/check.sh` → OK (liens compris) ; `ls -d 0*_CERVEAU_*` → 8 dossiers, chacun avec son hub.
- [ ] **Step 6: Commit** — `feat(brains): add mother brain, seven specialised brains, playbook and dashboard`

### Task 3: Skills et configuration

**Files:** Create `.claude/settings.json`, `.claude/skills/maquette/SKILL.md`. Modify `.claude/skills/{setup,sujet,point}/SKILL.md`.

- [ ] **Step 1:** `settings.json` : `extraKnownMarketplaces.mattpocock.source = {"source":"github","repo":"mattpocock/skills"}`, `enabledPlugins["mattpocock-skills@mattpocock"] = true`. Vérifier `python3 -m json.tool`.
- [ ] **Step 2:** `/setup` : question cerveau (libres seulement, Raji = `00_CERVEAU_MERE`), champ `cerveau:` au profil, contrôle plugin Matt Pocock non bloquant.
- [ ] **Step 3:** `/sujet` : tâche 2 maquette avant 18h ; fiche par défi `06_CERVEAU_DEFIS/<slug>.md` depuis `_modele_defi.md`, livrée par PR ; label `pole:sujet`.
- [ ] **Step 4:** `/maquette` (Claude Design, repli HTML `app/maquette/`) ; `/point` colonne cerveau.
- [ ] **Step 5: Vérifier** — `bash scripts/test-check.sh && bash scripts/check.sh` → OK ; 8 skills.
- [ ] **Step 6: Commit** — `feat(skills): add maquette, brain ownership in setup, Matt Pocock plugin`

### Task 4: Publication

- [ ] **Step 1:** `gh label create pole:sujet --color 0052CC -R Rajirahoui/dark-brain`.
- [ ] **Step 2:** `git push origin main` (hook pre-push → OK).
- [ ] **Step 3: Vérifier** — HEAD local = `origin/main` ; `gh label list` contient `pole:sujet`.
