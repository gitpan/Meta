#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Copy;

use strict qw(vars refs subs);
use Meta::Utils::File::Remove qw();
use File::Copy qw();
use File::Basename qw();
use File::Path qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.27";
@ISA=qw();

#sub copy($$);
#sub copy_unlink($$);
#sub copy_mkdir($$);

#__DATA__

sub copy($$) {
	my($fil1,$fil2)=@_;
	my($verb)=0;
	if($verb) {
		Meta::Utils::Output::print("copying [".$fil1."] to [".$fil2."]\n");
	}
	if(!File::Copy::copy($fil1,$fil2)) {
		Meta::Utils::System::die("unable to copy [".$fil1."] to [".$fil2."]");
	}
	return(1);
}

sub copy_unlink($$) {
	my($fil1,$fil2)=@_;
	my($verb)=0;
	if($verb) {
		Meta::Utils::Output::print("removing [".$fil2."]\n");
	}
	if(!Meta::Utils::File::Remove::rm($fil2)) {
		return(0);
	}
	return(&copy($fil1,$fil2));
}

sub copy_mkdir($$) {
	my($fil1,$fil2)=@_;
	my($dire)=File::Basename::dirname($fil2);
	if(!(-e $dire)) {
		my($verb)=0;
		if($verb) {
			Meta::Utils::Output::print("making directory [".$dire."]\n");
		}
		if(!File::Path::mkpath($dire)) {
			return(0);
		}
	}
	return(&copy($fil1,$fil2));
}

1;

__END__

=head1 NAME

Meta::Utils::File::Copy - library to help you copy files.

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

	MANIFEST: Copy.pm
	PROJECT: meta
	VERSION: 0.27

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Copy qw();
	Meta::Utils::File::Copy::copy($file1,$file2);

=head1 DESCRIPTION

This module eases the case for copying files.

=head1 FUNCTIONS

	copy($$)
	copy_unlink($$)
	copy_mkdir($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<copy($$)>

This function copies a file to another and dies if it cannot succeed.

=item B<copy_unlink($$)>

This function assumes that the target file exists, unlinks it, and then
copies the source to the target

=item B<copy_mkdir($$)>

This function copies one file to another and creates the directory
if neccessary. More than one hierarchy of directories can be created...

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
	0.07 MV spelling change
	0.08 MV correct die usage
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV chess and code quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV more on images
	0.20 MV perl packaging
	0.21 MV fix database problems
	0.22 MV md5 project
	0.23 MV database
	0.24 MV perl module versions in files
	0.25 MV movies and small fixes
	0.26 MV thumbnail user interface
	0.27 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
