#!/bin/echo This is a perl module and should not be run

package Meta::Movie::Person;

use strict qw(vars refs subs);
use base qw();

our($VERSION,@ISA);
$VERSION="0.04";
@ISA=qw(Class::DBI);

#sub BEGIN();
#sub TEST($);

#__DATA__

sub BEGIN() {
	base::import(__PACKAGE__,"Class::DBI");
	__PACKAGE__->set_db('Main',"dbi:mysql:movie:host=database","master","master");
	__PACKAGE__->table('person');
	__PACKAGE__->columns('Primary'=>'id');
	__PACKAGE__->columns(All=>qw/id firstname lineage surname othername sequential birth_date dead death_date description/);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Movie::Person - movie database person infomation.

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

	MANIFEST: Person.pm
	PROJECT: meta
	VERSION: 0.04

=head1 SYNOPSIS

	package foo;
	use Meta::Movie::Person qw();
	my($object)=Meta::Movie::Person->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is a movie database person information.

=head1 FUNCTIONS

	BEGIN()
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method sets up all the stuff needed to access the db.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Class::DBI(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV more thumbnail issues
	0.02 MV website construction
	0.03 MV web site automation
	0.04 MV SEE ALSO section fix

=head1 SEE ALSO

base(3), strict(3)

=head1 TODO

Nothing.
