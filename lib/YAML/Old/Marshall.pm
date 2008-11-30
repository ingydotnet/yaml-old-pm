package YAML::Old::Marshall;
use strict; use warnings;
use YAML::Old::Node();

sub import {
    my $class = shift;
    no strict 'refs';
    my $package = caller;
    unless (grep { $_ eq $class} @{$package . '::ISA'}) {
        push @{$package . '::ISA'}, $class;
    }

    my $tag = shift;
    if ($tag) {
        no warnings 'once';
        $YAML::Old::TagClass->{$tag} = $package;
        ${$package . "::YamlTag"} = $tag;
    }
}

sub yaml_dump {
    my $self = shift;
    no strict 'refs';
    my $tag = ${ref($self) . "::YamlTag"} || 'perl/' . ref($self);
    $self->yaml_node($self, $tag);
}

sub yaml_load {
    my ($class, $node) = @_;
    if (my $ynode = $class->yaml_ynode($node)) {
        $node = $ynode->{NODE};
    }
    bless $node, $class;
}

sub yaml_node {
    shift;
    YAML::Old::Node->new(@_);
}

sub yaml_ynode {
    shift;
    YAML::Old::Node::ynode(@_);
}

1;

__END__

=encoding utf8

=head1 NAME

YAML::Old::Marshall - YAML::Old marshalling class you can mixin to your classes

=head1 SYNOPSIS

    package Bar;
    use Foo -base;
    use YAML::Old::Marshall -mixin;

=head1 DESCRIPTION

For classes that want to handle their own YAML serialization.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006, 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
