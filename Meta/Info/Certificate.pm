#!/bin/echo This is a perl module and should not be run

package Meta::Info::Certificate;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw();

#sub BEGIN();

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new("new");
	Class::MethodMaker->get_set(
		-java=>"_user_name",
		-java=>"_password",
	);
}

1;

__END__

=head1 NAME

Meta::Info::Certificate - handle a single certificate information.

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

	MANIFEST: Certificate.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Info::Certificate qw();
	my($object)=Meta::Info::Certificate->new();
	my($result)=$object->set_user_name("mark");

=head1 DESCRIPTION

This module handles a single certificate infomation which consists
of a user and a password.

=head1 FUNCTIONS

	BEGIN()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This is the BEGIN block for this module. It creates the modules methods.
The attributes are:
	user_name
	password

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
	0.02 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
