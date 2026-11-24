# Recette — de la maquette au code

> Cerveau [FRONT](00_Cerveau_FRONT.md).

1. **Stack :** celle que la majorité de l'équipe connaît (fixée par `/sujet`). La nuit n'est pas le moment d'apprendre un framework.
2. **Squelette avant 18h :** page d'accueil vide + navigation entre écrans vides, déployée par INFRA. Tout le monde part de là.
3. **Découpage :** un dossier par écran ou fonctionnalité dans `app/` ; chaque dossier a un seul propriétaire (sa tâche). Le CSS est rangé par dossier (préfixe ou modules) pour éviter les conflits.
4. **Contrat d'API d'abord :** avec BACK, écrire dans la tâche les routes et un exemple de JSON pour chacune. Coder contre des **données factices** à ce format ; brancher la vraie API quand elle répond.
5. **Mobile d'abord :** coder à 390 px, élargir ensuite. Tester sur un vrai téléphone dès 20h.
6. **Doute sur une interaction :** `prototype` (jetable, 15 minutes max), puis on code la version retenue.
7. **Avant de livrer :** `code-review` sur ta branche, puis `/sync` *livrer*. Petites PR, souvent.

## Accessibilité (rapide, visible par le jury)
Labels sur les champs · texte alternatif sur les images · contraste suffisant · focus visible · boutons de vrais `<button>`.

## Pièges
- Attendre l'API pour commencer.
- Un fichier `styles.css` ou `App` géant que tout le monde modifie.
- Corriger la maquette dans le code sans prévenir DESIGN.
