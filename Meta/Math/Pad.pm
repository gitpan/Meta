#!/bin/echo This is a perl module and should not be run

package Meta::Math::Pad;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub pad($$);

#__DATA__

sub pad($$) {
	my($numb,$digi)=@_;
	if(length($numb)>$digi) {
		Meta::Utils::System::die("length of number received already more than required number of digits");
	}
	my($retu)=$numb;
	while(length($retu)<$digi) {
		$retu="0".$retu;
	}
	return($retu);
}

1;

__END__

=head1 NAME

Meta::Math::Pad - pad numbers with zeros.

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

	MANIFEST: Pad.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Math::Pad qw();
	my($object)=Meta::Math::Pad->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module handles padding number to achieve a certain presentation.

=head1 FUNCTIONS

	pad($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<pad($$)>

This will pad a number to the required number of digits.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV multi image viewer
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

-any faster way to do this ?
