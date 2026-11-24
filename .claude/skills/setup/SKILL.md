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

**Skills Matt Pocock** (non bloquant) : si le skill `tdd` n'est pas dans tes skills disponibles (seul test fiable : `grill-me` et `retro` ne s'y affichent jamais, `code-review` existe aussi sans le plugin), le plugin n'est pas installé ; la personne peut aussi vérifier avec `/plugin`. Donne : `/plugin marketplace add mattpocock/skills` puis `/plugin install mattpocock-skills@mattpocock`, puis redémarrer Claude Code. Continue sans attendre.

## 2. Qui est là

- Pseudo : `gh api user --jq .login`. Ne le demande pas.
- Profil existant : `git fetch -q origin`, puis `git ls-tree --name-only origin/main equipe/` (renvoie des chemins complets `equipe/<f>.md` ; ignore `.gitkeep`). Pour chaque chemin, `git show origin/main:<chemin>` : cherche celui dont la ligne `github:` vaut ce pseudo.
  - Trouvé : montre-le, demande « Garder ce profil ? » (oui / le modifier). Si oui, garde le prénom et le slug de ce fichier, note **profil conservé**, et passe à l'étape 4. S'il n'a pas de ligne `cerveau:`, pose seulement la question 6 de l'étape 3 et note **profil complété**.

## 3. Questions

Demande, avec AskUserQuestion :
1. **Prénom** (texte libre via « Other »).
2. **Pôle principal** : front · back · design · infra · pitch · polyvalent.
3. **Promo** : B1 · B2 · B3 · M1 · M2 (via « Other » si besoin).
4. **Points forts** (plusieurs choix) : HTML/CSS · JavaScript/TypeScript · framework front (React, Vue…) · back (Node, Python, PHP, Java…) · bases de données · réseau/infra/déploiement · UI/UX · présentation/pitch.
5. **Inscription faite ?** formulaire de l'école + site nuitdelinfo.com (site EPSI Lille) : les deux · un seul · aucune.
6. **Quel cerveau tiens-tu ?** Chaque membre en tient un (voir `00_CERVEAU_MERE/02_Equipe.md`).
   - Pseudo `Rajirahoui` → `00_CERVEAU_MERE` d'office, ne demande pas.
   - Cerveaux : `01_CERVEAU_SUJET` · `02_CERVEAU_DESIGN` · `03_CERVEAU_FRONT` · `04_CERVEAU_BACK` · `05_CERVEAU_INFRA` · `06_CERVEAU_DEFIS` · `07_CERVEAU_PITCH`.
   - **Libres** = ceux qu'aucun autre profil de `origin/main` ne porte dans sa ligne `cerveau:`. Ne propose jamais un cerveau pris.
   - Propose d'abord jusqu'à 3 cerveaux libres qui collent au pôle (front → 03, back → 04, design → 02, infra → 05, pitch → 07, polyvalent → 01 puis 06) + « un autre ». Si « un autre » : deuxième question avec les autres libres.
   - Aucun libre (plus de 8 membres) → `cerveau: renfort`.

**Slug** (nom de branche et de fichier ; `/sujet` l'applique aussi aux défis) : minuscules ; accents retirés et ligatures développées (é → e, ç → c, œ → oe, æ → ae) ; toute suite de caractères hors `a-z` et `0-9` devient **un seul** `-` ; pas de `-` au début ni à la fin ; 40 caractères au plus. Exemples : « Léa-Marie » → `lea-marie`, « Noé » → `noe`, « Jean Luc » → `jean-luc`, « Défi : Éco & Co’ » → `defi-eco-co`.
**Slug refusé** : vide, commençant ou finissant par `-`, ou réservé (`main`, `head`, `rag`, `app`, `equipe`, `docs`, `scripts`) → redemande le prénom ou un surnom.
**Doublon** : le slug est pris si
- `git show origin/main:equipe/<slug>.md` existe avec un autre `github:`, ou
- `git ls-remote origin refs/heads/<slug>` renvoie une ligne et la branche appartient à un autre pseudo. Propriétaire = ligne `github:` de `git show origin/<slug>:equipe/<slug>.md` ; à défaut, auteur de `gh pr list --head <slug> --state all --json author`.

Pris → demande l'initiale du nom, utilise `<slug>-<initiale>` (« lea-d ») et **refais ce contrôle** ; encore pris → deux lettres.

## 4. Accès

1. **Invitations en attente, toujours en premier** (les deux repos, même si l'accès à dark-brain est déjà là) :
   `gh api user/repository_invitations --jq '.[] | select(.repository.full_name | test("^Rajirahoui/(dark-brain|benoit-ferrere-rag)$")) | "\(.id) \(.repository.full_name)"'`
   S'il y en a : demande « J'accepte les invitations de Raji ? ». Si oui, pour chaque id : `gh api -X PATCH user/repository_invitations/<id>`.
2. `gh api repos/Rajirahoui/dark-brain --jq .permissions.push` = `true` → étape 5.
3. Sinon, **demande d'accès sans doublon**. Cherche les tiennes, ouvertes ou fermées :
   `gh issue list -R Rajirahoui/dark-brain --state all --author @me --search "Accès in:title" --json number,state`
   - une ouverte → rien à créer ;
   - seulement des fermées → `gh issue comment <n> -R Rajirahoui/dark-brain --body "Toujours pas d'accès (relancé par /setup)."` ;
   - aucune → `gh issue create -R Rajirahoui/dark-brain --title "Accès @<pseudo>" --body "Demande envoyée par /setup."` (pas de label : GitHub les ignore pour un non-membre).

   Dis : « Demande envoyée à Raji. Relance /setup quand tu as l'invitation (mail GitHub). » et **arrête-toi** (garde les réponses en tête si la personne relance dans cette session).

## 5. Corpus et garde-fou

`gh auth setup-git`, puis `git config core.hooksPath .githooks` (le garde-fou tourne à chaque push), puis `git submodule update --init rag`.
Échec du sous-module alors que l'accès à dark-brain est là → c'est l'accès au corpus qui manque : refais 4.1 (invitation corpus en attente ?) ; toujours rien → 4.3 (demande à Raji, sans doublon). Dis « corpus pas encore accessible » et arrête-toi.

## 6. Branche

- Branche courante = `<slug>` → déjà fait.
- `git ls-remote origin refs/heads/<slug>` renvoie une ligne → `git switch <slug>` (puis `git pull --no-rebase -q`).
- Sinon → `git switch -c <slug> origin/main`.

## 7. Profil

**Profil conservé à l'étape 2** → ne réécris rien, passe à l'étape 8. **Profil complété** → ajoute seulement la ligne `cerveau:`.

Sinon, écris `equipe/<slug>.md` :

```markdown
---
prenom: <Prénom>
github: <pseudo>
cerveau: <00_CERVEAU_MERE|01_CERVEAU_SUJET|…|07_CERVEAU_PITCH|renfort>
pole: <front|back|design|infra|pitch|polyvalent>
promo: <B1…M2>
forces: [<point fort>, <point fort>]
os: <macos|windows|linux>
inscrit: <oui|partiel|non>
---
```

**Cerveau toujours libre ?** Juste avant le commit : `git fetch -q origin`, refais le test « libres » de la question 6 (la liste a pu changer pendant que tu attendais l'accès). Pris entre-temps → redemande parmi les libres.

Puis `bash scripts/check.sh` (doit afficher « OK »).

- **Profil absent de `origin/main`** (premier setup) : `git add equipe/<slug>.md`, commit `équipe : profil <slug>`, `git push -u origin <slug>`. PR ouverte pour `<slug>` (`gh pr list --head <slug> --base main --state open --json number`) → réutilise-la ; sinon `gh pr create --base main --head <slug> --title "équipe : profil <slug>" --body "Profil créé par /setup."`. Puis `gh pr merge <n> --merge` (**sans** `--delete-branch`). À ce moment la branche ne contient que le profil : la fusion est sans risque.
- **Profil déjà sur `origin/main`** : si ta branche n'a **aucun** commit absent de `main` (`git rev-list --count origin/main..HEAD` = 0 avant ton commit), fais comme au premier setup (commit, push, PR, fusion) : le cerveau est réservé tout de suite. Sinon ne crée **aucune** PR (la branche contient du travail en cours) : commit sur la branche, et dis « Ton profil partira avec ta prochaine livraison (/sync livrer) ; préviens Raji du cerveau choisi pour qu'il ne soit pas pris. »

## 8. Fin

- `inscrit` ≠ oui : rappelle les **deux** inscriptions (formulaire de l'école + nuitdelinfo.com en choisissant le site EPSI Lille), **avant le 25 novembre**.
- Dis en 4 lignes : ta branche est `<slug>` ; ton cerveau est `<cerveau>`, lis son hub (`<cerveau>/00_Cerveau_<NOM>.md`) et sa recette avant la nuit ; le déroulé est dans `PLAYBOOK.md` ; `/tache` pour prendre une tâche, `/point` pour voir l'équipe.
