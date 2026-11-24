# 🛠️ Choix de stack

> Cerveau Mère · [Orchestrateur](00_Orchestrateur.md). Vrai pour toute l'équipe : **une seule stack**, choisie à J-2 par Raji, FRONT et BACK, confirmée par `/sujet` à 16h45 selon le sujet. Lu par FRONT, BACK et INFRA.

## La règle d'or de la nuit

1. **Ce que la majorité connaît** bat ce qui est à la mode. Compter les points forts dans les profils `equipe/*.md`.
2. **Un seul langage du front au back** si possible (JavaScript/TypeScript) : mêmes outils, mêmes types, tout le monde peut aider partout.
3. **Déployable en 15 minutes** : on teste le déploiement à J-2 avec INFRA, pas à 19h.
4. **Aucun framework découvert la nuit.** Une librairie précise pour un besoin précis (carte, graphiques), oui.
5. **Le plus simple qui tient la démo** : pas de microservices, pas de Kubernetes, pas d'authentification si le parcours ne l'exige pas.

## Ce que disent les développeurs (Stack Overflow Developer Survey 2026)

Source : [survey.stackoverflow.co/2026/technology](https://survey.stackoverflow.co/2026/technology), publiée le 6 octobre 2026, tous répondants, les 10 premiers de chaque liste (8 pour les bases). Usage = « utilisé de façon intensive l'an passé ».

| Langages (n = 14 099) | % | Frameworks et technos web (n = 10 281) | % | Bases de données (n = 12 061) | % |
|---|---|---|---|---|---|
| JavaScript | 62,0 | Node.js | 46,4 | PostgreSQL | 57,9 |
| SQL | 58,4 | React | 41,5 | SQLite | 42,1 |
| HTML/CSS | 58,2 | Next.js | 20,6 | MySQL | 35,1 |
| Python | 58,0 | ASP.NET Core | 19,9 | Redis | 28,3 |
| Bash/Shell | 51,3 | jQuery | 19,7 | SQL Server | 27,1 |
| TypeScript | 43,8 | FastAPI | 18,5 | MariaDB | 20,3 |
| Java | 27,6 | Vue.js | 17,2 | MongoDB | 19,0 |
| C# | 27,1 | Angular | 16,0 | Elasticsearch | 14,8 |
| PowerShell | 24,6 | Express | 15,6 | | |
| C++ | 24,3 | ASP.NET | 13,9 | | |

**Les plus appréciés** par ceux qui les utilisent : PostgreSQL (62,3 %) et SQLite (56,4 %) en bases ; Rust (67,4 %) en langages ; SvelteKit, Svelte et Astro parmi les frameworks web les mieux notés. Hébergement le plus cité : AWS (41,8 %), Azure, Cloudflare, Google Cloud (~25 %), Vercel (10,7 %).

**Ce qu'on en retient pour la nuit :** JavaScript/TypeScript + Node.js + React couvrent le plus de gens ; Python + FastAPI est le chemin naturel dès qu'il y a de l'IA ou des données ; PostgreSQL et SQLite sont à la fois les plus utilisées et les plus appréciées. Le reste se choisit selon le besoin, ci-dessous.

## Le bon outil selon le besoin

Recommandations de l'équipe (pas des chiffres de l'enquête). Toujours croiser avec ce que l'équipe connaît.

| Besoin du sujet | Stack conseillée | Hébergement type (voir le cerveau INFRA) | Attention |
|---|---|---|---|
| contenu, pages, accessibilité forte | HTML/CSS/JS, ou **Astro** | statique | le plus rapide à rendre accessible |
| appli interactive sans serveur (formulaires, filtres, état) | **React + Vite** (ou Vue / Svelte si l'équipe les connaît) + JSON local | statique | données perdues au rechargement sans `localStorage` |
| appli complète JS (pages + API) | **Next.js**, ou **Node.js + Express** + front React | front + fonctions serveur | rester sur des routes simples, éviter les options avancées inconnues |
| IA, LLM, traitement de données, Python | **FastAPI** + front React/Vue/HTML | serveur Python ou fonctions Python | clé d'API en variable d'environnement, surveiller le coût et les quotas |
| données relationnelles, un seul serveur | **SQLite** | serveur continu | sur des fonctions serverless le disque est éphémère : les données disparaissent |
| données partagées en ligne, plusieurs utilisateurs | **PostgreSQL** hébergé | base managée | créer la base à J-2, pas la nuit |
| temps réel (chat, jeu à plusieurs, vote live) | **Node.js + WebSocket** (Socket.IO) | serveur continu | pas de WebSocket sur l'hébergement statique ni sur la plupart des fonctions |
| jeu ou animation 2D | Canvas 2D, ou **Phaser** | statique | prévoir une version jouable à 23h |
| 3D dans le navigateur | **Three.js** | statique | lourd sur téléphone : tester tôt |
| carte | **Leaflet** + OpenStreetMap | — | respecter l'attribution OpenStreetMap |
| graphiques | **Chart.js** (simple) ou D3 (sur mesure) | — | D3 prend du temps |
| équipe surtout C# | **ASP.NET Core** | serveur continu | |
| équipe surtout Java | **Spring Boot** | serveur continu | démarrage lent, déployer tôt |
| équipe surtout PHP | PHP simple ou **Laravel** | hébergeur PHP ou serveur de l'école | |

## Démarrer en une commande

| Stack | Commande |
|---|---|
| React + Vite | `npm create vite@latest app -- --template react` (ou `react-ts`) |
| Next.js | `npx create-next-app@latest app` |
| Astro | `npm create astro@latest app` |
| Vue | `npm create vue@latest app` |
| FastAPI | `pip install "fastapi[standard]"` puis `fastapi dev main.py` |
| Express | `npm init -y && npm install express` |

Les versions changent : vérifier la commande dans la documentation officielle à J-2.

## Bloqué ? Chercher vite et bien

1. **Le message d'erreur exact**, entre guillemets, dans Stack Overflow et dans la documentation officielle.
2. **Vérifier la date et la version** de la réponse : une réponse de 2018 peut viser une API disparue.
3. **Comprendre avant de coller.** `diagnosing-bugs` aide à isoler la cause.
4. **Licence :** le contenu de Stack Overflow est sous licence **CC BY-SA**. Code repris → commentaire avec le lien de la réponse au-dessus du bloc (veto « code copié sans droit » des règles NDLI).
5. Après 20 minutes bloqué : on le dit au responsable du cerveau.
