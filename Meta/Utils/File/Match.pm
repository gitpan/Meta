#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Match;

use strict qw(vars refs subs);
use File::Find qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub match($$$);
#sub init($$$);
#sub doit($);
#sub TEST($);

#__DATA__

sub match($$$) {
	my($dire,$rege,$freg)=@_;
	my(@list);
	init(\@list,$rege,$freg);
	File::Find::find(\&doit,$dire);
}

our ($list,$rege,$freg);

sub init($$$) {
	($list,$rege,$freg)=@_;
}

sub doit($) {
	my($curr)=@_;
	my($full)=$File::Find::name;
	my($dirx)=$File::Find::dir;
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::File::Match - collecting files recursivly which match a pattern.

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

	MANIFEST: Match.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Match qw();
	my($list)=Meta::Utils::Math::match();

=head1 DESCRIPTION

This library enables you easily generate a list of all the files under
a directory which match a pattern.

=head1 FUNCTIONS

	match($$$)
	init($$$)
	doit($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<match($$$)>

This does an imitation of grep receiving a directory, a regular expression
of file names and a regular expression to search for in the files and gives
out a list of all the files in that directory who match the criteria.
This uses the find function from File::Find to do it.

=item B<init($$$)>

This function starts up the matching variables for use when the File::Find
routines kick into action.

=item B<doit($)>

This routine actually does the match.

=item B<TEST($)>

A test suite for this module.

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

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV check that all uses have qw
	0.04 MV fix todo items look in pod documentation
	0.05 MV more on tests/more checks to perl
	0.06 MV perl code quality
	0.07 MV more perl quality
	0.08 MV chess and code quality
	0.09 MV more perl quality
	0.10 MV perl documentation
	0.11 MV more perl quality
	0.12 MV perl qulity code
	0.13 MV more perl code quality
	0.14 MV revision change
	0.15 MV languages.pl test online
	0.16 MV perl packaging
	0.17 MV md5 project
	0.18 MV database
	0.19 MV perl module versions in files
	0.20 MV movies and small fixes
	0.21 MV thumbnail user interface
	0.22 MV more thumbnail issues
	0.23 MV website construction
	0.24 MV web site automation
	0.25 MV SEE ALSO section fix

=head1 SEE ALSO

File::Find(3), strict(3)

=head1 TODO

-This routine does not work complete the doit routine.

-do we need to export the init and doit routines ?

-get rid of the UGLY declaration of local variables here...
