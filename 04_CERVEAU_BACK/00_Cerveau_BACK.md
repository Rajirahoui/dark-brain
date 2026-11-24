# ⚙️ Cerveau BACK

> Hub · responsable : `cerveau: 04_CERVEAU_BACK` dans `equipe/` · rayon : [Orchestrateur](../00_CERVEAU_MERE/00_Orchestrateur.md) · précédent : [DESIGN](../02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) · suivant : [INFRA](../05_CERVEAU_INFRA/00_Cerveau_INFRA.md) · voisin : [FRONT](../03_CERVEAU_FRONT/00_Cerveau_FRONT.md)

## Mission
Fournir les données et la logique dont le parcours principal a besoin : un contrat d'API clair, tôt, et une implémentation simple qui tient la démo.

## Consomme / produit
- **Consomme :** l'issue « Sujet NDLI 2026 » et le glossaire de 01 SUJET.
- **Produit :** le modèle de données, le contrat d'API (routes + exemples JSON) dans la tâche dédiée, l'API, des données de démo. Arbitre le contrat d'API et le modèle de données.

## Quand
17h15-18h modèle de données + contrat d'API · 18h-23h API du parcours principal · 23h appli minimale · après 3h : corrections et données de démo seulement.

## Skills
`domain-modeling` (avec SUJET) · `codebase-design` (contrat avec le front) · `tdd` (logique métier) · `diagnosing-bugs` · `code-review` puis `/sync` *livrer*.

## Checklist
- [ ] Contrat d'API écrit avant 18h, validé avec FRONT.
- [ ] Le modèle de données reprend les mots du glossaire.
- [ ] Tests sur la logique métier qui compte pour la démo.
- [ ] Secrets dans les variables d'environnement, jamais dans le repo.
- [ ] Données de démo prêtes pour 7h.

## Fichiers
- [Recette : API et données](Recette_API_et_donnees.md)
