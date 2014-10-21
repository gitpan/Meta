#!/bin/echo This is a perl module and should not be run

package Meta::Development::Link;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.09";
@ISA=qw();

#sub BEGIN();
#sub init($);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new_with_init("new");
	Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_description",
		-java=>"_longdescription",
		-java=>"_version",
		-java=>"_platforms",
		-java=>"_objects",
		-java=>"_libraries",
		-java=>"_elibraries",
	);
}

sub init($) {
	my($self)=@_;
	$self->set_platforms(Meta::Ds::Array->new());
	$self->set_objects(Meta::Ds::Array->new());
	$self->set_libraries(Meta::Ds::Array->new());
	$self->set_elibraries(Meta::Ds::Array->new());
}

1;

__END__

=head1 NAME

Meta::Development::Link - link information for a single target object.

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

	MANIFEST: Link.pm
	PROJECT: meta
	VERSION: 0.09

=head1 SYNOPSIS

	package foo;
	use Meta::Development::Link qw();
	my($link)=Meta::Development::Link->new();
	$link->set_name("gcc");
	$link->set_description("C compiler");
	$link->set_longdescription("very good C compiler");
	$link->set_version("3.01");

=head1 DESCRIPTION

This object carries all the information neccessary in order to
link a single binary object (binary, archive or dll).
The data includes:
0. The object files participating in the link.
1. The project internal libraries participating in the link and their
respective versions.
2. The project external libraries participating in the link and their
respective versions.
3. The version that needs to be given to the result.
4. The platforms on which this targets needs to be linked.

This object is used by other objects in the Meta system but you may
use it on it's own for whatever purpose. In Meta it is used to hold
the data about a needed link opt and supply it to various tools that
know how to create the target from this data.

=head1 FUNCTIONS

	BEGIN()
	init($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method creates the accessor methods needed to access the attributes of this
class. The attributes are: "name", "description", "longdescription", "version",
"platforms", "objects", "libraries", "elibraries".

=item B<init($)>

This method does instance initialization. It is internal. Do not use it directly.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV XML rules
	0.01 MV perl packaging
	0.02 MV PDMT
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV more Class method generation
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add versions to my libraries and to external libraries.

-make the version the versio object (with smart stuff etc...) and embedded XML parsing.
