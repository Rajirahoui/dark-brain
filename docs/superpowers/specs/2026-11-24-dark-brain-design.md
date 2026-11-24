# Dark Brain — design

Date : 2026-11-24 · Auteur : Raji (owner GitHub `Rajirahoui`) · Statut : à valider

## 1. Intention

Équipe de 8 étudiants EPSI Lille, Nuit de l'Info 2026 (jeudi 3 déc. 16h39 → vendredi 4 déc. 8h01, campus 2 rue Alphonse Colas, Lille). Le sujet national tombe à 16h39 ; livrable = une appli web en ligne, plus jusqu'à 5 défis partenaires.

Dark Brain = le cerveau commun de l'équipe. Il sert à **se répartir les tâches sans se marcher dessus** : chaque membre a sa branche Git, Claude Code tourne sur les 8 PC avec les mêmes skills, et la connaissance utile (règles NDLI + corpus IA de `benoit-ferrere-rag`) est interrogeable depuis Claude Code.

## 2. Objectifs, non-objectifs, anti-objectifs

**Objectifs**
- Onboarding en une commande après le clone : `/setup`.
- Répartition des tâches visible par tous en temps réel.
- Une branche par personne ; `main` ne casse jamais.
- À 16h39, le sujet se découpe en tâches assignées selon les profils en quelques minutes.
- Corpus RAG + infos NDLI consultables via un skill.

**Non-objectifs**
- Pas de base vectorielle ni de serveur RAG : ~95k mots de markdown, la recherche texte suffit.
- Pas de choix de stack ni d'hébergement de l'appli maintenant (sujet inconnu ; hébergement décidé pendant la nuit, choix de Raji). `app/` reste vide jusqu'à la nuit.
- Pas de plugin Claude Code, pas de script d'install global.
- Pas d'automatisation des inscriptions (formulaire EPSI + site NDLI) : chacun les fait lui-même.
- Pas de tableau GitHub Project (demanderait le scope `project` à chacun) : Issues + labels suffisent.

**Anti-objectifs (échec même si ça marche)**
- Une donnée perso (téléphone, e-mail, adresse) dans le repo public.
- Quelqu'un pousse sur `main` ou sur la branche d'un autre.
- Des tâches tenues dans un fichier markdown qui diverge d'une branche à l'autre.
- Le corpus Skool (payant) exposé publiquement.

## 3. Contraintes

- 8 PC, macOS et Windows mélangés. Claude Code installé sur les 8 (confirmé par Raji).
- Prérequis par PC : Git (Windows : Git for Windows, déjà requis par Claude Code), GitHub CLI `gh`, un compte GitHub.
- `dark-brain` **public** (choix de Raji) ; `benoit-ferrere-rag` **privé** (corpus Skool). Raji owner des deux, compte GitHub perso (pas d'organisation).
- Compte perso : pas de verrou par utilisateur sur une branche. Le verrou de `main` (ruleset) est gratuit car le repo est public.
- Le repo GitHub `benoit-ferrere-rag` est **vide aujourd'hui** : le commit local `a9eeddf` n'a jamais été poussé. Aucun fichier > 100 Mo (max 21 Mo, `.git` 82 Mo) : push possible.
- Échéance école : formulaire + inscription site NDLI (site « EPSI Lille ») **avant le 25 nov. 2026**.

## 4. Approches considérées

| | Approche | Pour | Contre | Verdict |
|---|---|---|---|---|
| A | Skills dans le repo (`.claude/skills/`) | clone + `/setup`, zéro install ; skills versionnés avec le code ; mise à jour en fusionnant `main` | skills dispo seulement dans le dossier du repo | **choisie par Raji** |
| B | Plugin Claude Code (marketplace) | install globale, `/plugin update` | étape en plus × 8, deux choses à maintenir | écartée |
| C | Script qui copie dans `~/.claude/skills` | — | copies qui divergent, version Windows à écrire | écartée |

Liaison avec le RAG : **sous-module** `rag/` → `benoit-ferrere-rag` (choix de Raji). Écartés : tout fusionner dans le repo RAG (179 Mo d'images à cloner × 8, corpus mélangé au travail d'équipe) ; copier le texte (copie qui ne suit plus le RAG).

Invitations : **`/setup` collecte**, Raji invite via `/inviter` (choix de Raji). Écarté : Raji recopie 7 pseudos à la main.

## 5. Architecture

### Deux repos

**`Rajirahoui/dark-brain` (public)**
```
dark-brain/
├── CLAUDE.md              ← règles d'équipe, lues par Claude Code à chaque session
├── README.md              ← prérequis + 3 étapes (clone, ouvrir Claude Code, /setup)
├── .gitmodules            ← rag → benoit-ferrere-rag (privé)
├── .claude/skills/
│   ├── setup/SKILL.md     ← chaque membre, une fois
│   ├── tache/SKILL.md     ← créer / prendre / finir une tâche
│   ├── sujet/SKILL.md     ← 16h39 : sujet → tâches assignées
│   ├── point/SKILL.md     ← état de l'équipe
│   ├── sync/SKILL.md      ← main → ma branche ; ma branche → PR
│   ├── savoir/SKILL.md    ← interroger rag/ (NDLI + corpus IA)
│   └── inviter/SKILL.md   ← Raji seul : envoyer les invitations
├── equipe/<prenom>.md     ← profil de chaque membre (écrit par /setup)
├── app/                   ← code de l'appli de la nuit
└── rag/                   ← sous-module (vide sans accès au repo privé)
```

**`Rajirahoui/benoit-ferrere-rag` (privé)** — on pousse l'existant, puis on ajoute :
```
00-nuit-de-l-info-2026/
├── 2026-11-24-nuit-de-l-info-2026-regles.md   ← site : dates, format, défis, livrables, jury, liens
└── 2026-11-24-mail-epsi-lille.md              ← mail du coach : lieu, échéance 25/11, 2 inscriptions, contact
```
Même frontmatter que les autres notes du corpus (`type`, `title`, `source_url`, `capture`, `tags`). Les contacts du coach restent ici, jamais dans `dark-brain`.

### Où vit quoi (un seul endroit par chose)

| Chose | Vit dans |
|---|---|
| Tâches, assignation, avancement | GitHub Issues de `dark-brain` (ouverte + non assignée = libre ; ouverte + assignée = en cours ; fermée = finie) |
| Sujet de la nuit + défis choisis | Une issue épinglée « Sujet NDLI 2026 » |
| Profils | `equipe/<prenom>.md` sur `main` |
| Règles d'équipe | `CLAUDE.md` de `dark-brain` |
| Règles NDLI, corpus IA | `rag/` (repo privé) |
| Code de l'appli | `app/`, branches perso → PR → `main` |

### Branches et protection

- Une branche par membre, nommée par le prénom en minuscules sans accent (`raji`, `lea`…). Créée depuis `main` par `/setup`.
- Ruleset sur `main` : PR obligatoire, 0 approbation requise (vitesse pendant la nuit), force-push et suppression bloqués. Raji (admin) en bypass pour les urgences.
- Les branches des autres ne sont pas verrouillées techniquement (limite des comptes perso). La règle est dans `CLAUDE.md` et appliquée par `/sync`, qui refuse de pousser ailleurs que sur la branche du prénom de l'utilisateur.

### Droits (décision Claude, à vérifier par Raji)

- 8 membres = Raji (owner) + 7 invités.
- `dark-brain` : invités en **écriture** (`push`) — nécessaire pour pousser sa branche, créer labels/issues, épingler.
- `benoit-ferrere-rag` : invités en **lecture** (`pull`) — le sous-module se clone, personne ne peut abîmer le corpus. Seul Raji y écrit.
- Sous-module en URL **HTTPS** ; `/setup` lance `gh auth setup-git` pour que Git s'authentifie via `gh` (macOS et Windows).
- Sous-module **épinglé** sur un commit. Quand Raji ajoute au RAG, il remonte le pointeur dans `dark-brain` par PR ; `/sync` fait ensuite `git submodule update --init` chez chacun.

### Fusion et conflits (décision Claude)

- **Merge, jamais rebase** : pas de force-push à expliquer à 3 h du matin.
- Chacun fusionne **sa propre PR** une fois `/sync` passé sans conflit.
- Le découpage de `app/` par dossiers (un par pôle ou par fonctionnalité) est fixé par `/sujet` à 16h39, quand la stack est connue, et écrit dans l'issue « Sujet NDLI 2026 ». Une tâche = des fichiers qu'une seule personne touche.
- Le déploiement en ligne part de `main`.

### Public = prudence (décision Claude)

Issues, PR et commentaires de `dark-brain` sont publics. Règle dans `CLAUDE.md`, `/savoir` et `/sujet` : **aucun extrait du RAG, aucun contact** dans une issue, une PR ou un fichier de `dark-brain`. `/savoir` répond dans le terminal seulement.

### Labels (créés une fois)

`pole:front`, `pole:back`, `pole:design`, `pole:infra`, `pole:pitch`, `defi:<nom>` (créés par `/sujet` à la nuit), `sujet`.

Pas de label `acces` : GitHub ignore les labels posés par un non-collaborateur. Une demande d'accès se reconnaît à son titre « Accès @pseudo ».

## 6. Comportement des skills

Tous les skills n'utilisent que `git` et `gh` : identiques sous macOS et Windows (Git Bash). Les questions passent par des choix à cocher (AskUserQuestion) dès que possible.

**`/setup`** (chaque membre, une fois ; relançable sans casse)
1. Vérifie `git`, `gh`, `gh auth status`. S'il manque quelque chose : explique l'install pour l'OS détecté et s'arrête.
2. Lit le pseudo GitHub via `gh api user` (on ne le demande pas).
3. Questions : prénom ; pôle principal (front / back / design / infra-réseau / pitch-com / polyvalent) ; promo (B1…M2) ; points forts (choix multiples + autre) ; inscription faite ? (formulaire EPSI + site NDLI : oui / non / un seul des deux). Avertit : rien de perso (tel, mail), le repo est public.
4. Vérifie le droit d'écriture (`gh api repos/Rajirahoui/dark-brain --jq .permissions.push`).
   - Invitation en attente (`gh api user/repository_invitations`) : propose de l'accepter tout de suite (avec l'accord du membre), pour `dark-brain` et le RAG.
   - Ni accès ni invitation : ouvre (ou retrouve) une issue « Accès @pseudo », dit « relance /setup quand Raji t'a invité », s'arrête.
5. Avec accès : `gh auth setup-git` ; `git submodule update --init rag` ; crée ou bascule sur la branche `<prenom>` depuis `origin/main` ; écrit `equipe/<prenom>.md` ; commit, push `-u` ; ouvre une PR « équipe : profil <prenom> » vers `main`.
6. Si l'inscription n'est pas faite : rappel des deux étapes et de l'échéance du 25/11.

**`/inviter`** (Raji)
Liste les issues ouvertes titrées « Accès @… », montre les pseudos, demande confirmation, puis pour chaque pseudo validé : invitation en écriture sur `dark-brain`, en lecture sur `benoit-ferrere-rag`, commentaire + fermeture de l'issue. Rien n'est envoyé sans le oui de Raji.

**`/tache`**
- *créer* : titre, pôle, défi éventuel → issue avec labels.
- *prendre* : choisit dans les issues libres (filtrables par pôle) → s'assigne.
- *finir* : relie la PR, ferme l'issue.
- *mes tâches* / *libres* : listes.

**`/sujet`** (une personne avec accès en écriture, Raji par défaut, à 16h39)
Prend le texte du sujet collé dans le chat et les défis choisis (≤ 5). Fixe aussi le découpage de `app/` en dossiers. Crée toujours, en premier, une tâche `pole:infra` « Mise en ligne : choisir l'hébergeur et déployer une page vide depuis main », à finir avant 20 h (décision Claude : l'hébergement se décide la nuit, donc on le règle tôt pour ne pas le découvrir à 7 h). Lit tous les `equipe/*.md` sur `origin/main`. Propose un découpage : tâches de 1-2 h, pôle, dépendances, assignation suivant les profils, charge équilibrée sur les 8. Affiche le tableau ; après OK : crée l'issue épinglée « Sujet NDLI 2026 », les labels `defi:*`, les issues de tâches assignées.

**`/point`**
Tâches par membre (en cours / finies), tâches libres, membres sans tâche, PR ouvertes, branches en retard sur `main`, temps restant avant 8h01 (calculé avec `TZ=Europe/Paris date`, OK sous Git Bash).

**`/sync`**
`git fetch` ; fusionne `origin/main` dans la branche courante ; aide à résoudre les conflits ; push. Option *livrer* : `gh pr create --base main`. Refuse de pousser si la branche courante ≠ prénom du membre ou = `main`.

**`/savoir`**
Recherche texte dans `rag/**/*.md`, lit les passages, répond en citant le fichier (et l'horodatage pour un transcript). Si `rag/` est vide : explique qu'il manque l'accès (→ `/setup`).

## 7. Ordre de construction (pour le plan)

1. Pousser `benoit-ferrere-rag` existant vers GitHub.
2. Ingérer les infos NDLI dans `benoit-ferrere-rag/00-nuit-de-l-info-2026/`, commit, push. Sources déjà en main : pages nuitdelinfo.com (accueil, FAQ, défis) lues le 24/11 ; mail du coach EPSI collé par Raji le 24/11.
3. Créer `dark-brain` en local (`~/Documents/dark-brain`), sous-module `rag/`, `CLAUDE.md`, `README.md`, skills, `app/.gitkeep`, `equipe/.gitkeep`.
4. Créer le repo public GitHub, push, ruleset `main`, labels.
5. Raji lance `/setup` → branche `raji` + PR profil : test bout en bout.
6. Raji transmet le lien du repo aux 7 (message écrit par Raji, pas envoyé par Claude).

## 8. Laissé au builder

- Formulation exacte des skills, du README et de `CLAUDE.md`.
- Gestion des prénoms en double (suffixe initiale du nom).
- Format précis de `equipe/<prenom>.md` (frontmatter simple).
- Messages d'erreur et cas « déjà fait » de `/setup` (doit être relançable).
