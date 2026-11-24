---
name: tache
description: Gère les tâches de l'équipe dans GitHub Issues - créer une tâche, en prendre une libre, voir les siennes ou les libres, finir une tâche. Les tâches ne vivent jamais dans un fichier.
---

# /tache — les tâches de l'équipe

Les tâches sont des **issues** de `Rajirahoui/dark-brain`. Libre = ouverte et non assignée ; en cours = ouverte et assignée ; finie = fermée. Jamais de fichier de tâches. Repo public : ni contact ni extrait de `rag/` dans une issue.

Si la demande ne dit pas quoi faire, demande avec AskUserQuestion : créer · prendre · mes tâches · libres · finir.

## Créer
Demande le titre (verbe + résultat, ex. « Formulaire d'inscription côté front »), le pôle (`pole:front` · `pole:back` · `pole:design` · `pole:infra` · `pole:pitch`) et le défi éventuel (labels `defi:*` existants : `gh label list --search defi:`).
`gh issue create --title "<titre>" --label pole:<x> [--label defi:<y>] --body "<ce qu'il faut faire, fichiers ou dossier de app/ concernés, critère de fini>"`
Propose ensuite de se l'assigner.

## Prendre
`gh issue list --state open --search "no:assignee -label:sujet" [--label pole:<x>] --json number,title,labels`
Montre les tâches (propose d'abord celles du pôle du membre, lu dans `equipe/*.md` via sa ligne `github:`). Après son choix : `gh issue edit <n> --add-assignee @me`.

## Mes tâches
`gh issue list --state open --assignee @me --json number,title,labels`

## Libres
`gh issue list --state open --search "no:assignee -label:sujet" --json number,title,labels`

## Finir
Une tâche se ferme par sa PR : lance `/sync` en mode *livrer* avec le numéro de l'issue (la PR porte `Closes #<n>`, l'issue se ferme à la fusion).
Tâche abandonnée ou sans code : `gh issue close <n> --comment "<pourquoi>"` après accord.
