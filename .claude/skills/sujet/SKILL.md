---
name: sujet
description: À 16h39 le soir de la Nuit de l'Info - transforme le sujet national et les défis choisis (5 max) en tâches de 1-2 h assignées selon les profils de l'équipe, découpe app/ en dossiers et crée l'issue épinglée Sujet NDLI 2026.
---

# /sujet — du sujet aux tâches

Lancé par une seule personne (Raji par défaut), qui doit avoir l'accès en écriture (`gh api repos/Rajirahoui/dark-brain --jq .permissions.push` = `true`). Si une issue `sujet` est déjà ouverte (`gh issue list --label sujet --state open`), montre-la et demande s'il faut compléter plutôt que recréer.

## 1. Entrées
- Le texte du sujet, collé dans le chat. S'il manque, demande-le.
- Les défis choisis, **5 au plus** (nom + modalités de rendu). Si plus de 5 : demande lesquels garder.
- Règles utiles : `00_CERVEAU_MERE/01_Regles_NDLI.md` et `rag/00-nuit-de-l-info-2026/2026-11-24-nuit-de-l-info-2026-regles.md` (lire, ne rien recopier du RAG dans GitHub).
- L'analyse du cerveau SUJET (`01_CERVEAU_SUJET/Recette_analyse_du_sujet.md`) : utilisateur, parcours principal, périmètre MVP / plus tard / on ne fait pas. Si elle n'est pas faite, fais-la avec l'équipe avant de découper.

## 2. Équipe
`git fetch -q origin`, puis pour chaque chemin renvoyé par `git ls-tree --name-only origin/main equipe/` (chemins complets `equipe/<f>.md`, sauf `.gitkeep`) : `git show origin/main:<chemin>` → prénom, pseudo, cerveau, pôle, forces. Le responsable d'un cerveau reçoit en priorité les tâches de son cerveau.

## 3. Proposition (rien n'est créé avant le OK)
Affiche :
- **Stack proposée** et **découpage de `app/`** en dossiers (un par pôle ou par fonctionnalité). Règle : une tâche touche des fichiers qu'une seule personne modifie.
- Un **tableau** : # · tâche (1-2 h, verbe + résultat) · pôle · défi · dépend de · assigné (pseudo) · dossier de `app/`.
- **Ligne 1, toujours** : `pole:infra` « Mise en ligne : choisir l'hébergeur et déployer une page vide depuis main », à finir **avant 20 h**, assignée au responsable `05_CERVEAU_INFRA`.
- **Ligne 2, toujours** : `pole:design` « Maquette des écrans clés (/maquette) », à finir **avant 18 h**, assignée au responsable `02_CERVEAU_DESIGN`. Les tâches d'écrans front en dépendent.
- Les tâches d'analyse (glossaire, périmètre) portent `pole:sujet`.
- Charge équilibrée sur tous les membres ; chacun a une tâche dès le départ ; les profils guident l'assignation.
Demande : OK · modifier. Itère jusqu'au OK.

## 4. Création (après OK)
1. Un label par défi : `gh label create "defi:<slug>" --color 5319E7 --force`.
2. L'issue du sujet : `gh issue create --title "Sujet NDLI 2026" --label sujet --body "<résumé du sujet en tes mots, défis retenus et modalités, stack, découpage de app/>"` puis `gh issue pin <n>`. Aucun contact, aucun extrait de `rag/`.
3. Une issue par tâche : `gh issue create --title "<tâche>" --label pole:<x> [--label defi:<y>] --assignee <pseudo> --body "<ce qu'il faut faire, dossier de app/, dépend de #<n>, critère de fini>"`. Si l'assignation échoue (membre pas encore invité), crée l'issue sans assigné et note-le.
4. **Fiches défis** : pour chaque défi retenu, copie `06_CERVEAU_DEFIS/_modele_defi.md` en `06_CERVEAU_DEFIS/<slug>.md` (slug : même règle que `/setup` — minuscules, sans accent, espaces → `-`), remplis ce qu'on sait (partenaire, lien, propriétaire, modalités, numéros des tâches). Propriétaire par défaut : le responsable `06_CERVEAU_DEFIS`. `bash scripts/check.sh`, commit sur ta branche, puis `/sync` *livrer* pour qu'elles arrivent sur `main`.
5. Résume : nombre de tâches par membre, lien de l'issue sujet, fiches défis créées, et dis à chacun de lancer `/tache` → *mes tâches*. Rappelle à DESIGN de lancer `/maquette`.
