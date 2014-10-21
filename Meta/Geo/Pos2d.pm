#!/bin/echo This is a perl module and should not be run

package Meta::Geo::Pos2d;

use strict qw(vars refs subs);
use Meta::Class::MethodMaker qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.19";
@ISA=qw();

#sub BEGIN($);
#sub add($$);
#sub sub($$);
#sub mul($$);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_x",
		-java=>"_y",
	);
	Meta::Class::MethodMaker->print(["x","y"]);
}

sub add($$) {
	my($self,$other)=@_;
	$self->set_x($self->get_x()+$other->get_x());
	$self->set_y($self->get_y()+$other->get_y());
}

sub sub($$) {
	my($self,$other)=@_;
	$self->set_x($self->get_x()-$other->get_x());
	$self->set_y($self->get_y()-$other->get_y());
}

sub mul($$) {
	my($self,$valx)=@_;
	$self->set_x($self->get_x()*$valx);
	$self->set_y($self->get_y()*$valx);
}

sub TEST($) {
	my($context)=@_;
	my($point1)=Meta::Geo::Pos2d->new();
	$point1->set_x(3);
	$point1->set_y(4);
	my($point2)=Meta::Geo::Pos2d->new();
	$point2->set_x(5);
	$point2->set_y(6);
	$point1->add($point2);
	$point1->print(Meta::Utils::Output::get_file());
	return(1);
}

1;

__END__

=head1 NAME

Meta::Geo::Pos2d - a 2d position.

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

	MANIFEST: Pos2d.pm
	PROJECT: meta
	VERSION: 0.19

=head1 SYNOPSIS

	package foo;
	use Meta::Geo::Pos2d qw();
	my($position)=Meta::Geo::Pos2d->new();
	$position->set_x(3.14);
	$position->set_y(2.17);
	$position->mul(0.5);

=head1 DESCRIPTION

This is a 2-dimentional position object.
It can print itself.
It knows how to do basic arithmetic.
A lot more is needed here but it's a start.

=head1 FUNCTIONS

	BEGIN()
	add($$)
	sub($$)
	mul($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This sets up the module with accessor functions to the x and y attributes.

=item B<add($$)>

This will add a position to the current positions.

=item B<sub($$)>

This will subtract a position from the current positions.

=item B<mul($$)>

This will multiple the vector by a scalar.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.15 MV import tests
	0.16 MV more thumbnail issues
	0.17 MV website construction
	0.18 MV web site automation
	0.19 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Class::MethodMaker(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
