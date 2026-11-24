#!/usr/bin/env bash
# Garde-fou du repo public : frontmatter des skills valide, aucun téléphone ni e-mail
# dans les fichiers suivis OU non suivis (hors .gitignore). Le sous-module rag/ (privé) est exclu : c'est voulu.
cd "$(git rev-parse --show-toplevel)" || exit 2
fail=0
scan() { git ls-files -z -co --exclude-standard -- . ':(exclude)rag' | xargs -0 grep -sIHnE "$1" --; }

for f in .claude/skills/*/SKILL.md; do
  [ -e "$f" ] || continue
  d=$(basename "$(dirname "$f")")
  head -n 10 "$f" | grep -qx "name: $d" || { echo "KO $f : 'name: $d' absent du frontmatter"; fail=1; }
  head -n 10 "$f" | grep -q '^description: ' || { echo "KO $f : 'description:' absent du frontmatter"; fail=1; }
done

if scan '0[1-9]([ .]?[0-9]{2}){4}'; then
  echo "KO : numéro de téléphone dans un fichier (repo public). Retire-le ; faux positif → reformule le nombre."; fail=1
fi
if scan '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' | grep -v noreply; then
  echo "KO : adresse e-mail dans un fichier (repo public). Retire-la."; fail=1
fi

# Liens markdown relatifs : la cible doit exister (hors rag/ privé et docs/superpowers/ historiques).
# (fonction hors de $(...) : le bash 3.2 de macOS analyse mal un case dans une substitution)
links_ko() {
  git -c core.quotepath=off ls-files -co --exclude-standard -- '*.md' ':(exclude)rag' ':(exclude)docs/superpowers' |
  while IFS= read -r md; do
    dir=$(dirname "$md")
    grep -o '](\([^)]*\))' "$md" 2>/dev/null | sed 's/^](//; s/)$//' | while IFS= read -r t; do
      case "$t" in
        http://*|https://*|mailto:*|\#*|'') continue ;;
      esac
      p=$(printf '%s' "${t%%#*}" | sed 's/ ".*$//; s/%20/ /g; s/^<//; s/>$//')
      [ -e "$dir/$p" ] || echo "KO $md : lien cassé → $t"
    done
  done
}
broken=$(links_ko)
if [ -n "$broken" ]; then echo "$broken"; fail=1; fi

[ "$fail" -eq 0 ] && echo "OK : garde-fou passé"
exit "$fail"
