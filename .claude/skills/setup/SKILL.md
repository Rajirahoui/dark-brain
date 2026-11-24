---
name: setup
description: Installe Dark Brain sur ce PC pour un membre de l'équipe Nuit de l'Info - vérifie Git et gh, crée le profil, demande ou accepte l'accès, branche le corpus rag/, crée la branche perso. À lancer une fois après le clone, relançable sans casse.
---

# /setup — installer Dark Brain

Tu installes Dark Brain pour la personne devant ce PC. Suis les étapes **dans l'ordre**. Chaque étape vérifie d'abord si elle est déjà faite : si oui, dis « déjà fait » en une ligne et passe à la suivante. Ne saute jamais une étape, ne fais rien qu'elle ne demande pas.

Pose les questions avec AskUserQuestion (choix à cocher) dès que c'est possible. Parle simplement, en français, phrases courtes.

**Repo public :** n'écris jamais de téléphone, d'e-mail ou d'adresse perso dans un fichier, une issue ou une PR.

## 0. Bon dossier

`git remote get-url origin` doit contenir `Rajirahoui/dark-brain`. Sinon : « Ouvre Claude Code dans le dossier dark-brain cloné (voir README) », et arrête-toi.

## 1. Outils

Lance `git --version`, `gh --version`, `gh auth status`.
- Git manque : macOS `xcode-select --install`, Windows https://git-scm.com/download/win.
- gh manque : macOS `brew install gh`, Windows `winget install --id GitHub.cli` (puis rouvrir le terminal).
- gh pas connecté : `gh auth login` (GitHub.com, HTTPS, navigateur).

S'il manque quelque chose, donne la commande pour son OS, dis « relance /setup après », et **arrête-toi**.

## 2. Qui est là

- Pseudo : `gh api user --jq .login`. Ne le demande pas.
- Profil existant : `git fetch -q origin`, puis cherche dans `git ls-tree --name-only origin/main equipe/` un fichier dont la ligne `github:` vaut ce pseudo (`git show origin/main:equipe/<f>`).
  - Trouvé : montre-le, demande « Garder ce profil ? » (oui / le modifier). Si oui, garde le prénom et le slug de ce fichier et passe à l'étape 4.

## 3. Questions

Demande, avec AskUserQuestion :
1. **Prénom** (texte libre via « Other »).
2. **Pôle principal** : front · back · design · infra · pitch · polyvalent.
3. **Promo** : B1 · B2 · B3 · M1 · M2 (via « Other » si besoin).
4. **Points forts** (plusieurs choix) : HTML/CSS · JavaScript/TypeScript · framework front (React, Vue…) · back (Node, Python, PHP, Java…) · bases de données · réseau/infra/déploiement · UI/UX · présentation/pitch.
5. **Inscription faite ?** formulaire de l'école + site nuitdelinfo.com (site EPSI Lille) : les deux · un seul · aucune.

**Slug** (nom de branche et de fichier) : prénom en minuscules, accents retirés, espaces et apostrophes remplacés par `-`, rien d'autre que `a-z`, `0-9` et `-`. Exemples : « Léa-Marie » → `lea-marie`, « Noé » → `noe`, « Jean Luc » → `jean-luc`.
**Doublon** : si `equipe/<slug>.md` existe sur `origin/main` avec un autre `github:`, ou si la branche `origin/<slug>` existe et appartient à un autre membre, demande l'initiale du nom et utilise `<slug>-<initiale>` (« lea-d »).

## 4. Accès

`gh api repos/Rajirahoui/dark-brain --jq .permissions.push`
- `true` → étape 5.
- Sinon, invitations en attente :
  `gh api user/repository_invitations --jq '.[] | select(.repository.full_name | test("^Rajirahoui/(dark-brain|benoit-ferrere-rag)$")) | "\(.id) \(.repository.full_name)"'`
  - S'il y en a : demande « J'accepte les invitations de Raji ? ». Si oui, pour chaque id : `gh api -X PATCH user/repository_invitations/<id>`. Revérifie l'accès, puis étape 5.
  - S'il n'y en a pas : cherche une demande déjà ouverte
    `gh issue list -R Rajirahoui/dark-brain --state open --author @me --search "Accès in:title" --json number`.
    Aucune → `gh issue create -R Rajirahoui/dark-brain --title "Accès @<pseudo>" --body "Demande envoyée par /setup."` (pas de label : GitHub les ignore pour un non-membre).
    Dis : « Demande envoyée à Raji. Relance /setup quand tu as l'invitation (mail GitHub). » et **arrête-toi** (garde les réponses en tête si la personne relance dans cette session).

## 5. Corpus

`gh auth setup-git` puis `git submodule update --init rag`.
Échec → l'accès au corpus n'est pas encore là : même message qu'à l'étape 4 (demande à Raji), arrête-toi.

## 6. Branche

- Branche courante = `<slug>` → déjà fait.
- `git ls-remote --heads origin <slug>` renvoie une ligne → `git switch <slug>` (puis `git pull -q`).
- Sinon → `git switch -c <slug> origin/main`.

## 7. Profil

Écris `equipe/<slug>.md` :

```markdown
---
prenom: <Prénom>
github: <pseudo>
pole: <front|back|design|infra|pitch|polyvalent>
promo: <B1…M2>
forces: [<point fort>, <point fort>]
os: <macos|windows|linux>
inscrit: <oui|partiel|non>
---
```

Puis `scripts/check.sh` (doit afficher « OK »).

- **Profil absent de `origin/main`** (premier setup) : `git add equipe/<slug>.md`, commit `équipe : profil <slug>`, `git push -u origin <slug>`. PR ouverte pour `<slug>` (`gh pr list --head <slug> --base main --state open --json number`) → réutilise-la ; sinon `gh pr create --base main --head <slug> --title "équipe : profil <slug>" --body "Profil créé par /setup."`. Puis `gh pr merge <n> --merge` (**sans** `--delete-branch`). À ce moment la branche ne contient que le profil : la fusion est sans risque.
- **Profil déjà sur `origin/main`** : ne crée **aucune** PR (la branche peut contenir du travail en cours). Si le profil a changé, commit sur la branche et dis : « Ton profil partira avec ta prochaine livraison (/sync livrer). »

## 8. Fin

- `inscrit` ≠ oui : rappelle les **deux** inscriptions (formulaire de l'école + nuitdelinfo.com en choisissant le site EPSI Lille), **avant le 25 novembre**.
- Dis en 3 lignes : ta branche est `<slug>` ; `/tache` pour prendre une tâche ; `/point` pour voir l'équipe.
