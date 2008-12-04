use t::TestYAMLOld tests => 1;

my $node_from_yaml = LoadFile('./META.yml');
my $node_from_perl = eval(join '', <DATA>);
die $@ if $@;

$node_from_yaml->{version} =
$node_from_perl->{version} =
$YAML::Old::VERSION;

is_deeply $node_from_yaml, $node_from_perl,
    'Make sure we can load META.yml files used by CPAN';

__DATA__
{
  'no_index' => {
                  'directory' => [
                                   'inc',
                                   't'
                                 ]
                },
  'generated_by' => 'Module::Install version 0.75',
  'distribution_type' => 'module',
  'version' => '0.80',
  'name' => 'YAML-Old',
  'author' => ['Ingy döt Net <ingy@cpan.org>'],
  'license' => 'perl',
  'requires' => {
                  'perl' => '5.6.1',
                  'Filter::Util::Call' => '0',
                },
  'abstract' => 'Old/Classic Perl YAML Module',
  'meta-spec' => {
    'url' => 'http://module-build.sourceforge.net/META-spec-v1.3.html',
    'version' => '1.3',
  },
};
