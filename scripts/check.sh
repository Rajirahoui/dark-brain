#!/usr/bin/env bash
# Garde-fou du repo public : frontmatter des skills valide, aucun téléphone ni e-mail dans les fichiers suivis.
# git grep ne descend pas dans le sous-module rag/ (privé) : c'est voulu.
cd "$(git rev-parse --show-toplevel)" || exit 2
fail=0

for f in .claude/skills/*/SKILL.md; do
  [ -e "$f" ] || continue
  d=$(basename "$(dirname "$f")")
  head -n 10 "$f" | grep -qx "name: $d" || { echo "KO $f : 'name: $d' absent du frontmatter"; fail=1; }
  head -n 10 "$f" | grep -q '^description: ' || { echo "KO $f : 'description:' absent du frontmatter"; fail=1; }
done

if git grep -nE '0[1-9]([ .]?[0-9]{2}){4}'; then
  echo "KO : numéro de téléphone dans un fichier suivi (repo public)"; fail=1
fi
if git grep -nE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' | grep -v noreply; then
  echo "KO : adresse e-mail dans un fichier suivi (repo public)"; fail=1
fi

[ "$fail" -eq 0 ] && echo "OK : garde-fou passé"
exit "$fail"
