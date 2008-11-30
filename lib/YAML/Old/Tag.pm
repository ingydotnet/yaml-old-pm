package YAML::Old::Tag;
use strict; use warnings;

use overload '""' => sub { ${$_[0]} };

sub new {
    my ($class, $self) = @_;
    bless \$self, $class
}

sub short {
    ${$_[0]}
}

sub canonical {
    ${$_[0]}
}

1;

__END__

=encoding utf8

=head1 NAME

YAML::Old::Tag - Tag URI object class for YAML::Old

=head1 SYNOPSIS

    use YAML::Old::Tag;

=head1 DESCRIPTION

Used by YAML::Old::Node.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006, 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
