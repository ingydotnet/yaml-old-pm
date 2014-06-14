use strict;
use File::Basename;
use lib dirname(__FILE__);

use lib 'inc';
use Test::YAML();
BEGIN {
    @Test::YAML::EXPORT =
        grep { not /^(Dump|Load)(File)?$/ } @Test::YAML::EXPORT;
}
use TestYAML tests => 9;

use YAML::Old qw(Dump Load freeze thaw);

my $hash = { foo => 42, bar => 44 };

my $ice = freeze($hash);

ok defined(&Dump), 'Dump exported';
ok defined(&Load), 'Load exported';
ok defined(&freeze), 'freeze exported';
ok defined(&thaw), 'thaw exported';

like $ice, qr{bar.*foo}s, 'freeze works';

is $ice, Dump($hash), 'freeze produces same thing as Dump';

my $melt = thaw($ice);

is_deeply $melt, Load($ice), 'thaw produces same thing as Load';

is_deeply $melt, $hash, 'freeze/thaw makes a clone';

is ref($melt), 'HASH', 'Melted object really is a hash';