#!/bin/echo This is a perl module and should not be run

package Meta::Math::Pad;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub pad($$);
#sub TEST($);

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

sub TEST($) {
	my($context)=@_;
	my($number)="19";
	my($padded)=pad($number,4);
	my($res);
	if($padded eq "0019") {
		$res=1;
	} else {
		$res=0;
	}
	Meta::Utils::Output::print("padded number is [".$padded."]\n");
	return(1);
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
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Math::Pad qw();
	my($number)="19";
	my($padded)=Meta::Math::Pad::pad($number,4);
	# $padded should now be "0019"

=head1 DESCRIPTION

This module handles padding numbers to achieve a certain presentation. This module currently
provides just a single function but may provide decimal point padding and other functions
in the future.

=head1 FUNCTIONS

	pad($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<pad($$)>

This will pad a number to the required number of digits.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.08 MV website construction
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-any faster way to do this ? (faster way to generate a string in perl with n occurances of the character 'c')

-provide decimal point padding.

-provide padding with spaces instead of 0's.
