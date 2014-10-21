#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Net::Hostname;

use strict qw(vars refs subs);
use Sys::Hostname qw();

our($VERSION,@ISA);
$VERSION="0.19";
@ISA=qw();

#sub full();
#sub part();

#__DATA__

sub full() {
	my($hostname)=Sys::Hostname::hostname();
	return($hostname);
}

sub part() {
	my($hostname)=full();
	my(@fiel)=split('\.',$hostname);
	my($resu)=$fiel[0];
	return($resu);
}

1;

__END__

=head1 NAME

Meta::Utils::Net::Hostname - library to handle net host names.

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

	MANIFEST: Hostname.pm
	PROJECT: meta
	VERSION: 0.19

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Net::Hostname qw();
	my($name)=Meta::Utils::Net::Hostname::host();

=head1 DESCRIPTION

This module supplies host names on demand.
A fully qualified name is 10$ per piece (3$ more for each DNS lookup).
A short name is 5.99$ with 1$ off if its in the same local network and no
firewall is in the middle.

=head1 FUNCTIONS

	full()
	part()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<full()>

This functions returns the full name of the current host (full hostname).
This function receives nothing.

=item B<part()>

This function return the short name of the current host (just the machine name).
This function receives nothing.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV check that all uses have qw
	0.04 MV fix todo items look in pod documentation
	0.05 MV perl code quality
	0.06 MV more perl quality
	0.07 MV more perl quality
	0.08 MV perl documentation
	0.09 MV more perl quality
	0.10 MV more perl code quality
	0.11 MV revision change
	0.12 MV languages.pl test online
	0.13 MV perl packaging
	0.14 MV md5 project
	0.15 MV database
	0.16 MV perl module versions in files
	0.17 MV movies and small fixes
	0.18 MV thumbnail user interface
	0.19 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add DNS services (translate ip into hostname and vice versa). (or should this be in another module ?).
