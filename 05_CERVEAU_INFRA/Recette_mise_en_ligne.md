# Recette — mise en ligne (avant 20h)

> Cerveau [INFRA](00_Cerveau_INFRA.md). L'hébergement se décide le soir même, une fois la stack connue.

## Avant la nuit
- Avoir un compte prêt sur 2 ou 3 hébergeurs courants qui se branchent sur un repo GitHub, et vérifier leur offre gratuite **à jour** (elles changent).
- Savoir où l'école peut fournir un serveur, si besoin (demander au coach).

## Choisir selon la stack (16h45)
| Stack | Type d'hébergement |
|---|---|
| site statique (HTML/CSS/JS, build front) | hébergement statique branché sur GitHub (GitHub Pages ou équivalent) |
| front + fonctions serveur JavaScript/Python | plateforme qui déploie front + fonctions depuis le repo |
| serveur qui tourne en continu (Node, Python, PHP, Java) + base | plateforme d'applications ou serveur de l'école |

Règle : celle qui se branche sur `Rajirahoui/dark-brain`, dossier `app/`, et déploie **à chaque fusion sur `main`**.

## Étapes
1. Créer le projet sur l'hébergeur, racine `app/`, branche `main`. Les étapes manuelles (compte, autorisation GitHub) : `wizard` peut en faire un pas-à-pas.
2. Déployer la page vide **avant 18h** : on découvre les problèmes tôt.
3. Variables d'environnement sur l'hébergeur (jamais dans le repo).
4. Écrire l'URL publique dans l'issue « Sujet NDLI 2026 », fermer la tâche « Mise en ligne ».
5. Après chaque fusion sur `main` : vérifier que le déploiement passe ; s'il casse, `revert` de la PR fautive tout de suite.
6. Avant 7h : dépôt sur le « site pérenne » selon les consignes de l'organisation (voir `00_CERVEAU_MERE/01_Regles_NDLI.md`).

## Pièges
- Déployer pour la première fois à 7h.
- Une clé d'API poussée dans le repo public : la révoquer immédiatement, puis la retirer.
- Un build qui marche en local et pas en ligne : comparer versions et variables d'environnement.
