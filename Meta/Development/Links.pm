#!/bin/echo This is a perl module and should not be run

package Meta::Development::Links;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();

our($VERSION,@ISA);
$VERSION="0.08";
@ISA=qw(Meta::Ds::Array);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Array->new();
	bless($self,$clas);
	return($self);
}

1;

__END__

=head1 NAME

Meta::Development::Links - an array of targets to link.

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

	MANIFEST: Links.pm
	PROJECT: meta
	VERSION: 0.08

=head1 SYNOPSIS

	package foo;
	use Meta::Development::Links qw();
	my($object)=Meta::Development::Links->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is an array collection of targets to link.
See the Meta::Development::Link documentation about
what is an individual link target.

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Development::Links object.

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

-we don't need the dummy constructor here.
