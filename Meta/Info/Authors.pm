#!/bin/echo This is a perl module and should not be run

package Meta::Info::Authors;

use strict qw(vars refs subs);
use Meta::Ds::Ohash qw();
use Meta::Info::Author qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(Meta::Ds::Ohash);

#sub new_deve($$);
#sub get_default($);
#sub TEST($);

#__DATA__

sub new_deve($$) {
	my($class,$file)=@_;
	my($self)={};
	CORE::bless($self,$class);
	return($self);
}

sub get_default($) {
	my($self)=@_;
	my($author)=Meta::Info::Author->new_deve("xmlx/author/author.xml");
	return($author);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Info::Authors - Object to store infomation about multiple authors.

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

	MANIFEST: Authors.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Info::Authors qw();
	my($authors)=Meta::Info::Authors->new();
	my($author)=$authors->get("mark");
	my($signature)=$author->get_signature();

=head1 DESCRIPTION

This is an object to store information for multiple authors within a system.

=head1 FUNCTIONS

	new_deve($$)
	get_default($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new_deve($$)>

Will create and return a new authors object from a development file.

=item B<get_default($)>

This method will return the default author.

=item B<TEST($)>

Test suite for this object.

=back

=head1 SUPER CLASSES

Meta::Ds::Ohash(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV bring movie data

=head1 SEE ALSO

Meta::Ds::Ohash(3), Meta::Info::Author(3), strict(3)

=head1 TODO

Nothing.
