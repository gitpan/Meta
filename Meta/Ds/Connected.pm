#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Connected;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.09";
@ISA=qw();

#sub BEGIN();

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new("new");
	Class::MethodMaker->get_set(
		-java=>"_container",
	);
}

1;

__END__

=head1 NAME

Meta::Ds::Connected - a baseclass for children of a data strcuture.

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

	MANIFEST: Connected.pm
	PROJECT: meta
	VERSION: 0.09

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Connected qw();
	my($object)=Meta::Ds::Connected->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Any object that wants to be connected to its container can inherit from
this class, use a container that connects it whenever its inserted into
one and get its container using get_container.

=head1 FUNCTIONS

	BEGIN()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method will create the get/set method for the following attributes:
"container".

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV db stuff
	0.01 MV perl packaging
	0.02 MV PDMT
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV more thumbnail stuff
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
