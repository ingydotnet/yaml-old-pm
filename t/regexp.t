use t::TestYAMLOld tests => 11;
use YAML::Old();
no warnings 'once';

my @blocks = blocks;

my $block = $blocks[0];

$YAML::Old::UseCode = 1;
my $hash = YAML::Old::Load($block->yaml);
is $hash->{key}, '(?m-xis:foo$)', 'Regexps load';
is YAML::Old::Dump(eval $block->perl), <<'...', 'Regexps dump';
---
key: !!perl/regexp (?m-xis:foo$)
...

my $re = $hash->{key};

is ref($re), 'Regexp', 'The regexp is a Regexp';
 
like "Hello\nBarfoo", $re, 'The regexp works';

#-------------------------------------------------------------------------------

$block = $blocks[1];

$hash = YAML::Old::Load($block->yaml);
is $hash->{key}, '(?m-xis:foo$)', 'Regexps load';

# XXX Dumper can't detect a blessed regexp

# is YAML::Old::Dump(eval $block->perl), <<'...', 'Regexps dump';
# ---
# key: !!perl/regexp (?m-xis:foo$)
# ...

$re = $hash->{key};

is ref($re), 'Classy', 'The regexp is a Classy :(';
 
# XXX Test more doesn't think a blessed regexp is a regexp (for like)

# like "Hello\nBarfoo", $re, 'The regexp works';
ok(("Hello\nBarfoo" =~ $re), 'The regexp works');

#-------------------------------------------------------------------------------

$block = $blocks[2];

$hash = YAML::Old::Load($block->yaml);
is $hash->{key}, '(?-xism:foo$)', 'Regexps load';

is YAML::Old::Dump(eval $block->perl), <<'...', 'Regexps dump';
---
key: !!perl/regexp (?-xism:foo$)
...

$re = $hash->{key};

is ref($re), 'Regexp', 'The regexp is a Regexp';
 
like "Barfoo", $re, 'The regexp works';


__END__
=== A regexp with flag 
+++ yaml
---
key: !!perl/regexp (?m-xis:foo$)
+++ perl
+{key => qr/foo$/m}

=== A blessed rexexp
+++ yaml
---
key: !!perl/regexp:Classy (?m-xis:foo$)
+++ perl
+{key => bless(qr/foo$/m, 'Classy')}

=== A regexp with no flag 
+++ yaml
---
key: !!perl/regexp (?-xism:foo$)
+++ perl
+{key => qr/foo$/}

