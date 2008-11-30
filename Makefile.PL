use inc::Module::Install;

name            'YAML-Old';
all_from        'lib/YAML/Old.pm';

use_test_base;

install_script  'ysh';

WriteAll;
