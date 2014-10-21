#!/bin/echo This is a perl module and should not be run

package Meta::Math::Matrix;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.15";
@ISA=qw();

#sub new($);
#sub set_size($$);
#sub set_elem($$$);
#sub get_elem($$);
#sub check_pos($$);
#sub print($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{SIZE}=defined;
	return($self);
}

sub set_size($$) {
	my($self,$size)=@_;
	$self->{SIZE}=$size;
}

sub set_elem($$$) {
	my($self,$posx,$elem)=@_;
	$self->check_pos($posx);
	$self->{$posx->get_x(),$posx->get_y()}=$elem;
}

sub get_elem($$) {
	my($self,$posx)=@_;
	$self->check_pos($posx);
	return($self->{$posx->get_x(),$posx->get_y()});
}

sub check_pos($$) {
	my($self,$posx)=@_;
	if($posx->get_x()<0) {
		Meta::Utils::System::die("negative value for x position");
	}
	if($posx->get_x()>=$self->{SIZE}->get_x()) {
		Meta::Utils::System::die("excessive value for x position");
	}
	if($posx->get_y()<0) {
		Meta::Utils::System::die("negative value for y position");
	}
	if($posx->get_y()>=$self->{SIZE}->get_y()) {
		Meta::Utils::System::die("excessive value for y position");
	}
}

sub print($$) {
	my($self,$file)=@_;
	for(my($x)=0;$x<$self->{SIZE}->get_x();$x++) {
		for(my($y)=0;$y<$self->{SIZE}->get_y();$y++) {
			my($posx)=Meta::Geo::Pos2d->new();
			$posx->set_x($x);
			$posx->set_y($y);
			print $file $self->get_elem($posx).",";
		}
		print $file "\n";
	}
}

1;

__END__

=head1 NAME

Meta::Math::Matrix - matrix class.

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

	MANIFEST: Matrix.pm
	PROJECT: meta
	VERSION: 0.15

=head1 SYNOPSIS

	package foo;
	use Meta::Math::Matrix qw();
	my($matrix)=Meta::Math::Matrix->new();
	$matrix->set_size(6,7);
	$matrix->set_elem(5,5,"mark");

=head1 DESCRIPTION

This is a classic matrix. It has a size and makes sure all elements
conform to it.

=head1 FUNCTIONS

	new($)
	set_size($$)
	set_elem($$$)
	get_elem($$)
	check_pos($$)
	print($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This constructs a new matrix.

=item B<set_size($$)>

This will set the size from the matrix.

=item B<set_elem($$$)>

This will set an element in the matrix.

=item B<get_elem($$)>

This will retrieve an element from the matrix.

=item B<check_pos($$)>

This will check that a position is legal.

=item B<print($$)>

This will print out the matrix to a file.

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
	0.13 MV thumbnail project basics
	0.14 MV thumbnail user interface
	0.15 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add check in set_elem that the position received is integral (composed
	of integers). The same goes for set_size and get_elem. Come to think
	of it, why not make a 2d object that inherits from the Geo::Pos2d which
	keeps the values in it integral. Here all you have to do is check
	that the object received is of that class.
