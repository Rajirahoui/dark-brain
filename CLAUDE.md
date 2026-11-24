# CLAUDE.md — Dark Brain

Cerveau d'équipe pour la Nuit de l'Info 2026, EPSI Lille : 8 membres, du jeudi 3 décembre 16h39 au vendredi 4 décembre 8h01.
Claude Code lit ce fichier à chaque session. Les règles ci-dessous s'appliquent à **tous** les membres et à **tous** les skills.

## Règles d'équipe (non négociables)

1. **Une branche = un membre = son prénom** (minuscules, sans accent : `raji`, `lea-marie`). On ne travaille jamais sur `main`, ni sur la branche d'un autre.
2. **Les tâches vivent dans GitHub Issues** (`/tache`), jamais dans un fichier. Libre = ouverte et non assignée ; en cours = assignée ; finie = fermée.
3. **Merge, jamais rebase. Jamais de force-push.**
4. **Chacun fusionne sa propre PR** vers `main`, une fois `/sync` passé sans conflit. `main` est protégée : on y entre seulement par PR.
5. **Repo public.** Aucun téléphone, e-mail, adresse perso, ni extrait du corpus `rag/` dans un fichier, une issue, une PR ou un commentaire. `scripts/check.sh` bloque les fuites évidentes (téléphone, e-mail) : le lancer avant chaque commit ; le hook `.githooks/pre-push` (activé par `/setup`) le relance à chaque push. Il ne détecte pas un extrait du corpus : cette règle-là repose sur chacun.
6. **À 16h39**, une personne (Raji par défaut) lance `/sujet` : le sujet devient des tâches assignées selon les profils de `equipe/`.
7. **Le code de l'appli va dans `app/`.** Le découpage en dossiers est fixé par `/sujet` ; une tâche touche des fichiers qu'une seule personne modifie. La mise en ligne part de `main`.
8. **Le corpus `rag/` est un sous-module privé, en lecture seule.** Quand Raji l'enrichit, il remonte le pointeur `rag` par PR ; `/sync` le récupère chez chacun.

## Skills

| Skill | Quand |
|---|---|
| `/setup` | une fois, après le clone : profil, accès, branche, corpus |
| `/tache` | créer, prendre, finir une tâche, voir les siennes ou les libres |
| `/sujet` | 16h39 : sujet + défis → tâches assignées |
| `/point` | état de l'équipe et temps restant avant 8h01 |
| `/sync` | récupérer `main` dans sa branche, pousser, livrer par PR |
| `/savoir` | interroger le corpus (règles NDLI, IA, RAG) — réponse dans le terminal seulement |
| `/inviter` | Raji seul : envoyer les invitations demandées par `/setup` |

## Repères

- Dépôt : `Rajirahoui/dark-brain` (public). Corpus : `Rajirahoui/benoit-ferrere-rag` (privé), monté dans `rag/`.
- Règles officielles de la Nuit : `rag/00-nuit-de-l-info-2026/`.
- Profils : `equipe/<prenom>.md`.
- Design et plan : `docs/superpowers/`.
