use t::TestYAMLOld tests => 23;

run_roundtrip_nyn();

__DATA__
=== $YAML::UseHeader works
+++ config
local $YAML::UseHeader = 0
+++ perl
(['34', '45'], ['56', '67'])
+++ yaml
- 34
- 45
---
- 56
- 67
=== $YAML::Old::UseHeader overrides $YAML::UseHeader
+++ config
local $YAML::UseHeader = 0;
local $YAML::Old::UseHeader = 1;
+++ perl
(['34', '45'], ['56', '67'])
+++ yaml
---
- 34
- 45
---
- 56
- 67
===
+++ config
local $YAML::Old::UseHeader = 0
+++ perl
(['34', '45'], ['56', '67'])
+++ yaml
- 34
- 45
---
- 56
- 67
===
+++ no_round_trip
+++ config
local $YAML::Old::UseAliases = 0
+++ perl
my $ref = {foo => 'bar'};
[$ref, $ref]
+++ yaml    
---
- foo: bar
- foo: bar
===
+++ config
local $YAML::Old::CompressSeries = 1
+++ perl
[
    {foo => 'bar'},
    {lips => 'red', crown => 'head'},
    {trix => [ 'foo', {silly => 'rabbit', bratty => 'kids', } ] },
]
+++ yaml
---
- foo: bar
- crown: head
  lips: red
- trix:
    - foo
    - bratty: kids
      silly: rabbit
===
+++ config
local $YAML::Old::CompressSeries = 0;
local $YAML::Old::Indent = 5
+++ perl
[
    {one => 'fun', pun => 'none'},
    two => 'foo',
    {three => [ {free => 'willy', dally => 'dilly'} ]},
]
+++ yaml
---
-
     one: fun
     pun: none
- two
- foo
-
     three:
          -
               dally: dilly
               free: willy
===
+++ config
local $YAML::Old::CompressSeries = 1;
local $YAML::Old::Indent = 5
+++ perl
[
    {one => 'fun', pun => 'none'},
    two => {foo => {true => 'blue'}},
    {three => [ {free => 'willy', dally => 'dilly'} ]},
]
+++ yaml
---
- one: fun
  pun: none
- two
- foo:
       true: blue
- three:
       - dally: dilly
         free: willy
===
+++ config
local $YAML::Old::Indent = 3
+++ perl
[{ one => 'two', three => 'four' }, { foo => 'bar' }, ]
+++ yaml
---
- one: two
  three: four
- foo: bar
===
+++ config
local $YAML::Old::CompressSeries = 1
+++ perl
[
    'The',
    {speed => 'quick', color => 'brown', &YAML::Old::VALUE => 'fox'},
    'jumped over the',
    {speed => 'lazy', &YAML::Old::VALUE, 'dog'},
]
+++ yaml
---
- The
- color: brown
  speed: quick
  =: fox
- jumped over the
- speed: lazy
  =: dog
===
+++ config
local $YAML::Old::InlineSeries = 3
+++ perl
[
    ['10', '20', '30'],
    ['foo', 'bar'],
    ['thank', 'god', "it's", 'friday'],
]
+++ yaml
---
- [10, 20, 30]
- [foo, bar]
-
  - thank
  - god
  - it's
  - friday
===
+++ config
local $YAML::Old::SortKeys = [qw(foo bar baz)]
+++ perl
{foo=>'42',bar=>'99',baz=>'4'}
+++ yaml
---
foo: 42
bar: 99
baz: 4
===
+++ perl
{foo => '42', bar => 'baz'}
+++ yaml
---
bar: baz
foo: 42
