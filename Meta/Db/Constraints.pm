#!/bin/echo This is a perl module and should not be run

package Meta::Db::Constraints;

use strict qw(vars refs subs);
use Meta::Ds::Connected qw();
use Meta::Ds::Ochash qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Meta::Ds::Ochash Meta::Ds::Connected);

#sub print($$);
#sub printd($$);
#sub printx($$);
#sub getsql_create($$$);

#__DATA__

sub print($$) {
}

sub printd($$) {
}

sub printx($$) {
}

sub getsql_create($$$) {
	my($self,$stats,$info)=@_;
	for(my($i)=0;$i<$self->size();$i++) {
		my($curr)=$self->elem($i);
		$curr->getsql_create($stats,$info);
	}
}

1;

__END__

=head1 NAME

Meta::Db::Constraints - store a list of constraints.

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

	MANIFEST: Constraints.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Constraints qw();
	my($object)=Meta::Db::Constraints->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class holds the list of constraints that have to do with a single
RDBMS table.

=head1 FUNCTIONS

	print($$)
	printd($$)
	printx($$)
	getsql_create($$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<print($$)>

This prints.

=item B<printd($$)>

This prints.

=item B<printx($$)>

This prints.

=item B<getsql_create($)>

This method will create all the constraints.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV dbman package creation
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
