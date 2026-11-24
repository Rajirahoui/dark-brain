---
name: point
description: Fait le point sur l'équipe pendant la Nuit de l'Info - tâches par membre, tâches libres, membres sans tâche, PR ouvertes, branches en retard sur main et temps restant avant 8h01.
---

# /point — état de l'équipe

Lecture seule : ne modifie rien, ne commente rien.

1. Données :
   - `git fetch -q origin`
   - membres : `git ls-tree --name-only origin/main equipe/` (chemins complets, sauf `.gitkeep`) puis `git show origin/main:<chemin>` (prénom, pseudo, pôle)
   - tâches : `gh issue list --state all --limit 200 --json number,title,state,assignees,labels`
   - PR : `gh pr list --state open --json number,title,headRefName,author`
   - retard : pour chaque `git branch -r --format '%(refname:short)'` sauf `origin/main` et `origin/HEAD`, `git rev-list --count <b>..origin/main`
   - heure : `TZ=Europe/Paris date '+%Y-%m-%d %H:%M'`
2. Temps restant : calcule toi-même l'écart entre l'heure de Paris et **2026-12-04 08:01**. Avant le 3 décembre 16h39, affiche plutôt le temps avant le début.
3. Affiche, court :
   - tableau par membre : en cours · finies · PR ouverte · commits de retard sur `main`
   - tâches libres (numéro + titre)
   - membres sans tâche en cours
   - temps restant
   - une alerte par ligne si : la tâche « Mise en ligne » n'est pas fermée après 20 h ; une branche a plus de 10 commits de retard ; il reste moins de 2 h et des PR sont ouvertes.
