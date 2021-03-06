use strict;
use warnings;

use Test::More tests => 1;

my $success = 0;
my $err;
{
    local $@;
    eval {
        require YAML::Old::Dumper;
        my $hash   = {};
        my $dumper = YAML::Old::Dumper->new();
        my $string = $dumper->dump($hash);
        $success = 1;
    };
    $err = $@;
}
is( $success, 1, "Basic YAML::Old::Dumper usage worked as expected" )
  or diag( explain($err) );

