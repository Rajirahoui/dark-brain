---
name: inviter
description: Réservé à Raji (owner) - liste les demandes d'accès ouvertes par /setup et, après son accord, invite chaque membre sur dark-brain (écriture) et sur le corpus benoit-ferrere-rag (lecture).
---

# /inviter — envoyer les invitations

1. `gh api user --jq .login` doit valoir `Rajirahoui`. Sinon : « Seul Raji peut inviter. Ta demande est déjà partie avec /setup. » et arrête-toi.
2. Demandes ouvertes :
   `gh issue list -R Rajirahoui/dark-brain --state open --search "Accès in:title" --json number,title,author --jq '.[] | "\(.number) \(.author.login) \(.title)"'`
   Le pseudo à inviter est **l'auteur** de l'issue (pas le texte du titre). Aucune demande → dis-le et arrête-toi.
3. Montre la liste, puis demande avec AskUserQuestion (choix multiples, 4 pseudos par question au plus, plusieurs questions si besoin) **qui inviter**. Rien n'est envoyé sans ce choix : chaque invitation envoie un mail GitHub.
4. Pour chaque pseudo choisi :
   ```bash
   gh api -X PUT repos/Rajirahoui/dark-brain/collaborators/<pseudo> -f permission=push
   gh api -X PUT repos/Rajirahoui/benoit-ferrere-rag/collaborators/<pseudo> -f permission=pull
   gh issue close <n> -R Rajirahoui/dark-brain --comment "Invitation envoyée. Relance /setup : il l'accepte pour toi."
   ```
   Si l'un des deux `gh api -X PUT` échoue : **ne ferme pas** l'issue, note l'erreur, passe au pseudo suivant.
5. Pseudo non retenu : laisse l'issue ouverte, ne commente rien.
6. Résume : invités, laissés en attente, erreurs (pseudo introuvable, déjà membre).
