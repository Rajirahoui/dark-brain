---
name: sync
description: Synchronise la branche perso du membre avec main (merge, jamais rebase), pousse, et en mode livrer ouvre puis fusionne la PR vers main qui ferme la tâche. Refuse de travailler sur main ou sur la branche d'un autre.
---

# /sync — récupérer et livrer

## 0. Garde-fous (avant toute commande qui écrit)
- Membre : `gh api user --jq .login` → le fichier `equipe/*.md` (local ou `origin/main`) dont la ligne `github:` vaut ce pseudo → son slug. Pas de profil → « lance /setup d'abord », stop.
- Branche courante : `git branch --show-current`.
  - = `main` → **refuse** : « Tu es sur main. `git switch <slug>` puis relance /sync. » Rien n'est poussé.
  - ≠ `<slug>` → **refuse** : « Cette branche n'est pas la tienne. » Rien n'est poussé.
- Interdits, toujours : `git rebase`, `git push --force` / `-f`, pousser vers `main` ou une autre branche que `<slug>`.

## 1. Récupérer
1. Modifs non commitées (`git status --porcelain`) → propose de les commiter (message court, en français) avant de continuer. Lance `scripts/check.sh` avant le commit ; KO → montre la ligne, fais retirer la donnée, ne commite pas.
2. `git fetch origin` puis `git merge origin/main`.
3. Conflit : liste les fichiers (`git diff --name-only --diff-filter=U`), explique chaque conflit simplement, propose une résolution. **Ne jette jamais le code d'un autre sans accord explicite.** Après résolution : `git add` + `git commit --no-edit`.
4. `git submodule update --init` (récupère la version du corpus fixée sur `main`).
5. `git push origin <slug>`.

## 2. Livrer (si demandé : « livrer », « finir », « PR »)
1. Fais d'abord l'étape 1 en entier.
2. Demande quelle(s) tâche(s) ça ferme (`gh issue list --assignee @me --state open`).
3. PR ouverte pour `<slug>` → `gh pr list --head <slug> --base main --state open --json number,url` → réutilise-la. Sinon `gh pr create --base main --head <slug> --title "<ce que ça livre>" --body "Closes #<n>"` (une ligne `Closes #<n>` par tâche).
4. Montre le diff résumé (`gh pr diff <n> --name-only`), puis demande « Je fusionne dans main ? ». Si oui : `gh pr merge <n> --merge` (**sans** `--delete-branch`).
5. Rappelle aux autres de lancer `/sync` pour récupérer ce travail.
