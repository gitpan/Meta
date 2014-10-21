#!/bin/echo This is a perl module and should not be run

package Meta::Projects::Fortune::Item;

use strict qw(vars refs subs);
use Meta::Class::DBI qw();
use base qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(Meta::Class::DBI);

#sub BEGIN();
#sub TEST($);

#__DATA__

sub BEGIN() {
	base::import(__PACKAGE__,"Meta::Class::DBI");
	__PACKAGE__->table('item');
	__PACKAGE__->columns('Primary'=>'id');
	__PACKAGE__->columns(All=>qw/id text/);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Projects::Fortune::Item - a single fortune item in the fortune database.

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

	MANIFEST: Item.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Projects::Fortune::Item qw();
	my($object)=Meta::Projects::Fortune::Item->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class is a single fortune item in the fortune database.

=head1 FUNCTIONS

	BEGIN()
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method is a setup method internded to set up DB interaction.

=item B<TEST($)>

This is a testing suite for the Meta::Projects::Fortune::Item module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

=back

=head1 SUPER CLASSES

Meta::Class::DBI(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV finish papers

=head1 SEE ALSO

Meta::Class::DBI(3), base(3), strict(3)

=head1 TODO

Nothing.
