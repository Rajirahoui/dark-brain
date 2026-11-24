# Dark Brain Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Un repo public `dark-brain` qui donne aux 8 membres de l'équipe NDLI, via 7 skills Claude Code, une branche chacun, des tâches dans GitHub Issues et l'accès au corpus RAG privé.

**Architecture:** Skills projet dans `.claude/skills/` (markdown pur, n'appellent que `git` et `gh`). Corpus `benoit-ferrere-rag` (privé) branché en sous-module `rag/`. État partagé = GitHub Issues ; code et profils = Git.

**Tech Stack:** Claude Code skills (SKILL.md), Git, GitHub CLI `gh`, bash (macOS bash 3.2 et Git Bash Windows).

**Spec:** `docs/superpowers/specs/2026-11-24-dark-brain-design.md`

## Global Constraints

- Owner `Rajirahoui`. Repos : `Rajirahoui/dark-brain` **public**, `Rajirahoui/benoit-ferrere-rag` **privé**.
- Chemins locaux : `~/Documents/dark-brain` ; `~/Downloads/benoit-ferrere-rag`.
- Skills : seulement `git` et `gh`, mêmes commandes sous macOS et Git Bash. Questions par choix à cocher (AskUserQuestion) dès que possible.
- Branche = prénom en minuscules, accents retirés, espaces et apostrophes → `-` (« Léa-Marie » → `lea-marie`, « Noé » → `noe`). Doublon → suffixe `-<initiale du nom>`.
- Aucune donnée perso (téléphone, e-mail, adresse perso) ni extrait du RAG dans un fichier, une issue ou une PR de `dark-brain`.
- Merge, jamais rebase ; jamais de force-push ; jamais de push sur `main` ni sur la branche d'un autre.
- Droits invités : `dark-brain` = `push`, `benoit-ferrere-rag` = `pull`.
- Labels : `pole:front` `pole:back` `pole:design` `pole:infra` `pole:pitch` `sujet` (+ `defi:<slug>` créés par `/sujet`). Demande d'accès = issue titrée `Accès @<pseudo>`, sans label.
- Textes des skills, README, CLAUDE.md : en français. Messages de commit : en anglais.

## Review Focus

1. Prénom accentué, composé ou en doublon → slug de branche selon la règle ci-dessus ; jamais deux membres sur la même branche. *(Task 3 : règle + exemples dans `/setup` ; Task 6 : scénario.)*
2. `/setup` relancé par un membre déjà installé → aucune deuxième issue, branche ou PR ; il dit « déjà fait » et passe à l'étape suivante. *(Task 6 : scénario.)*
3. Windows sans `gh` dans le PATH, ou `gh` non connecté → `/setup` donne la commande d'install pour l'OS (`winget install --id GitHub.cli` / `brew install gh`) puis `gh auth login`, et s'arrête proprement. *(Task 3 : étape 1 du skill.)*
4. `rag/` vide (clone sans sous-module, accès RAG pas encore accepté) → `/savoir` explique et renvoie vers `/setup`, n'invente pas de réponse. *(Task 6 : scénario.)*
5. `/sync` lancé depuis `main` ou depuis la branche d'un autre → refus sans rien pousser. *(Task 6 : scénario.)*

---

### Task 1: Corpus RAG sur GitHub + infos NDLI

**Files (dans `~/Downloads/benoit-ferrere-rag`):**
- Create: `00-nuit-de-l-info-2026/2026-11-24-nuit-de-l-info-2026-regles.md`
- Create: `00-nuit-de-l-info-2026/2026-11-24-mail-epsi-lille.md`

**Interfaces:**
- Produces: `main` poussée sur `Rajirahoui/benoit-ferrere-rag` ; dossier `00-nuit-de-l-info-2026/` lu par `/savoir`.

- [ ] **Step 1: Pousser l'existant** — `git -C ~/Downloads/benoit-ferrere-rag push -u origin main`
- [ ] **Step 2: Vérifier** — `git ls-remote origin` → une ligne `refs/heads/main` au SHA `a9eeddf…`.
- [ ] **Step 3: Écrire la note règles** — frontmatter `type: reference`, `title`, `source_url: https://www.nuitdelinfo.com/`, `capture: 2026-11-24`, `tags: [nuit-de-l-info, regles]`. Contenu : dates (3 déc. 2026 16h39 → 4 déc. 8h01), sujet national révélé au coucher du soleil, ≤ 5 défis, appli web en ligne obligatoire, équipe ≥ 2 sans maximum, présence sur le campus, jury par défi le vendredi matin, résultats sous une semaine, liste des défis 2026 pas encore publiée au 24/11, liens (défis, FAQ, Discord https://discord.gg/JpXAz7A, inscription https://www.nuitdelinfo.com/hubs), et ce que le site ne dit pas (licence, IA, critères du sujet).
- [ ] **Step 4: Écrire la note mail** — frontmatter `type: reference`, `source_url: mail EPSI Lille (Outlook)`, `capture: 2026-11-24`. Contenu : site EPSI Lille, 2 rue Alphonse Colas, 59800 Lille ; **échéance 25 nov. 2026** ; deux inscriptions (formulaire https://forms.cloud.microsoft/e/SCSEnCvxs8 + site NDLI en choisissant « EPSI Lille ») ; ouvert à toutes les promos et aux amis d'autres écoles ; contact : Julien Comblez, coach myDiL (coordonnées du mail).
- [ ] **Step 5: Vérifier** — `grep -l "25 nov" 00-nuit-de-l-info-2026/*.md` → note mail ; `head -8` de chaque note montre un frontmatter complet.
- [ ] **Step 6: Commit + push**
```bash
git add 00-nuit-de-l-info-2026 && git commit -m "docs: add Nuit de l'Info 2026 rules and EPSI Lille invitation" && git push
```

### Task 2: Squelette dark-brain + garde-fou

**Files (dans `~/Documents/dark-brain`):**
- Create: `CLAUDE.md`, `README.md`, `.gitignore`, `app/.gitkeep`, `equipe/.gitkeep`, `scripts/check.sh`
- Create (sous-module): `.gitmodules`, `rag/`
- Existants : `docs/superpowers/specs/…`, `docs/superpowers/plans/…`

**Interfaces:**
- Consumes: Task 1 (repo RAG non vide).
- Produces: `scripts/check.sh` — sort en code ≠ 0 si (a) un `.claude/skills/<dir>/SKILL.md` n'a pas `name: <dir>` et `description:` dans son frontmatter, ou (b) `git grep -nE` trouve dans les fichiers suivis un téléphone FR (`0[1-9]([ .]?[0-9]{2}){4}`) ou une adresse e-mail autre que `noreply`. Utilisé par Task 3, 4, 5.

- [ ] **Step 1: `git init -b main`** dans `~/Documents/dark-brain`.
- [ ] **Step 2: Écrire `scripts/check.sh`** (bash 3.2-compatible, `git grep` seulement → ne descend pas dans `rag/`). Rendre exécutable.
- [ ] **Step 3: Test du garde-fou** — créer `tmp.txt` contenant un faux numéro de mobile FR à 10 chiffres groupés par deux, `git add tmp.txt`, lancer `scripts/check.sh` → **FAIL** (code 1, ligne citée). `git rm -f tmp.txt`.
- [ ] **Step 4: Sous-module** — `git submodule add https://github.com/Rajirahoui/benoit-ferrere-rag.git rag` ; vérifier `git submodule status` → SHA du commit de Task 1 Step 6.
- [ ] **Step 5: `CLAUDE.md`** — règles d'équipe : une branche = son prénom, jamais `main` ni la branche d'un autre ; tâches = GitHub Issues (`/tache`), jamais un fichier ; merge pas rebase, pas de force-push ; chacun fusionne sa PR après `/sync` sans conflit ; repo public : ni contact ni extrait du RAG ; `/sujet` à 16h39 ; carte des 7 skills en une ligne chacun ; déploiement depuis `main` ; RAG mis à jour → Raji remonte le pointeur `rag` par PR.
- [ ] **Step 6: `README.md`** — prérequis (Claude Code, Git, `gh` + `gh auth login`), `git clone https://github.com/Rajirahoui/dark-brain.git`, `cd dark-brain`, `claude`, `/setup`. Encadré : inscriptions (formulaire EPSI + site NDLI, site EPSI Lille) avant le 25/11. Aucun contact.
- [ ] **Step 7: `.gitignore`** — `.DS_Store`, `.claude/settings.local.json`.
- [ ] **Step 8: Vérifier** — `scripts/check.sh` → PASS (code 0).
- [ ] **Step 9: Commit** — `git add -A && git commit -m "chore: scaffold dark-brain with team rules, RAG submodule and privacy check"`

### Task 3: Skills d'accès — `/setup` et `/inviter`

**Files:**
- Create: `.claude/skills/setup/SKILL.md`, `.claude/skills/inviter/SKILL.md`

**Interfaces:**
- Consumes: `scripts/check.sh` (Task 2).
- Produces: profil `equipe/<slug>.md` sur `main`, frontmatter `prenom`, `github`, `pole` (front|back|design|infra|pitch|polyvalent), `promo` (B1…M2), `forces` (liste), `os`, `inscrit` (oui|non|partiel). Lu par `/sujet`, `/sync`, `/point`. Le lien membre ↔ branche = `github:` du profil.

- [ ] **Step 1: `/setup`** — `description` qui déclenche sur « installer / configurer Dark Brain ». Étapes, dans cet ordre, chacune relançable :
  1. `git --version`, `gh --version`, `gh auth status` ; manque → commande d'install selon l'OS (Review Focus 3), stop.
  2. `gh api user --jq .login` → pseudo.
  3. Questions (AskUserQuestion) : prénom, pôle, promo, forces (multi), inscription. Rappel « repo public, rien de perso ».
  4. Accès : `gh api repos/Rajirahoui/dark-brain --jq .permissions.push`. Faux → invitations en attente `gh api user/repository_invitations` (filtrer les 2 repos) → avec accord, `gh api -X PATCH user/repository_invitations/<id>` pour chacune. Aucune → chercher `gh issue list -R Rajirahoui/dark-brain --state open --search "Accès @<pseudo> in:title"`, sinon `gh issue create -R Rajirahoui/dark-brain --title "Accès @<pseudo>" --body "Demande envoyée par /setup."` ; dire « relance /setup quand Raji t'a invité » ; stop.
  5. `gh auth setup-git` ; `git submodule update --init rag` (échec → même message d'accès).
  6. Slug (Global Constraints) ; `git fetch origin` ; branche distante existe → `git switch <slug>`, sinon `git switch -c <slug> origin/main`.
  7. Écrire `equipe/<slug>.md` ; `scripts/check.sh` ; commit ; `git push -u origin <slug>` ; PR existante pour `<slug>` → la réutiliser, sinon `gh pr create --base main --head <slug> --title "équipe : profil <slug>"` ; `gh pr merge <n> --merge` (sans `--delete-branch`).
  8. `inscrit` ≠ oui → rappel des deux inscriptions et de l'échéance du 25/11.
- [ ] **Step 2: `/inviter`** — refuse si `gh api user --jq .login` ≠ `Rajirahoui`. Liste `gh issue list --state open --search "Accès @ in:title"`, montre les pseudos, demande lesquels inviter (multi). Pour chaque oui : `gh api -X PUT repos/Rajirahoui/dark-brain/collaborators/<p> -f permission=push`, `gh api -X PUT repos/Rajirahoui/benoit-ferrere-rag/collaborators/<p> -f permission=pull`, `gh issue close <n> --comment "Invitation envoyée, relance /setup."`.
- [ ] **Step 3: Vérifier** — `scripts/check.sh` → PASS.
- [ ] **Step 4: Commit** — `git add .claude/skills/setup .claude/skills/inviter && git commit -m "feat(skills): add setup onboarding and owner invite flow"`

### Task 4: Skills de travail — `/tache`, `/sujet`, `/point`, `/sync`, `/savoir`

**Files:**
- Create: `.claude/skills/{tache,sujet,point,sync,savoir}/SKILL.md`

**Interfaces:**
- Consumes: profils `equipe/*.md` (Task 3), labels (Task 5).
- Produces: issues de tâches (labels `pole:*`, `defi:*`) ; PR avec `Closes #<n>`.

- [ ] **Step 1: `/tache`** — *créer* : `gh issue create --title … --label pole:<x> [--label defi:<y>]` ; *prendre* : `gh issue list --state open --search "no:assignee" [--label pole:<x>]` → choix → `gh issue edit <n> --add-assignee @me` ; *finir* : passe par `/sync livrer` (PR avec `Closes #<n>`) ; *mes tâches* : `--assignee @me` ; *libres* : `no:assignee`.
- [ ] **Step 2: `/sujet`** — sujet collé + défis (≤ 5). Lit `git show origin/main:equipe/<f>` pour chaque profil. Propose un tableau : tâche (1-2 h), pôle, dépendance, assigné, dossier de `app/` touché (une personne par dossier). Première ligne toujours : `pole:infra` « Mise en ligne : choisir l'hébergeur et déployer une page vide depuis main » avant 20 h. Après OK : `gh label create defi:<slug>` ; `gh issue create --title "Sujet NDLI 2026" --label sujet` (sujet résumé, défis, découpage de `app/`, **aucun extrait du RAG**) + `gh issue pin <n>` ; une issue par tâche avec `--assignee <pseudo>`.
- [ ] **Step 3: `/point`** — `gh issue list --state all --limit 200 --json number,title,state,assignees,labels` ; `gh pr list --json number,title,headRefName` ; pour chaque `origin/<b>` : `git rev-list --count origin/<b>..origin/main` ; heure `TZ=Europe/Paris date '+%Y-%m-%d %H:%M'`, Claude calcule l'écart jusqu'au 2026-12-04 08:01. Sortie : tableau par membre, tâches libres, membres sans tâche, PR ouvertes, branches en retard, temps restant.
- [ ] **Step 4: `/sync`** — membre = profil dont `github:` = `gh api user --jq .login`. Refus (sans push) si branche courante = `main` ou ≠ slug du membre. `git fetch origin` ; `git merge origin/main` ; conflit → liste les fichiers, propose une résolution, ne jette jamais le code d'un autre sans accord ; `git submodule update --init` ; `git push`. *livrer* : `gh pr create --base main --body "Closes #<n>"`, puis après accord `gh pr merge <n> --merge`.
- [ ] **Step 5: `/savoir`** — `rag/` vide → message d'accès + `/setup`, stop. Sinon recherche texte dans `rag/**/*.md`, lit les passages, répond **dans le terminal seulement** en citant les chemins (et l'horodatage `**[HH:MM:SS]**` pour un transcript). Pas de réponse sans source trouvée.
- [ ] **Step 6: Vérifier** — `scripts/check.sh` → PASS ; `ls .claude/skills` → 7 dossiers.
- [ ] **Step 7: Commit** — `git add .claude/skills && git commit -m "feat(skills): add task, subject, status, sync and knowledge skills"`

### Task 5: Publication GitHub

**Interfaces:**
- Consumes: Tasks 2-4 committées.
- Produces: `Rajirahoui/dark-brain` public, `main` protégée, labels.

- [ ] **Step 1: Créer + pousser** — `gh repo create Rajirahoui/dark-brain --public --source ~/Documents/dark-brain --push --description "Cerveau d'équipe Nuit de l'Info 2026 (EPSI Lille)"`
- [ ] **Step 2: Ruleset `main`** — `gh api -X POST repos/Rajirahoui/dark-brain/rulesets --input -` avec :
```json
{"name":"protect-main","target":"branch","enforcement":"active",
 "conditions":{"ref_name":{"include":["~DEFAULT_BRANCH"],"exclude":[]}},
 "rules":[{"type":"deletion"},{"type":"non_fast_forward"},
  {"type":"pull_request","parameters":{"required_approving_review_count":0,"dismiss_stale_reviews_on_push":false,"require_code_owner_review":false,"require_last_push_approval":false,"required_review_thread_resolution":false}}],
 "bypass_actors":[{"actor_id":5,"actor_type":"RepositoryRole","bypass_mode":"always"}]}
```
- [ ] **Step 3: Labels** — `gh label create` pour les 6 labels des Global Constraints.
- [ ] **Step 4: Vérifier** — `gh repo view Rajirahoui/dark-brain --json visibility` → `PUBLIC` ; `gh api repos/Rajirahoui/dark-brain/rulesets --jq '.[].name'` → `protect-main` ; `gh label list` → les 6.

### Task 6: Test bout en bout (Raji)

- [ ] **Step 1:** Raji ouvre `claude` dans `~/Documents/dark-brain`, tape `/setup`. Vérifier que c'est bien le skill Dark Brain qui se charge (et pas un autre `setup` installé).
- [ ] **Step 2: Vérifier** — `git ls-remote --heads origin raji` → existe ; `git show origin/main:equipe/raji.md` → frontmatter complet, aucun contact ; `rag/` peuplé.
- [ ] **Step 3: Relancer `/setup`** → « déjà fait » à chaque étape, aucune nouvelle PR ni issue (Review Focus 2).
- [ ] **Step 4: `/sync` depuis `main`** (`git switch main`) → refus, rien de poussé (Review Focus 5). Revenir sur `raji`.
- [ ] **Step 5: `/savoir` « quelle est la date limite d'inscription à l'EPSI ? »** → « 25 novembre », source citée `rag/00-nuit-de-l-info-2026/2026-11-24-mail-epsi-lille.md`. Puis `git submodule deinit -f rag` → `/savoir` → message d'accès (Review Focus 4) ; `git submodule update --init rag`.
- [ ] **Step 6: `/point`** → tableau avec Raji, 0 tâche, temps restant cohérent.
- [ ] **Step 7: Prénom test** — demander à `/setup` le slug de « Léa-Marie » et de « Noé » sans rien écrire → `lea-marie`, `noe` (Review Focus 1).
