# Recette — maquette dans Claude Design (17h15 → 18h)

> Cerveau [DESIGN](00_Cerveau_DESIGN.md). Claude Design vit maintenant **dans Claude** (l'application séparée claude.ai/design ferme le 14 décembre 2026).

## Avant la nuit
- Vérifier qu'on peut créer une maquette dans Claude avec son compte (demander à Claude « fais une maquette de… » : il propose le type Design).
- Préparer 2 ou 3 références visuelles qu'on aime (captures), sans logos de marques.

## Pendant la nuit
1. Lance **`/maquette`** dans Claude Code (dans le dossier `dark-brain`). Il lit l'issue « Sujet NDLI 2026 » et te propose la liste des écrans.
2. **Écrans :** 3 à 5, uniquement le parcours principal. Pour chacun : but, contenu, action principale, écran suivant.
3. **Mobile 390 px d'abord**, puis desktop. Un seul bouton principal par écran.
4. **Tokens** : 1 couleur principale, 1 d'accent, neutres ; contraste AA ; 1 ou 2 polices ; échelle d'espacement (4/8/16/24/32).
5. **États** : vide (« aucun élément, voici quoi faire »), erreur (ce qui s'est passé + comment réparer), chargement.
6. **Partage** : le lien de la maquette dans la tâche maquette (`/tache`), et à voix haute au front.
7. **Repli** si Claude Design n'est pas disponible : `/maquette` produit une maquette HTML/CSS statique dans `app/maquette/`, ouverte dans le navigateur.
8. **18h, validation** (10 minutes) avec SUJET et FRONT, puis tâche fermée. Après 18h : on corrige, on ne redessine plus.

## Pièges
- Dessiner des écrans hors du parcours principal.
- Une maquette trop riche pour être codée avant 23h.
- Oublier le mobile : le jury peut tester sur téléphone.
