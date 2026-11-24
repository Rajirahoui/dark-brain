# 🚀 Cerveau INFRA

> Hub · responsable : `cerveau: 05_CERVEAU_INFRA` dans `equipe/` · rayon : [Orchestrateur](../00_CERVEAU_MERE/00_Orchestrateur.md) · précédents : [FRONT](../03_CERVEAU_FRONT/00_Cerveau_FRONT.md), [BACK](../04_CERVEAU_BACK/00_Cerveau_BACK.md) · suivant : [DÉFIS](../06_CERVEAU_DEFIS/00_Cerveau_DEFIS.md)

## Mission
Que l'appli soit **en ligne à 20h** et le reste jusqu'à 8h01, déployée depuis `main`. Le livrable obligatoire de la Nuit est une URL qui répond.

## Consomme / produit
- **Consomme :** la stack fixée par `/sujet`, les besoins du back (base, variables d'environnement).
- **Produit :** l'hébergement, le déploiement automatique depuis `main`, l'URL publique (dans l'issue « Sujet NDLI 2026 »), le dépôt sur le « site pérenne ». Arbitre ce qui peut ou non être fusionné sur `main` quand le déploiement casse.

## Quand
16h45 tâche « Mise en ligne » (toujours la n° 1 de `/sujet`) · avant 20h URL qui répond · toute la nuit : surveiller chaque déploiement · 7h GATE Livraison avec PITCH.

## Skills
`wizard` (script guidé pour les étapes que seul un humain peut faire : comptes, clés) · `diagnosing-bugs` · `/savoir` (règles de rendu).

## Checklist
- [ ] Hébergeur choisi selon la stack, compte prêt.
- [ ] Page vide en ligne avant 18h, appli à 20h.
- [ ] Déploiement automatique depuis `main` seulement.
- [ ] Variables d'environnement configurées sur l'hébergeur, rien dans le repo.
- [ ] Revenir en arrière en 2 minutes : `revert` de la PR fautive sur `main`.

## Fichiers
- [Recette : mise en ligne](Recette_mise_en_ligne.md)
