#!/bin/echo This is a perl module and should not be run

package Meta::Projects::Dbman::Section;

use strict qw(vars refs subs);
use base qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Class::DBI);

#sub BEGIN();

#__DATA__

sub BEGIN() {
	base::import(__PACKAGE__,"Class::DBI");
	__PACKAGE__->set_db('Main',"dbi:mysql:dbman:host=database","master","master");
	__PACKAGE__->table('section');
	__PACKAGE__->columns('Primary'=>'id');
	__PACKAGE__->columns(All=>qw/id name description tag/);
}

1;

__END__

=head1 NAME

Meta::Projects::Dbman::Section - a single section in a Dbman.

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

	MANIFEST: Section.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Projects::Dbman::Section qw();
	my($object)=Meta::Projects::Dbman::Section->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This object is a single section in the dbman database.

=head1 FUNCTIONS

	BEGIN()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method sets up all the information needed to access the section
information in the dbman.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
