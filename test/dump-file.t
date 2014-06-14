use strict;
use File::Basename;
use lib dirname(__FILE__);

my $testdir = -e 'test' ? 'test' : 't';

use lib 'inc';
use Test::YAML();
BEGIN {
    @Test::YAML::EXPORT =
        grep { not /^(Dump|Load)(File)?$/ } @Test::YAML::EXPORT;
}
use TestYAML tests => 3;

use YAML::Old 'DumpFile';

ok defined &DumpFile,
    'Dumpfile exported';

my $file = "$testdir/dump-file-$$.yaml";

DumpFile($file, [1..3]);

ok -e $file,
    'Output file exists';

open IN, $file or die $!;
my $yaml = join '', <IN>;
close IN;

is $yaml, <<'...', 'DumpFile YAML is correct';
---
- 1
- 2
- 3
...

unlink $file;
