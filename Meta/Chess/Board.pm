#!/bin/echo This is a perl module and should not be run

package Meta::Chess::Board;

use strict qw(vars refs subs);
use Meta::Math::Matrix qw();
use Meta::Geo::Pos2d qw();

our($VERSION,@ISA);
$VERSION="0.14";
@ISA=qw(Meta::Math::Matrix);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Math::Matrix->new();
	bless($self,$clas);
	my($posx)=Meta::Geo::Pos2d->new();
	$posx->set(8,8);
	$self->set_size($posx);
	return($self);
}

1;

__END__

=head1 NAME

Meta::Chess::Board - a chess board.

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

	MANIFEST: Board.pm
	PROJECT: meta
	VERSION: 0.14

=head1 SYNOPSIS

	package foo;
	use Meta::Chess::Board qw();
	my($object)=Meta::Chess::Board->new();

=head1 DESCRIPTION

This class encapsulates a chess board.

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is the construction for the Board object.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV chess and code quality
	0.01 MV more perl quality
	0.02 MV perl documentation
	0.03 MV more perl quality
	0.04 MV perl qulity code
	0.05 MV more perl code quality
	0.06 MV revision change
	0.07 MV languages.pl test online
	0.08 MV perl packaging
	0.09 MV md5 project
	0.10 MV database
	0.11 MV perl module versions in files
	0.12 MV movies and small fixes
	0.13 MV thumbnail user interface
	0.14 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
