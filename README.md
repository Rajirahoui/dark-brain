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

Dans Claude Code, tape **`/setup`** et réponds aux questions. Il crée ton profil et ta branche, puis demande ton accès au corpus.
Si tu n'as pas encore accès, `/setup` le demande à Raji. Relance `/setup` quand tu as reçu l'invitation.

## Pendant la nuit

| Commande | Pour |
|---|---|
| `/tache` | prendre une tâche, en créer une, la finir |
| `/point` | voir qui fait quoi et le temps restant |
| `/sync` | récupérer le travail des autres, livrer le tien |
| `/savoir` | poser une question sur les règles ou le corpus IA |

Les règles d'équipe sont dans [CLAUDE.md](CLAUDE.md). La plus importante : **on ne touche jamais `main` ni la branche d'un autre.**
