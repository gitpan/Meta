#!/bin/echo This is a perl module and should not be run

package Meta::Chess::Move;

use strict qw(vars refs subs);
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.14";
@ISA=qw();

#sub new($);
#sub set($$$);
#sub get_from($);
#sub get_to($);
#sub set_coronation($$);
#sub get_coronation($);
#sub set_coronation_piece($$);
#sub get_coronation_piece($);
#sub set_small_castle($$);
#sub get_small_castle($);
#sub set_large_castle($$);
#sub get_large_castle($);
#sub print($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{FROM}=defined;
	$self->{TO}=defined;
	$self->{CORONATION}=0;
	$self->{CORONATION_PIECE}=defined;
	$self->{SMALL_CASTLE}=0;
	$self->{LARGE_CASTLE}=0;
	return($self);
}

sub set($$$) {
	my($self,$from,$to)=@_;
	$self->{FROM}=$from;
	$self->{TO}=$to;
}

sub get_from($) {
	my($self)=@_;
	return($self->{FROM});
}

sub get_to($) {
	my($self)=@_;
	return($self->{TO});
}

sub set_coronation($$) {
	my($self,$valx)=@_;
	if($self->get_to()->get_y() ne "7" && $self->get_to()->get_y() ne "0") {
		Meta::Utils::System::die("problem with coronation");
	}
	$self->{CORONATION}=$valx;
}

sub get_coronation($) {
	my($self)=@_;
	return($self->{CORONATION});
}

sub set_coronation_piece($$) {
	my($self,$piece)=@_;
	if(!$self->get_coronation()) {
		Meta::Utils::System::die("cannot set coronation piece with no coronation");
	}
	$self->{CORONATION_PIECE}=$piece;
}

sub get_coronation_piece($) {
	my($self)=@_;
	return($self->{CORONATION_PIECE});
}

sub set_small_castle($$) {
	my($self,$valx)=@_;
	$self->{SMALL_CASTLE}=$valx;
}

sub get_small_castle($) {
	my($self)=@_;
	return($self->{SMALL_CASTLE});
}

sub set_large_castle($$) {
	my($self,$valx)=@_;
	$self->{LARGE_CASTLE}=$valx;
}

sub get_large_castle($) {
	my($self)=@_;
	return($self->{LARGE_CASTLE});
}

sub print($$) {
	my($self,$file)=@_;
	if($self->get_small_castle()) {
		print $file "0-0";
		return;
	}
	if($self->get_large_castle()) {
		print $file "0-0-0";
		return;
	}
	$self->get_to()->print($file);
	if($self->get_coronation()) {
		print $file "=".Meta::Chess::Piece::get_shortcut($self->get_coronation_piece());
	}
}

1;

__END__

=head1 NAME

Meta::Chess::Move - object that describes a chess move.

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

	MANIFEST: Move.pm
	PROJECT: meta
	VERSION: 0.14

=head1 SYNOPSIS

	package foo;
	use Meta::Chess::Move qw();
	my($move)=Meta::Chess::Move->new();
	$move->set($pos1,$pos2);

=head1 DESCRIPTION

This object is a chess move. It has the piece doing the move and the parameters
of the move.

=head1 FUNCTIONS

	new($)
	set($$$)
	get_from($)
	get_to($)
	set_coronation($$)
	get_coronation($)
	set_coronation_piece($$)
	get_coronation_piece($)
	set_small_castle($$)
	get_small_castle($)
	set_large_castle($$)
	get_large_castle($)
	print($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This constructs a move object.

=item B<set($$$)>

This sets all the moves parameters.

=item B<get_from($)>

This will give you the position from which the move starts.

=item B<get_to($)>

This will give you the position at which the move ends.

=item B<set_coronation($$)>

This sets the moves coronation parameter.

=item B<get_coronation($)>

This will let you have the information if were talking about coronation.

=item B<set_coronation_piece($$)>

This will set the piece that the coronation produces.

=item B<get_coronation_piece($)>

This will give you the piece that the coronation produces.

=item B<set_small_castle($$)>

This will set the small castle parameter.

=item B<get_small_castle($)>

This will give you the small castle parameter.

=item B<set_large_castle($$)>

This will set the large castle parameter.

=item B<get_large_castle($)>

This will give you the large castle parameter.

=item B<print($$)>

This will print the move.

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
