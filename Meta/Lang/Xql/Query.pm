#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Xql::Query;

use strict qw(vars refs subs);
use XML::XQL qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(XML::XQL::Query);

#sub solve_single_string($$);
#sub TEST($);

#__DATA__

sub solve_single_string($$) {
	my($self,$dom)=@_;
	my(@res)=$self->solve($dom);
	my($size)=$#res+1;
	if($size!=1) {
		Meta::Utils::System::die("got more [".$size."] > 1 results");
	}
	return($res[0]->xql_toString());
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Lang::Xql::Query - enhance XML::XQL::Query.

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

	MANIFEST: Query.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Xql::Query qw();
	my($object)=Meta::Lang::Xql::Query->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This object is the same as XML::XQL::Query but enhanced a bit.

=head1 FUNCTIONS

	solve_single_string($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<solve_single_string($$)>

This method does exacly as "solve" for XML::XQL::Query only makes sure
that the result is a single cell and converts it to string (shortcut
method).

=item B<TEST($)>

This is a testing suite for the Meta::Lang::Xql::Query module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

This test currently does nothing.

=back

=head1 SUPER CLASSES

XML::XQL::Query(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV teachers project

=head1 SEE ALSO

XML::XQL(3), strict(3)

=head1 TODO

Nothing.
