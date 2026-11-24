#!/usr/bin/env bash
# Teste scripts/check.sh dans un repo jetable (les fixtures sont générées, jamais écrites en clair ici).
set -u
here=$(cd "$(dirname "$0")" && pwd)
t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
cd "$t" && git init -q && mkdir -p scripts && cp "$here/check.sh" scripts/ 2>/dev/null
ko=0
run() { bash scripts/check.sh >/dev/null 2>&1; echo $?; }
expect() { if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FAIL $1 (attendu $2, obtenu $3)"; ko=1; fi; }

echo propre > a.txt; git add a.txt
expect "repo propre passe" 0 "$(run)"

printf '0%s 12 34 56 78\n' 6 > b.txt; git add b.txt
expect "téléphone bloqué" 1 "$(run)"; git rm -qf b.txt

printf 'prenom.nom%sexemple.fr\n' @ > c.txt; git add c.txt
expect "e-mail bloqué" 1 "$(run)"; git rm -qf c.txt

mkdir -p .claude/skills/foo
printf -- '---\nname: bar\ndescription: x\n---\n' > .claude/skills/foo/SKILL.md; git add -A
expect "skill au mauvais nom bloqué" 1 "$(run)"

printf -- '---\nname: foo\ndescription: x\n---\n' > .claude/skills/foo/SKILL.md; git add -A
expect "skill valide passe" 0 "$(run)"

exit $ko
