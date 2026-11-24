# 🚦 GATE Livraison — 7h

> Cerveau Mère · [Orchestrateur](00_Orchestrateur.md). Passée à 7h par le responsable 07 PITCH avec Raji. **Un point manque → on ne fusionne plus rien d'autre que le correctif de ce point.** Gel final à 7h45.

Passer d'abord [Règles NDLI](01_Regles_NDLI.md) (veto), puis dans cet ordre :

## 1. En ligne (veto)
- [ ] L'URL publique répond, sur téléphone **et** sur ordinateur, en navigation privée.
- [ ] La version en ligne est celle de `main` (dernier merge déployé).
- [ ] L'URL est dans l'issue « Sujet NDLI 2026 ».

## 2. Le sujet
- [ ] Le parcours principal se fait de bout en bout, sans erreur, avec des données de démo.
- [ ] Les écrans vides, les erreurs et les chargements ont un message clair (pas de page blanche).

## 3. Les défis
- [ ] Pour chaque fiche défi `06_CERVEAU_DEFIS/<slug>.md` (pas le hub `00_*`, ni `Recette_*`, ni `_modele_defi.md`) : rendu fait **selon ses modalités**, case « Rendu » cochée dans la fiche.
- [ ] 5 défis au plus.

## 4. Le dépôt
- [ ] Rendu déposé sur le « site pérenne » / la plateforme indiquée par l'organisation.
- [ ] Coordonnées de l'équipe (nom, e-mail, adresse) données à l'organisation pour les lots, par le canal qu'elle indique (à vérifier le soir même), jamais dans le repo.

## 5. Le repo
- [ ] `bash scripts/check.sh` → OK.
- [ ] Aucun secret dans le code : clés et mots de passe uniquement dans les variables d'environnement de l'hébergeur.
- [ ] `app/README.md` : ce que fait l'appli, l'URL, comment la lancer en local.

## 6. Gel
- [ ] 7h45 : plus aucune fusion sur `main` sauf accord de Raji pour un correctif bloquant.
- [ ] 8h01 : on arrête.
