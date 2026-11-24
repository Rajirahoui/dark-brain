---
name: savoir
description: Répond à une question à partir du corpus privé rag/ - règles et infos de la Nuit de l'Info 2026 (EPSI Lille), transcripts et ressources IA (RAG, agents, LLMOps). Répond dans le terminal seulement, avec les sources.
---

# /savoir — interroger le corpus

1. **Corpus présent ?** `rag/` vide ou absent (aucun `.md` dedans) → « Le corpus n'est pas encore branché : il faut l'accès au repo privé. Lance /setup. » et arrête-toi. N'invente aucune réponse.
2. **Chercher** : recherche texte (Grep) dans `rag/**/*.md` avec les mots de la question et leurs variantes (français et anglais : « inscription », « deadline », « RAG hybride », « hybrid search »…). Dossiers : `rag/00-nuit-de-l-info-2026/` (règles et infos de la Nuit), `rag/NN-*/` (transcripts de vidéos), `rag/skool-ressources/` (guides).
3. **Lire** les passages trouvés (pas les fichiers entiers s'ils sont longs).
4. **Répondre** court, dans le terminal, en citant chaque source : chemin du fichier, et l'horodatage `[HH:MM:SS]` pour un transcript. Rien trouvé → dis-le, ne comble pas avec tes connaissances générales sans prévenir.
5. **Jamais** recopier un extrait du corpus dans un fichier, une issue, une PR ou un commentaire de `dark-brain` (repo public, corpus privé et en partie payant). Si on te le demande, refuse et propose de reformuler avec tes mots, sans citation.
