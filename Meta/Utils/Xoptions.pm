#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Xoptions;

use strict qw(vars refs subs);
use Meta::Ds::Hash qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw(Meta::Ds::Hash);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Hash->new();
	bless($self,$clas);
	return($self);
}

1;

__END__

=head1 NAME

Meta::Utils::Xoptions - XML based options class.

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

	MANIFEST: Xoptions.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Xoptions qw();
	my($object)=Meta::Utils::Xoptions->new();

=head1 DESCRIPTION

This is an options type object (ini in windows terms) which you can
use to pass data to your program (options file). It is XML based.

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Utils::Xoptions object.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl reorganization
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
