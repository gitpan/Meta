#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Dir;

use strict qw(vars refs subs);
use Carp qw();

our($VERSION,@ISA);
$VERSION="0.24";
@ISA=qw();

#sub empty($);
#sub exist($);
#sub check_exist($);
#sub fixdir($);

#__DATA__

sub empty($) {
	my($dire)=@_;
	opendir(DIRE,$dire) || Meta::Utils::System::die("cannot opendir [".$dire."]");
	my(@file)=readdir(DIRE);
	closedir(DIRE) || Meta::Utils::System::die("cannot closedir [".$dire."]");
	return($#file==1);
}

sub exist($) {
	my($dire)=@_;
	return(-d $dire);
}

sub check_exist($) {
	my($dire)=@_;
	if(!(-d $dire)) {
		Carp::confess("directory [".$dire."] does not exist");
	}
}

sub fixdir($) {
	my($name)=@_;
	while($name=~s/[^\/]*\/\.\.\///) {};
	return($name);
}

1;

__END__

=head1 NAME

Meta::Utils::File::Dir - library to do stuff on directories in the file system.

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

	MANIFEST: Dir.pm
	PROJECT: meta
	VERSION: 0.24

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Dir qw();
	my($dire)="/etc";
	if(Meta::Utils::File::Dir::empty($dire)) {
		# do that
	} else {
		# do other
	}

=head1 DESCRIPTION

This is a library to help you do things with directories. For instance:
create a directory (also creating its parents) and dying if something
goes wrong, checking if a directory is empty etc...

=head1 FUNCTIONS

	empty($)
	exist($)
	check_exist($)
	fixdir($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<empty($)>

This returns a boolean value according to whether the directory
is empty or not. The current implementation seems slow since it
lists our all the files in that directory and checks to see that
we have only one (the ".." link which points to the father...:)
A speedup would be to find a better way in perl to do this...
Using stat maybe ?

=item B<exist($)>

This routine returns whether a certain directory is valid.

=item B<check_exist($)>

This routine checks if a directory given to it exists and if not dies.

=item B<fixdir($)>

This routine gets a name of a file or directory and eliminated bad stuff
from it:
0. [pref] slash [a] slash [..] slash [suff] is turned to [pref] slash [suff]

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
	0.17 MV web site and docbook style sheets
	0.18 MV perl packaging
	0.19 MV md5 project
	0.20 MV database
	0.21 MV perl module versions in files
	0.22 MV movies and small fixes
	0.23 MV thumbnail user interface
	0.24 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-cant we do the empty routine more efficiently ? (some stat or something...)
