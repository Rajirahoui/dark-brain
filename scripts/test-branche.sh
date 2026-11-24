#!/usr/bin/env bash
# Teste scripts/branche.sh dans un repo jetable, avec un faux `gh` (aucun appel réseau).
set -u
here=$(cd "$(dirname "$0")" && pwd)
t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
ko=0
expect() { if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FAIL $1 (attendu « $2 », obtenu « $3 »)"; ko=1; fi; }
c() { git -c user.name=test -c user.email=test@test commit -qm "$1"; }

# Faux gh : répond seulement aux deux questions que pose branche.sh.
mkdir -p "$t/bin"
cat > "$t/bin/gh" <<'EOF'
#!/bin/sh
case "$*" in
  "api user --jq .login") echo "$FAKE_LOGIN" ;;
  "api user --jq .name") echo "$FAKE_NAME" ;;
esac
EOF
chmod +x "$t/bin/gh"
export PATH="$t/bin:$PATH"

# Remote avec un main minimal, puis un clone de travail.
git init -q --bare "$t/remote.git"
git clone -q "$t/remote.git" "$t/seed" 2>/dev/null
( cd "$t/seed" && git switch -q -c main && mkdir -p equipe scripts && touch equipe/.gitkeep \
  && cp "$here/branche.sh" scripts/ 2>/dev/null; git add -A && c init && git push -q origin main )
git -C "$t/remote.git" symbolic-ref HEAD refs/heads/main
git clone -q "$t/remote.git" "$t/w"
cd "$t/w" || exit 1
export CLAUDE_PROJECT_DIR="$t/w"
run() { bash scripts/branche.sh "$@" 2>&1; }
cur() { git symbolic-ref --short HEAD; }

export FAKE_LOGIN=lea99 FAKE_NAME="Léa-Marie Dupont"
expect "slug depuis le prénom GitHub" "lea-marie" "$(run --slug)"
FAKE_NAME="" expect "slug depuis le pseudo si pas de nom" "lea99" "$(FAKE_NAME= run --slug)"
expect "nom réservé suffixé par le pseudo" "main-lea99" "$(FAKE_NAME=Main run --slug)"

run >/dev/null; expect "crée et active sa branche depuis main" "lea-marie" "$(cur)"
case "$(run)" in *"ta branche lea-marie"*) r=oui ;; *) r=non ;; esac
expect "déjà sur sa branche : le dit" "oui" "$r"

git switch -q main; echo brouillon > brouillon.txt
run >/dev/null; expect "travail non commité : ne change pas de branche" "main" "$(cur)"
rm -f brouillon.txt

( cd "$t/seed" && printf -- '---\nprenom: Noé\ngithub: lea99\n---\n' > equipe/noe.md \
  && printf -- '---\nprenom: Autre\ngithub: autre42\n---\n' > equipe/sam.md && git add -A && c profils && git push -q origin main )
git fetch -q origin
expect "le profil existant prime sur le nom" "noe" "$(run --slug)"
expect "prénom déjà pris par un autre : suffixe pseudo" "sam-zoe7" "$(FAKE_LOGIN=zoe7 FAKE_NAME=Sam run --slug)"

exit $ko
