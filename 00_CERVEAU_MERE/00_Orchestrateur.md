# 🎯 Orchestrateur — le chef

> Cerveau Mère · tenu par Raji. L'orchestrateur **ne produit rien** : il route chaque demande vers le bon cerveau, pose les gates au bon moment, arbitre les conflits et tient le fil de la nuit.

## Comment router (avant toute action)

1. Lis la demande et trouve sa ligne dans la **table de routage** ci-dessous.
2. Ouvre le **hub** du cerveau indiqué : il dit quoi lire, quoi produire, quels skills lancer.
3. Lance les **skills** de la ligne, dans l'ordre.
4. Passe la **gate** de la ligne avant de dire « c'est fait ».

Demande ambiguë : choisis le cerveau du livrable final (ce qui sera vu par le jury) et dis-le en une ligne.

## Table de routage

| La demande… | Cerveau | Skills | Gate |
|---|---|---|---|
| le sujet tombe, comprendre, découper, répartir | [01 SUJET](../01_CERVEAU_SUJET/00_Cerveau_SUJET.md) puis `/sujet` | `/grill-me`, `domain-modeling`, `/sujet` | [Règles NDLI](01_Regles_NDLI.md) |
| choisir la stack, un langage, un framework, une base | Cerveau Mère : [Choix de stack](04_Choix_de_stack.md) | `research`, `/savoir` | — |
| maquette, écran, parcours, couleurs | [02 DESIGN](../02_CERVEAU_DESIGN/00_Cerveau_DESIGN.md) | `/maquette` | — |
| intégrer un écran, composant, CSS | [03 FRONT](../03_CERVEAU_FRONT/00_Cerveau_FRONT.md) | `prototype`, `codebase-design`, `tdd` | — |
| API, base de données, logique métier | [04 BACK](../04_CERVEAU_BACK/00_Cerveau_BACK.md) | `tdd`, `codebase-design` | — |
| mettre en ligne, hébergeur, variables d'env | [05 INFRA](../05_CERVEAU_INFRA/00_Cerveau_INFRA.md) | `wizard` | [Livraison](03_GATE_Livraison.md) |
| un défi : le lire, le choisir, le rendre | [06 DÉFIS](../06_CERVEAU_DEFIS/00_Cerveau_DEFIS.md) | `/savoir`, `research` | [Règles NDLI](01_Regles_NDLI.md) |
| démo, présentation, rendu au jury | [07 PITCH](../07_CERVEAU_PITCH/00_Cerveau_PITCH.md) | `/savoir` | [Livraison](03_GATE_Livraison.md) |
| « ça marche pas », bug, résultat bizarre | cerveau du fichier en cause | `diagnosing-bugs` | — |
| livrer mon travail | cerveau de la tâche | `code-review`, `pr` puis `/sync` *livrer* | — |
| une tâche : créer, prendre, finir | cerveau de la tâche | `/tache` | — |
| qui fait quoi, temps restant, retard | Cerveau Mère | `/point` | — |
| une question sur les règles ou l'IA | Cerveau Mère | `/savoir` | — |
| après 8h01, bilan | [07 PITCH](../07_CERVEAU_PITCH/00_Cerveau_PITCH.md) | `/retro` | — |

`/sujet`, `/tache`, `/point`, `/sync`, `/savoir`, `/maquette`, `/setup`, `/inviter` sont les skills de Dark Brain. `/grill-me`, `domain-modeling`, `prototype`, `tdd`, `codebase-design`, `diagnosing-bugs`, `code-review`, `pr`, `wizard`, `research`, `/retro` viennent du plugin de Matt Pocock (proposé à l'ouverture du dossier). **`/grill-me` et `/retro` se tapent à la main** : Claude ne peut pas les lancer seul. Les autres, Claude les lance quand la ligne le dit.

## Arbitrage (en cas de conflit, dans cet ordre)

1. **Règles NDLI** : veto. Une règle de la Nuit enfreinte = on ne livre pas ça.
2. **Livré à l'heure** : une fonction finie et en ligne bat trois fonctions à moitié faites.
3. **Expérience utilisateur** : le jury utilise l'appli ; ce qu'il voit passe avant ce qu'il ne voit pas.
4. **Code propre** : lisible et découpé, pour que 8 personnes avancent sans se bloquer.
5. **Performance** : seulement si elle se voit pendant la démo.

Exemples : la maquette prévoit une animation complexe et il est 2 h → on garde l'écran sans l'animation (2 > 3). Le back veut refaire le modèle de données à 4 h → non (2 > 4).

## Le fil de la nuit

L'ordre des étapes et les jalons vivent dans `PLAYBOOK.md` (racine). L'orchestrateur vérifie chaque jalon avec `/point` :

| Jalon | Vérifie | Si raté |
|---|---|---|
| 17h15 tâches créées | issue « Sujet NDLI 2026 » épinglée, chacun a une tâche | Raji finit `/sujet` seul, les autres commencent leur hub |
| 18h maquette validée | tâche maquette fermée, lien dans la tâche | le front part sur la maquette en l'état |
| 20h en ligne | tâche « Mise en ligne » fermée, URL qui répond | INFRA + un renfort jusqu'à ce que ça réponde |
| 23h appli minimale | parcours principal faisable de bout en bout en ligne | on coupe dans le périmètre (01 SUJET tranche) |
| 3h gel des fonctions | plus aucune nouvelle tâche de fonction | les nouvelles idées vont en issue « plus tard » |
| 7h livraison | [GATE Livraison](03_GATE_Livraison.md) passée | on corrige seulement ce qui bloque la gate |
| 7h45 gel final | plus aucune fusion sur `main` | — |

## Le Cerveau Mère

- [01 Règles NDLI](01_Regles_NDLI.md) : ce qui est vrai pour toute l'équipe, veto.
- [02 Équipe](02_Equipe.md) : qui tient quel cerveau, comment on se parle.
- [03 GATE Livraison](03_GATE_Livraison.md) : la checklist de 7h.
- [04 Choix de stack](04_Choix_de_stack.md) : quel langage, framework, base selon le besoin (repères Stack Overflow 2026).

L'artefact racine de la nuit est l'**issue épinglée « Sujet NDLI 2026 »** : produite par `/sujet` à partir du travail de 01 SUJET, lue par tous les cerveaux. Aucun cerveau ne réinvente le sujet dans son coin.
