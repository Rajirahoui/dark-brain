# 🖥️ Cerveau FRONT

> Hub · responsable : `cerveau: 03_CERVEAU_FRONT` dans `equipe/` · rayon : [Orchestrateur](../00_CERVEAU_MERE/00_Orchestrateur.md) · précédent : [DESIGN](../02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) · suivant : [INFRA](../05_CERVEAU_INFRA/00_Cerveau_INFRA.md) · voisin : [BACK](../04_CERVEAU_BACK/00_Cerveau_BACK.md)

## Mission
Transformer la maquette en interface qui marche, en ligne, sur téléphone et ordinateur. Organiser `app/` pour que plusieurs personnes codent l'interface sans conflit.

## Consomme / produit
- **Consomme :** la maquette (02), le contrat d'API (04), le découpage de `app/` fixé par `/sujet`.
- **Produit :** les écrans du parcours principal dans `app/`, branchés sur l'API (ou sur des données factices tant qu'elle n'est pas prête). Arbitre la structure du code d'interface.

## Quand
17h15-18h squelette de l'appli + page vide déployée avec INFRA · 18h-23h écrans du parcours · 23h appli minimale · 3h-7h finitions, accessibilité, mobile.

## Skills
`prototype` (un doute d'interaction) · `codebase-design` (interface avec le back) · `tdd` (logique côté client) · `diagnosing-bugs` · `code-review` puis `/sync` *livrer*.

## Checklist
- [ ] Un dossier par écran ou fonction (pas de gros fichier partagé).
- [ ] Données factices au format du contrat d'API, remplacées dès que l'API répond.
- [ ] Mobile 390 px vérifié sur un vrai téléphone.
- [ ] Navigation au clavier possible, images avec texte alternatif, champs avec label.
- [ ] Aucune clé d'API dans le code client.

## Fichiers
- [Recette : de la maquette au code](Recette_maquette_vers_code.md)
