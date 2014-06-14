use strict;
use File::Basename;
use lib dirname(__FILE__);

# This simply tests that a given piece of invalid YAML fails to parse
use TestYAML tests => 4;

filters {
    msg => 'regexp',
    yaml => 'yaml_load_or_fail',
};

run_like yaml => 'msg';

__DATA__

===
+++ SKIP
This test hangs YAML.pm
+++ msg
YAML Error: Inconsistent indentation level
+++ yaml
a: *


===
+++ msg
YAML Error: Inconsistent indentation level
+++ yaml
--- |\
foo\zbar


===
+++ msg
YAML Error: Unrecognized implicit value
+++ yaml
--- @ 42


===
+++ msg
YAML Error: Inconsistent indentation level
+++ yaml
---
 - 1
  -2


===
+++ msg
Unrecognized TAB policy
+++ yaml
--- #TAB:MOBY
- foo

