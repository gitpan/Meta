#!/bin/echo This is a perl module and should not be run

package Meta::Chess::Piece;

use strict qw(vars refs subs);
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.14";
@ISA=qw();

#sub new($);
#sub set_name($$);
#sub get_name($);
#sub get_shortcut($);

#__DATA__

my($piece_hash);

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Array->new();
	bless($self,$clas);
	$self->{NAME}=defined;
	return($self);
}

sub set_name($$) {
	my($self,$name)=@_;
	if(!exists($piece_hash->{$name})) {
		Meta::Utils::System::die("what kind of piece is [".$name."]");
	}
	$self->{NAME}=$name;
}

sub get_name($) {
	my($self)=@_;
	return($self->{NAME});
}

sub get_shortcut($) {
	my($self)=@_;
	return($piece_hash->{$self->get_name()});
}

BEGIN {
	$piece_hash->{"Pawn"}="";
	$piece_hash->{"Rook"}="R";
	$piece_hash->{"Knight"}="N";
	$piece_hash->{"Bishop"}="B";
	$piece_hash->{"King"}="K";
	$piece_hash->{"Queen"}="Q";
}

1;

__END__

=head1 NAME

Meta::Chess::Piece - this is a chess piece.

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

	MANIFEST: Piece.pm
	PROJECT: meta
	VERSION: 0.14

=head1 SYNOPSIS

	package foo;
	use Meta::Chess::Piece qw();
	my($object)=Meta::Chess::Piece->new();
	my($result)=$object->set("Queen");

=head1 DESCRIPTION

This is a chess piece. It can be one of the following:
Pawn,Rook,Knight,Bishop,Queen,King.
It knows how to shortcut the names of these pieces for notation.
It sanity checks the names that are received.

=head1 FUNCTIONS

	new($)
	set_name($$)
	get_name($)
	get_shortcut($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<$piece_hash>

This hash holds the valid piece names and their shortcuts.

=item B<new($)>

This is the construction for the Piece.pm object.

=item B<set_name($$)>

This will set the name of the piece for you.

=item B<get_name($)>

This will give you the name of the current piece.

=item B<get_shortcut($)>

This will give you the shortcut for the current piece.

=item B<BEGIN>

This is the BEGIN block where we initialize the sanity/shortcut hash.

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
