YAML to YAML::Old Transition
============================

You are probably reading this because a Perl 5 YAML.pm error message told you
to. Welcome.

-- Ingy and Tina, May 2017

## SHORT ANSWER

If you were using a `YAML::<name>` module, you probably need to change it to
`YAML::Old::<name>`.

If you were just using the `YAML` module itself, you probably found a bug.

Please report all issues/concerns: https://github.com/ingydotnet/yaml-pm/issues

## MEDIUM ANSWER

The YAML distribution has moved to YAML-Old on CPAN. A new YAML distribution
has a YAML.pm that (in the default case) loads and delegates to YAML::Old.
Therefore, unless you are doing something directly with the `YAML::*`
submodules, everything should work as before.

Normal YAML usage should JustWork and continue to for a long time.

The YAML distribution is old and buggy, but it works just fine for many people,
and actually switching to another YAML module might break your codebase.

If you know that you always want the Old YAML forever, you can just `use
YAML::Old` directly.

## LONGER ANSWER

The YAML distribution and YAML.pm module are becoming a front end API usage
module for all the YAML backends.

Old invocations of `use YAML` like these:
```perl
use YAML;
use YAML 'Load';
use YAML qw(LoadFile DumpFile);
use YAML qw(Load Dump freeze thaw DumpFile LoadFile Bless Blessed);
```

will continue to work as before because YAML will require YAML::Old and simply
invoke the old functionality.

New invocations (TBD; might look like this):
```perl
use YAML -api;
use YAML 'yaml';
use YAML -libyaml;
use YAML -old;
```

Will use the new YAML and YAML::API modules along with the various backends,
options, and APIs.

## Specific Details

These modules are no longer usable directly:
```
YAML::Dumper
YAML::Dumper::Base
YAML::Error
YAML::Loader
YAML::Loader::Base
YAML::Marshall
YAML::Mo
YAML::Node
YAML::Tag
YAML::Types
```

Use the `YAML::Old::*` versions instead.

YAML::Any is still in the YAML distribution and is unchanged. It may be
deprecated. We are still thinking it over.

## Support

This is a big change in Perl 5's YAML development. We want to continue using
the obvious YAML namespace, while not breaking (much) the widespread existing
usage.

If you strongly disagree with any of this approach, please reach out to INGY or
TINITA via:

* GitHub issues
* Email
* IRC (freenode #yaml)

Cheers, The Perl YAML Team
