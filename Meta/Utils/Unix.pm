#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Unix;

use strict qw(vars refs subs);
use File::Basename qw();

our($VERSION,@ISA);
$VERSION="0.23";
@ISA=qw();

#sub file_to_libname($);
#sub file_to_libname_dir($$);

#__DATA__

sub file_to_libname($) {
	my($file)=@_;
	my($base)=File::Basename::basename($file);
	my($stri)="lib(.*)\.so";
	if($base=~/^$stri$/) {
		my($name)=($base=~/^$stri$/);
		return($name);
	} else {
		Meta::Utils::System::die("file [".$file."] is not a standard library name");
	}
}

sub file_to_libname_dir($$) {
	my($file,$dire)=@_;
}

1;

__END__

=head1 NAME

Meta::Utils::Unix - handle Unix weird stuff.

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

	MANIFEST: Unix.pm
	PROJECT: meta
	VERSION: 0.23

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Unix qw();
	my($libname)=Meta::Utils::Unix::file_to_libname();

=head1 DESCRIPTION

This is a library to handle small things which are weird on a unix system.
The one thing it handles now are the weird thing that if you like with a
library "library" the actual file is not library but rather: liblibrary.so.version. Routines are given to make the translations back and forth.

=head1 FUNCTIONS

	file_to_libname($)
	file_to_libname_dir($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<file_to_libname($)>

This routine receives the name of a file which is supposed to be the name
of a library. It checks that it does comply with the standard name for
a library ([dire]/lib[name].so.[version]) and if so returns the [name]
component.

=item B<file_to_libname_dir($$)>

This routine does the same as file_to_libname except it is given the directory
that is supposed to prefix the library name.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV handle architectures better
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV correct die usage
	0.08 MV perl code quality
	0.09 MV more perl quality
	0.10 MV more perl quality
	0.11 MV perl documentation
	0.12 MV more perl quality
	0.13 MV perl qulity code
	0.14 MV more perl code quality
	0.15 MV revision change
	0.16 MV languages.pl test online
	0.17 MV perl packaging
	0.18 MV md5 project
	0.19 MV database
	0.20 MV perl module versions in files
	0.21 MV movies and small fixes
	0.22 MV thumbnail user interface
	0.23 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
