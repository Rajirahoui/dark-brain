#!/usr/bin/env bash
# Teste scripts/check.sh dans un repo jetable (les fixtures sont générées, jamais écrites en clair ici).
set -u
here=$(cd "$(dirname "$0")" && pwd)
ko=0
run() { bash scripts/check.sh >/dev/null 2>&1; echo $?; }
expect() { if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FAIL $1 (attendu $2, obtenu $3)"; ko=1; fi; }

# Windows (autocrlf) ne doit jamais convertir les scripts en CRLF.
expect "check.sh forcé en LF" "eol: lf" "$(cd "$here/.." && git check-attr eol -- scripts/check.sh | sed 's/^[^:]*: //')"

t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
cd "$t" && git init -q && mkdir -p scripts .githooks && cp "$here/check.sh" scripts/ 2>/dev/null
cp "$here/../.githooks/pre-push" .githooks/ 2>/dev/null

echo propre > a.txt; git add a.txt
expect "repo propre passe" 0 "$(run)"

printf '0%s 12 34 56 78\n' 6 > b.txt; git add b.txt
expect "téléphone bloqué" 1 "$(run)"; git rm -qf b.txt

printf 'prenom.nom%sexemple.fr\n' @ > c.txt; git add c.txt
expect "e-mail bloqué" 1 "$(run)"; git rm -qf c.txt

printf '0%s 12 34 56 78\n' 6 > u.txt
expect "fuite dans un fichier non suivi bloquée" 1 "$(run)"; rm -f u.txt

mkdir -p .claude/skills/foo
printf -- '---\nname: bar\ndescription: x\n---\n' > .claude/skills/foo/SKILL.md; git add -A
expect "skill au mauvais nom bloqué" 1 "$(run)"

printf -- '---\nname: foo\ndescription: x\n---\n' > .claude/skills/foo/SKILL.md; git add -A
expect "skill valide passe" 0 "$(run)"

# Le hook pre-push bloque une fuite même poussée à la main (hors /sync).
c() { git -c user.name=test -c user.email=test@test commit -qm "$1"; }
git init -q --bare "$t/remote.git" && git remote add origin "$t/remote.git" && git config core.hooksPath .githooks
git add -A && c init
printf '0%s 11 22 33 44\n' 7 > e.txt; git add e.txt && c fuite
git push -q origin HEAD:refs/heads/x >/dev/null 2>&1; expect "pre-push bloque une fuite" 1 "$?"
git rm -qf e.txt && c nettoyage
git push -q origin HEAD:refs/heads/x >/dev/null 2>&1; expect "pre-push laisse passer un repo propre" 0 "$?"

exit $ko
