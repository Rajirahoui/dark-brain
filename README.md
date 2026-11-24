# Dark Brain

Le cerveau de l'équipe pour la **Nuit de l'Info 2026** à l'EPSI Lille (jeudi 3 décembre 16h39 → vendredi 4 décembre 8h01).
Chacun a sa branche, les tâches sont dans les Issues, et Claude Code sait tout faire avec les mêmes commandes sur les 8 PC.

> [!IMPORTANT]
> **Inscription avant le 25 novembre**, en deux étapes : le formulaire de l'école (lien dans le mail du coach) **et** l'inscription sur [nuitdelinfo.com](https://www.nuitdelinfo.com) en choisissant le site **EPSI Lille**.

## Prérequis

| Outil | macOS | Windows |
|---|---|---|
| Claude Code | [claude.com/claude-code](https://claude.com/claude-code) | idem |
| Git | `xcode-select --install` | [Git for Windows](https://git-scm.com/download/win) |
| GitHub CLI | `brew install gh` | `winget install --id GitHub.cli` |

Puis, une fois : `gh auth login` (choisir GitHub.com, HTTPS, navigateur).

## Installation (3 étapes)

```bash
git clone https://github.com/Rajirahoui/dark-brain.git
cd dark-brain
claude
```

À l'ouverture du dossier, Claude Code propose d'installer le plugin **mattpocock-skills** (skills de dev : `tdd`, `prototype`, `code-review`, `diagnosing-bugs`…) : accepte.

**Ta branche se fait toute seule** : à chaque ouverture de Claude Code dans le dossier, Dark Brain reconnaît ton compte GitHub, crée ta branche (ton prénom) et te place dessus. Il ne touche à rien si tu as du travail non commité.

Puis tape **`/setup`** et réponds aux questions. Il crée ton profil, te fait choisir **ton cerveau**, publie ta branche et demande ton accès au corpus.
Si tu n'as pas encore accès, `/setup` le demande à Raji. Relance `/setup` quand tu as reçu l'invitation.

## Comment c'est organisé

Comme Ecom Brain : **un chef, sept cerveaux**. Chaque membre tient un cerveau.

| | |
|---|---|
| [CLAUDE.md](CLAUDE.md) | la constitution : règles d'équipe, hiérarchie, skills |
| [Orchestrateur](00_CERVEAU_MERE/00_Orchestrateur.md) | le chef : quelle demande va à quel cerveau, avec quels skills |
| [PLAYBOOK.md](PLAYBOOK.md) | la nuit heure par heure, de la préparation à 8h01 |
| [DASHBOARD.md](DASHBOARD.md) | où en est-on (liens directs vers les tâches) |

Cerveaux : [01 SUJET](01_CERVEAU_SUJET/00_Cerveau_SUJET.md) · [02 DESIGN](02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) · [03 FRONT](03_CERVEAU_FRONT/00_Cerveau_FRONT.md) · [04 BACK](04_CERVEAU_BACK/00_Cerveau_BACK.md) · [05 INFRA](05_CERVEAU_INFRA/00_Cerveau_INFRA.md) · [06 DÉFIS](06_CERVEAU_DEFIS/00_Cerveau_DEFIS.md) · [07 PITCH](07_CERVEAU_PITCH/00_Cerveau_PITCH.md)

## Pendant la nuit

| Commande | Pour |
|---|---|
| `/tache` | prendre une tâche, en créer une, la finir |
| `/maquette` | maquetter les écrans dans Claude Design |
| `/point` | voir qui fait quoi et le temps restant |
| `/sync` | récupérer le travail des autres, livrer le tien |
| `/savoir` | poser une question sur les règles ou le corpus IA |

La règle la plus importante : **on ne touche jamais `main` ni la branche d'un autre.**
