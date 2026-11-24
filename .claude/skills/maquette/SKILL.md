---
name: maquette
description: Cerveau 02 DESIGN - maquette les 3 à 5 écrans du parcours principal dans Claude Design (dans Claude), mobile 390 px puis desktop, à partir de l'issue Sujet NDLI 2026 ; repli en HTML statique dans app/maquette/ si Claude Design n'est pas disponible.
---

# /maquette — maquetter dans Claude Design

Lis d'abord `02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md` et `02_CERVEAU_DESIGN/Recette_maquette_Claude_Design.md`, puis suis ces étapes. Questions par choix à cocher (AskUserQuestion). Repo public : données fictives seulement, aucune personne réelle, aucun logo de marque, aucun extrait de `rag/`.

## 1. Entrées
- Sujet : `gh issue list --label sujet --state open --json number --jq '.[0].number'` puis `gh issue view <n>`. Aucune issue → demande de coller le sujet et le parcours principal. **N'attends pas `/sujet`** : dès que SUJET a le parcours principal (vers 17h), on commence ; il ne reste que 45 minutes avant 18h.
- Glossaire : `01_CERVEAU_SUJET/GLOSSAIRE.md` s'il existe (ses mots deviennent les libellés des écrans).
- Tâche maquette : `gh issue list --label pole:design --state open --search "Maquette in:title" --json number,title`.

## 2. Écrans (rien n'est dessiné avant le OK)
Propose un tableau de **3 à 5 écrans**, uniquement le parcours principal : écran · but · contenu · action principale · écran suivant. Puis les **tokens** : couleur principale, accent, neutres (contraste AA), 1-2 polices, échelle d'espacement 4/8/16/24/32, rayon des coins. Demande OK · modifier ; itère jusqu'au OK.

## 3. Dessiner dans Claude Design
Claude Design vit dans Claude : c'est le type d'artifact **Design**. Avec l'outil Artifact : `action: quickstart`, `intent: design`, puis suis les instructions qu'il renvoie pour créer le design (titre « Maquette — <nom de l'appli> »).
- Un écran par vue, **mobile 390 px d'abord**, puis la version desktop (1280 px) des mêmes écrans.
- Un seul bouton principal par écran, zones tactiles ≥ 44 px, textes lisibles sans zoom.
- Pour chaque écran de liste ou de formulaire : états **vide**, **erreur**, **chargement**.

**Repli** (outil Artifact ou type Design indisponible sur ce compte) : écris une maquette HTML/CSS statique dans `app/maquette/` (`index.html` avec une section par écran, tokens en variables CSS, mobile d'abord), ouvre-la dans le navigateur, puis livre-la avec `/sync` *livrer*.

## 4. Partager
- Claude Design : rappelle que la maquette est **privée par défaut** ; la personne la partage à l'équipe depuis Claude (bouton de partage), **en lecture seule uniquement** : le lien va dans une issue publique.
- Commente la tâche maquette : `gh issue comment <n> --body "Maquette : <lien ou app/maquette/>
Écrans : <liste>
Tokens : <couleurs, police, espacements>"`.
- Dis au cerveau FRONT que la maquette est prête.

## 5. Valider (18h)
10 minutes avec SUJET et FRONT. Corrections mineures seulement, puis `/tache` *finir* sur la tâche maquette. Après 18h on corrige, on ne redessine plus.
