#!/bin/echo This is a perl module and should not be run

package Meta::Info::Affiliation;

use strict qw(vars refs subs);
use Meta::Info::Address qw();
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.08";
@ISA=qw();

#sub BEGIN();
#sub init($);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new_with_init("new");
	Class::MethodMaker->get_set(
		-java=>"_orgname",
		-java=>"_address",
	);
}

sub init($) {
	my($self)=@_;
	$self->set_address(Meta::Info::Address->new());
}

1;

__END__

=head1 NAME

Meta::Info::Affiliation - affiliation information object.

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

	MANIFEST: Affiliation.pm
	PROJECT: meta
	VERSION: 0.08

=head1 SYNOPSIS

	package foo;
	use Meta::Info::Affiliation qw();
	my($object)=Meta::Info::Affiliation->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class provides affiliation information according to the DocBook DTD.

=head1 FUNCTIONS

	BEGIN()
	init($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method sets up the attribute access methods for this
object which are: "orgname" and "address".

=item B<init($)>

This method does instance initialization. It is internal.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging
	0.01 MV PDMT
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV more Class method generation
	0.07 MV thumbnail user interface
	0.08 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-get more info in here and track the Docbook DTD.
