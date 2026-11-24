# 📖 PLAYBOOK — la Nuit, étape par étape

> Le **quand**. Le **comment** est dans le hub de chaque cerveau ; le **qui** est dans [l'orchestrateur](00_CERVEAU_MERE/00_Orchestrateur.md).

## Avant la nuit

| Quand | Quoi | Qui |
|---|---|---|
| **avant le 25/11** | les deux inscriptions : formulaire de l'école (lien dans le mail du coach) **et** nuitdelinfo.com en choisissant le site EPSI Lille | les 8 |
| dès que possible | clone + `/setup` : profil, branche, cerveau choisi ; accepter l'installation du plugin Matt Pocock à l'ouverture du dossier | les 8 |
| J-7 | lire le hub de son cerveau et sa recette | les 8 |
| J-7 | comptes prêts chez 2-3 hébergeurs, offres gratuites vérifiées | [INFRA](05_CERVEAU_INFRA/00_Cerveau_INFRA.md) |
| J-7 | vérifier qu'on peut faire une maquette Claude Design avec son compte | [DESIGN](02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) |
| dès publication | lire les défis 2026, pré-sélection notée | [DÉFIS](06_CERVEAU_DEFIS/00_Cerveau_DEFIS.md) |
| J-2 | se mettre d'accord sur la stack la plus connue de l'équipe (le sujet peut la faire changer) | Raji + FRONT + BACK |
| J-0 | arriver au campus (2 rue Alphonse Colas, Lille) avant 16h39 : PC chargé, chargeur, `git pull` fait, Claude Code connecté | les 8 |

## Pendant la nuit

| Heure | Jalon | Cerveaux | Commandes |
|---|---|---|---|
| **16h39** | sujet dévoilé | tous écoutent, [SUJET](01_CERVEAU_SUJET/00_Cerveau_SUJET.md) note | — |
| 16h45-17h15 | cadrage, choix des défis, tâches | SUJET + Raji + DÉFIS | `grill-me`, `domain-modeling`, `/sujet` |
| **17h15** | chacun a une tâche | tous | `/tache` *mes tâches* |
| 17h15-18h | maquette · squelette d'appli · contrat d'API · page vide en ligne | DESIGN · FRONT · BACK · INFRA | `/maquette`, `codebase-design`, `wizard` |
| **18h** | maquette validée | DESIGN + SUJET + FRONT | `/tache` *finir* |
| 18h-20h | premiers écrans, premières routes | FRONT, BACK | `prototype`, `tdd`, `/sync` |
| **20h** | appli en ligne (URL publique) | INFRA | — |
| 20h-23h | parcours principal de bout en bout | FRONT, BACK, DÉFIS | `/sync` *livrer* souvent |
| **23h** | appli minimale qui marche, en ligne | SUJET vérifie, coupe si besoin | `/point` |
| 23h-3h | fonctions « si on a le temps » + défis | tous | `code-review`, `/sync` *livrer* |
| **3h** | gel des fonctions : plus rien de nouveau | Raji annonce | — |
| 3h-7h | finitions, mobile, accessibilité, rendus de défis, démo | tous, [PITCH](07_CERVEAU_PITCH/00_Cerveau_PITCH.md) pilote | `diagnosing-bugs` |
| **7h** | GATE Livraison | PITCH + Raji | `00_CERVEAU_MERE/03_GATE_Livraison.md` |
| **7h45** | gel final : plus aucune fusion sur `main` | Raji | — |
| **8h01** | fin | — | — |
| vendredi matin | jury par défi | PITCH | — |
| après | retro, synthèse dans le corpus privé | PITCH + Raji | `retro` |

## Le rythme

- **Toutes les heures :** Raji lance `/point` et annonce les retards ; chacun lance `/sync`.
- **Petites PR, souvent :** une tâche = une PR. Plus elle est petite, moins elle crée de conflits.
- **Bloqué plus de 20 minutes :** on le dit. `diagnosing-bugs`, puis on demande au responsable du cerveau.
- **Pause** conseillée de 20 minutes entre 1h et 5h, annoncée, en décalé.
