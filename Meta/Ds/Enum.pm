#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Enum;

use strict qw(vars refs subs);
use Meta::Ds::Oset qw();

our($VERSION,@ISA);
$VERSION="0.22";
@ISA=qw(Meta::Ds::Oset);

#sub get_default($);

#__DATA__

sub get_default($) {
	my($self)=@_;
	return($self->elem(0));
}

1;

__END__

=head1 NAME

Meta::Ds::Enum - Object to store enumeration data.

=head1 COPYRIGHT

Copyright (C) 2001, 2002 Mark Veltzer;
All rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.

=head1 DETAILS

	MANIFEST: Enum.pm
	PROJECT: meta
	VERSION: 0.22

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Enum qw();
	my($pieces)=Meta::Ds::Enum->new();
	$pieces->insert("Pawn");
	$pieces->insert("Rook");
	$pieces->insert("Knight");
	$pieces->insert("Bishop");
	$pieces->insert("King");
	$pieces->insert("Queen");

=head1 DESCRIPTION

This is an object to store a the definition for an enumeration type.

=head1 FUNCTIONS

	get_default($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_default($)>

This gives you the default enumerated value. Currently implemented as the first value
but this needs to be changed.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV add enumerated types to options
	0.01 MV more on tests/more checks to perl
	0.02 MV fix all tests change
	0.03 MV change new methods to have prototypes
	0.04 MV perl code quality
	0.05 MV more perl quality
	0.06 MV more perl quality
	0.07 MV get basic Simul up and running
	0.08 MV perl documentation
	0.09 MV more perl quality
	0.10 MV perl qulity code
	0.11 MV more perl code quality
	0.12 MV revision change
	0.13 MV languages.pl test online
	0.14 MV perl packaging
	0.15 MV md5 project
	0.16 MV database
	0.17 MV perl module versions in files
	0.18 MV movies and small fixes
	0.19 MV graph visualization
	0.20 MV more thumbnail code
	0.21 MV thumbnail user interface
	0.22 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-make this object be able to read itself from an XML file.
