#!/bin/echo This is a perl module and should not be run

package Meta::Geo::Pos3d;

use strict qw(vars refs subs);
use Class::MethodMaker qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.03";
@ISA=qw();

#sub BEGIN($);
#sub add($$);
#sub sub($$);
#sub mul($$);
#sub print($$);
#sub TEST();

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new("new");
	Class::MethodMaker->get_set(
		-java=>"_x",
		-java=>"_y",
		-java=>"_z",
	);
}

sub add($$) {
	my($self,$other)=@_;
	$self->set_x($self->get_x()+$other->get_x());
	$self->set_y($self->get_y()+$other->get_y());
	$self->set_z($self->get_z()+$other->get_z());
}

sub sub($$) {
	my($self,$other)=@_;
	$self->set_x($self->get_x()-$other->get_x());
	$self->set_y($self->get_y()-$other->get_y());
	$self->set_z($self->get_z()-$other->get_z());
}

sub mul($$) {
	my($self,$valx)=@_;
	$self->set_x($self->get_x()*$valx);
	$self->set_y($self->get_y()*$valx);
	$self->set_z($self->get_z()*$valx);
}

sub print($$) {
	my($self,$file)=@_;
	print $file "[".$self->get_x()."][".$self->get_y()."][".$self->get_z()."]\n";
}

sub TEST() {
	my($point1)=Meta::Geo::Pos3d->new();
	$point1->set_x(3);
	$point1->set_y(4);
	$point1->set_z(5);
	my($point2)=Meta::Geo::Pos3d->new();
	$point2->set_x(5);
	$point2->set_y(6);
	$point2->set_z(7);
	$point1->add($point2);
	$point1->print(Meta::Utils::Output::get_file());
	return(1);
}

1;

__END__

=head1 NAME

Meta::Geo::Pos3d - a 3d position.

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

	MANIFEST: Pos3d.pm
	PROJECT: meta
	VERSION: 0.03

=head1 SYNOPSIS

	package foo;
	use Meta::Geo::Pos3d qw();
	my($position)=Meta::Geo::Pos3d->new();
	$position->set_x(3.14);
	$position->set_y(2.17);
	$position->set_z(0.16);
	$position->mul(0.5);

=head1 DESCRIPTION

This is a 3-dimentional position object.
It can print itself.
It knows how to do basic arithmetic.
A lot more is needed here but it's a start.

=head1 FUNCTIONS

	BEGIN()
	add($$)
	sub($$)
	mul($$)
	print($$)
	TEST()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This sets up the module with accessor functions to the x,y and z attributes.

=item B<add($$)>

This will add a position to the current positions.

=item B<sub($$)>

This will subtract a position from the current positions.

=item B<mul($$)>

This will multiple the vector by a scalar.

=item B<print($$)>

This will print the current position.

=item B<TEST()>

Performs unit testing for this module.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV thumbnail project basics
	0.01 MV thumbnail user interface
	0.02 MV import tests
	0.03 MV more thumbnail issues

=head1 SEE ALSO

L<Class::MethodMaker>,L<Meta::Utils::Output>

=head1 TODO

Nothing.
