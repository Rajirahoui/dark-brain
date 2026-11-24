# CLAUDE.md — Dark Brain

> Constitution, lue par Claude Code à chaque session. **On route d'abord, on agit ensuite.**
> Cerveau d'équipe pour la Nuit de l'Info 2026, EPSI Lille : 8 membres, du jeudi 3 décembre 16h39 au vendredi 4 décembre 8h01.

## 🔀 Router (avant toute action)

1. Trouve la ligne de la demande dans la **table de routage** de [l'orchestrateur](00_CERVEAU_MERE/00_Orchestrateur.md).
2. Ouvre le **hub** du cerveau indiqué et suis-le.
3. Lance les **skills** de la ligne.
4. Passe la **gate** de la ligne avant de dire « c'est fait ».

Le **quand** est dans [PLAYBOOK.md](PLAYBOOK.md) ; l'état vivant dans GitHub Issues ([DASHBOARD.md](DASHBOARD.md), `/point`).

## 🧭 Hiérarchie (un chef, sept cerveaux)

```
                     CLAUDE.md  ← constitution
                         │
               00_CERVEAU_MERE  ← règles NDLI (veto), équipe, GATE Livraison
               00_Orchestrateur ← CHEF : route, arbitre, tient le fil (Raji)
                         │
  ┌───────┬───────┬──────┼──────┬───────┬───────┐
 01      02      03     04     05      06      07
SUJET  DESIGN  FRONT  BACK  INFRA   DÉFIS   PITCH
```

- [00 Orchestrateur](00_CERVEAU_MERE/00_Orchestrateur.md) · [01 SUJET](01_CERVEAU_SUJET/00_Cerveau_SUJET.md) · [02 DESIGN](02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) · [03 FRONT](03_CERVEAU_FRONT/00_Cerveau_FRONT.md) · [04 BACK](04_CERVEAU_BACK/00_Cerveau_BACK.md) · [05 INFRA](05_CERVEAU_INFRA/00_Cerveau_INFRA.md) · [06 DÉFIS](06_CERVEAU_DEFIS/00_Cerveau_DEFIS.md) · [07 PITCH](07_CERVEAU_PITCH/00_Cerveau_PITCH.md)
- **Un cerveau = un responsable** (champ `cerveau:` du profil dans `equipe/`). Il tient ses fichiers et arbitre dans son lobe.
- **Artefact racine** : l'issue épinglée « Sujet NDLI 2026 », produite par `/sujet`, lue par tous. Aucun cerveau ne réinvente le sujet.
- **Arbitrage** : Règles NDLI > Livré à l'heure > Expérience utilisateur > Code propre > Perf.
- **Liens** : un fichier lie les fichiers de son cerveau et son hub ; seuls les hubs lient l'orchestrateur et les hubs voisins. Ailleurs, on cite le chemin en `code`.

## ⚖️ Règles d'équipe (non négociables)

1. **Une branche = un membre = son prénom** (minuscules, sans accent : `raji`, `lea-marie`). Jamais `main`, jamais la branche d'un autre.
2. **Les tâches vivent dans GitHub Issues** (`/tache`), jamais dans un fichier.
3. **Merge, jamais rebase. Jamais de force-push.**
4. **Chacun fusionne sa propre PR** vers `main`, après `/sync` sans conflit. `main` est protégée : on y entre par PR. Gel à 7h45.
5. **Repo public.** Aucun téléphone, e-mail, adresse perso, secret (clé d'API) ni extrait du corpus `rag/` dans un fichier, une issue, une PR ou un commentaire. `bash scripts/check.sh` bloque téléphones, e-mails et liens cassés ; le hook `.githooks/pre-push` (activé par `/setup`) le relance à chaque push. Il ne voit ni les clés d'API ni les extraits du corpus : ça, c'est chacun.
6. **Le code de l'appli va dans `app/`**, découpé en dossiers par `/sujet` ; une tâche touche des fichiers qu'une seule personne modifie. Déploiement depuis `main`.
7. **Le corpus `rag/`** est un sous-module privé, en lecture seule. Quand Raji l'enrichit, il remonte le pointeur `rag` par PR ; `/sync` le récupère.

## 🧰 Skills

**Dark Brain** (dans `.claude/skills/`) :

| Skill | Quand |
|---|---|
| `/setup` | une fois après le clone : profil, cerveau, accès, branche, corpus |
| `/sujet` | 16h39 : sujet + défis → tâches assignées, fiches défis |
| `/maquette` | 17h15 : maquette des écrans clés dans Claude Design |
| `/tache` | créer, prendre, finir une tâche |
| `/point` | état de l'équipe et temps restant |
| `/sync` | récupérer `main`, pousser, livrer par PR |
| `/savoir` | question sur les règles ou le corpus (réponse dans le terminal) |
| `/inviter` | Raji : envoyer les invitations |

**Matt Pocock** (plugin `mattpocock-skills`, proposé à l'ouverture du dossier, déclaré dans `.claude/settings.json`) : `/grill-me` · `domain-modeling` · `prototype` · `tdd` · `codebase-design` · `diagnosing-bugs` · `code-review` · `pr` · `wizard` · `research` · `/retro`. Quel skill à quel moment : la table de routage de l'orchestrateur.

## Repères

- Dépôt : `Rajirahoui/dark-brain` (public). Corpus : `Rajirahoui/benoit-ferrere-rag` (privé), monté dans `rag/` ; règles officielles de la Nuit dans `rag/00-nuit-de-l-info-2026/`.
- Profils : `equipe/<prenom>.md`. Design et plans : `docs/superpowers/`.
