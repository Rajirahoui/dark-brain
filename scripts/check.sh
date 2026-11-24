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

# Liens markdown relatifs : la cible doit exister AVEC LA BONNE CASSE (GitHub y est sensible, macOS et Windows non).
# On compare à la liste git (fichiers + dossiers), on ignore le code (blocs ``` / ~~~ et `…`), on décode %XX,
# on coupe ?query et #ancre. Hors rag/ (sous-module privé) et docs/superpowers/ (historique).
# perl : présent sous macOS et dans Git for Windows.
links_ko() {
  git -c core.quotepath=off ls-files -co --exclude-standard -- . ':(exclude)rag' | perl -e '
    my (@files, %have);
    while (<STDIN>) { chomp; push @files, $_; my $d = $_; $have{$d} = 1; $have{$d} = 1 while $d =~ s{/[^/]+$}{}; }
    for my $md (grep { /\.md$/ && !m{^docs/superpowers/} } @files) {
      open my $fh, "<", $md or next; local $/; my $t = <$fh>; close $fh;
      $t =~ s/^(```|~~~).*?^\1[^\n]*$//gms; $t =~ s/`[^`\n]*`//g;
      (my $dir = $md) =~ s{/?[^/]+$}{};
      while ($t =~ /\]\(\s*(?:<([^>]+)>|((?:[^()\s]|\([^()\s]*\))+))/g) {
        my $l = defined $1 ? $1 : $2; my $p = $l;
        next if $p =~ m{^(?:[a-z][a-z0-9+.-]*:|#)}i;
        $p =~ s/[?#].*//s; next if $p eq "";
        $p =~ s/%([0-9A-Fa-f]{2})/chr(hex $1)/ge;
        my @out;
        for my $c (split m{/}, ($p =~ m{^/} ? $p : "$dir/$p")) {
          next if $c eq "" || $c eq ".";
          if ($c eq "..") { pop @out } else { push @out, $c }
        }
        my $n = join "/", @out;
        next if $n eq "rag" || $n =~ m{^rag/};
        print "KO $md : lien cassé → $l\n" unless $have{$n};
      }
    }'
}
broken=$(links_ko)
if [ -n "$broken" ]; then echo "$broken"; fail=1; fi

[ "$fail" -eq 0 ] && echo "OK : garde-fou passé"
exit "$fail"
