package YAML::Old::Dumper::Base;
use strict; use warnings;
use YAML::Old::Base; use base 'YAML::Old::Base';
use YAML::Old::Node;

# YAML::Old Dumping options
field spec_version => '1.0';
field indent_width => 2;
field use_header => 1;
field use_version => 0;
field sort_keys => 1;
field anchor_prefix => '';
field dump_code => 0;
field use_block => 0;
field use_fold => 0;
field compress_series => 1;
field inline_series => 0;
field use_aliases => 1;
field purity => 0;
field stringify => 0;

# Properties
field stream => '';
field document => 0;
field transferred => {};
field id_refcnt => {};
field id_anchor => {};
field anchor => 1;
field level => 0;
field offset => [];
field headless => 0;
field blessed_map => {};

# Global Options are an idea taken from Data::Dumper. Really they are just
# sugar on top of real OO properties. They make the simple Dump/Load API
# easy to configure.
sub set_global_options {
    my $self = shift;
    $self->spec_version($YAML::Old::SpecVersion)
      if defined $YAML::Old::SpecVersion;
    $self->indent_width($YAML::Old::Indent)
      if defined $YAML::Old::Indent;
    $self->use_header($YAML::Old::UseHeader)
      if defined $YAML::Old::UseHeader;
    $self->use_version($YAML::Old::UseVersion)
      if defined $YAML::Old::UseVersion;
    $self->sort_keys($YAML::Old::SortKeys)
      if defined $YAML::Old::SortKeys;
    $self->anchor_prefix($YAML::Old::AnchorPrefix)
      if defined $YAML::Old::AnchorPrefix;
    $self->dump_code($YAML::Old::DumpCode || $YAML::Old::UseCode)
      if defined $YAML::Old::DumpCode or defined $YAML::Old::UseCode;
    $self->use_block($YAML::Old::UseBlock)
      if defined $YAML::Old::UseBlock;
    $self->use_fold($YAML::Old::UseFold)
      if defined $YAML::Old::UseFold;
    $self->compress_series($YAML::Old::CompressSeries)
      if defined $YAML::Old::CompressSeries;
    $self->inline_series($YAML::Old::InlineSeries)
      if defined $YAML::Old::InlineSeries;
    $self->use_aliases($YAML::Old::UseAliases)
      if defined $YAML::Old::UseAliases;
    $self->purity($YAML::Old::Purity)
      if defined $YAML::Old::Purity;
    $self->stringify($YAML::Old::Stringify)
      if defined $YAML::Old::Stringify;
}

sub dump {
    my $self = shift;
    $self->die('dump() not implemented in this class.');
}

sub blessed {
    my $self = shift;
    my ($ref) = @_;
    $ref = \$_[0] unless ref $ref;
    my (undef, undef, $node_id) = YAML::Old::Base->node_info($ref);
    $self->{blessed_map}->{$node_id};
}
    
sub bless {
    my $self = shift;
    my ($ref, $blessing) = @_;
    my $ynode;
    $ref = \$_[0] unless ref $ref;
    my (undef, undef, $node_id) = YAML::Old::Base->node_info($ref);
    if (not defined $blessing) {
        $ynode = YAML::Old::Node->new($ref);
    }
    elsif (ref $blessing) {
        $self->die() unless ynode($blessing);
        $ynode = $blessing;
    }
    else {
        no strict 'refs';
        my $transfer = $blessing . "::yaml_dump";
        $self->die() unless defined &{$transfer};
        $ynode = &{$transfer}($ref);
        $self->die() unless ynode($ynode);
    }
    $self->{blessed_map}->{$node_id} = $ynode;
    my $object = ynode($ynode) or $self->die();
    return $object;
}

1;

__END__

=encoding utf8

=head1 NAME

YAML::Old::Dumper::Base - Base class for YAML::Old Dumper classes

=head1 SYNOPSIS

    package YAML::Old::Dumper::Something;
    use YAML::Old::Dumper::Base -base;

=head1 DESCRIPTION

YAML::Old::Dumper::Base is a base class for creating YAML::Old dumper classes.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006, 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
