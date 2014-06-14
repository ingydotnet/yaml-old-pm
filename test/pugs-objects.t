use strict;
use File::Basename;
use lib dirname(__FILE__);

use TestYAML tests => 2;

{
    no warnings 'once';
    $Foo::Bar::ClassTag = '!pugs/object:Foo::Bar';
    $YAML::Old::TagClass->{'!pugs/object:Foo::Bar'} = 'Foo::Bar';
}

no_diff;
run_roundtrip_nyn('dumper');

__DATA__
=== Turn Perl object to Pugs object
+++ perl: bless { 'a'..'d' }, 'Foo::Bar';
+++ yaml
--- !!pugs/object:Foo::Bar
a: b
c: d
