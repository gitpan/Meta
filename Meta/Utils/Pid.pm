#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Pid;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.20";
@ISA=qw();

#sub mypid();

#__DATA__

sub mypid() {
	return($$);
}

1;

__END__

=head1 NAME

Meta::Utils::Pid - routines regarding pid's.

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

	MANIFEST: Pid.pm
	PROJECT: meta
	VERSION: 0.20

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Pid qw();
	my($pid)=Meta::Utils::Pid::mypid();

=head1 DESCRIPTION

This is a library to help you in finding your pid, other processes pid's
and the like...

=head1 FUNCTIONS

	mypid()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<mypid()>

Gives you the pid of the current running process.
Perl has such a builtin variable named $$ and this currently just returns
this...

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
	0.05 MV more on tests/more checks to perl
	0.06 MV perl code quality
	0.07 MV more perl quality
	0.08 MV more perl quality
	0.09 MV perl documentation
	0.10 MV more perl quality
	0.11 MV more perl code quality
	0.12 MV revision change
	0.13 MV languages.pl test online
	0.14 MV perl packaging
	0.15 MV md5 project
	0.16 MV database
	0.17 MV perl module versions in files
	0.18 MV movies and small fixes
	0.19 MV thumbnail user interface
	0.20 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.