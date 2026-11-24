#!/usr/bin/env bash
# Détecte la branche perso du membre et s'y place, en la créant depuis origin/main si besoin.
#   bash scripts/branche.sh          → bascule sur sa branche (hook SessionStart de Claude Code, et /setup)
#   bash scripts/branche.sh --slug   → affiche seulement le nom de branche
# Nom : celui de son profil equipe/*.md (ligne github:), sinon son prénom GitHub, sinon son pseudo.
# Ne casse jamais rien : travail non commité, HEAD détachée, pas de gh → ne bouge pas, et sort en 0.
# La branche est poussée par /setup avec le profil, pas ici (le profil prouve à qui elle est).
set -u
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/..}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
say() { echo "Dark Brain : $*"; }

command -v gh >/dev/null 2>&1 || { say "GitHub CLI (gh) absent : installe-le puis lance /setup."; exit 0; }
login=$(gh api user --jq .login 2>/dev/null)
[ -n "$login" ] || { say "gh n'est pas connecté : lance « gh auth login » puis /setup."; exit 0; }

# minuscules, accents retirés, œ/æ développés, toute suite hors a-z0-9 → un seul « - », 40 caractères max
slugify() { perl -CSA -MUnicode::Normalize -e '$_ = lc shift; s/\x{153}/oe/g; s/\x{e6}/ae/g; $_ = NFD($_); s/\p{Mn}//g; s/[^a-z0-9]+/-/g; s/^-+|-+$//g; print substr($_, 0, 40)' "$1"; }
github_of() { git show "$1" 2>/dev/null | sed -n 's/^github: *//p' | head -n 1; }

git fetch -q origin 2>/dev/null   # hors ligne : on continue avec ce qu'on sait

# 1. Profil existant sur main → son nom de fichier fait foi.
slug=
for f in $(git ls-tree --name-only origin/main equipe/ 2>/dev/null); do
  [ "$(github_of "origin/main:$f")" = "$login" ] && slug=$(basename "$f" .md)
done

# 2. Sinon prénom GitHub, sinon pseudo ; nom réservé ou déjà pris → suffixe pseudo.
if [ -z "$slug" ]; then
  name=$(gh api user --jq .name 2>/dev/null)
  slug=$(slugify "${name%% *}")
  [ -n "$slug" ] || slug=$(slugify "$login")
  pris() {
    case "$1" in main|head|rag|app|equipe|docs|scripts) return 0 ;; esac
    o=$(github_of "origin/main:equipe/$1.md"); [ -n "$o" ] && [ "$o" != "$login" ] && return 0
    if git show-ref -q --verify "refs/remotes/origin/$1" && ! git show-ref -q --verify "refs/heads/$1"; then
      [ "$(github_of "origin/$1:equipe/$1.md")" = "$login" ] || return 0
    fi
    return 1
  }
  if pris "$slug" && [ "$slug" != "$(slugify "$login")" ]; then slug="$slug-$(slugify "$login")"; fi
  slug=$(printf '%s' "$slug" | cut -c1-40)
fi

[ "${1:-}" = "--slug" ] && { echo "$slug"; exit 0; }

# 3. Se placer sur la branche.
cur=$(git symbolic-ref -q --short HEAD) || { say "HEAD détachée : je ne change rien. Ta branche : $slug."; exit 0; }
[ "$cur" = "$slug" ] && { say "tu es sur ta branche $slug."; exit 0; }
if [ -n "$(git status --porcelain --ignore-submodules)" ]; then
  say "tu es sur « $cur » avec du travail non commité : je ne change pas de branche. Ta branche : $slug (commite ou range ton travail, puis relance)."
  exit 0
fi
if git show-ref -q --verify "refs/heads/$slug" || git show-ref -q --verify "refs/remotes/origin/$slug"; then
  git switch -q "$slug" && say "bascule sur ta branche $slug (tu étais sur « $cur »)."
else
  git switch -q --no-track -c "$slug" origin/main && say "branche $slug créée depuis main, tu es dessus. /setup la publiera avec ton profil."
fi
exit 0
