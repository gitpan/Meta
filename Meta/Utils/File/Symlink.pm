#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Symlink;

use strict qw(vars refs subs);
use Meta::Utils::File::Copy qw();
use File::Find qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.24";
@ISA=qw();

#sub check_doit();
#sub check($$);
#sub replace_doit();
#sub replace($$$);
#sub symlink($$);
#sub link($$);

#__DATA__

sub check_doit($) {
	my($curr)=@_;
	my($full)=$File::Find::name;
	my($dire)=$File::Find::dir;
	my($verb)=0;
	if(-l $curr) {
		if($verb) {
			Meta::Utils::Output::print("checking [".$full."]\n");
		}
		my($read)=readlink($curr);
		if(!$read) {
			Meta::Utils::System::die("cant readlink [".$full."]");
		}
		if(!-e $read) {
			Meta::Utils::Output::print("test failed for [".$full."]\n");
		}
	}
}

sub check($$) {
	my($dire,$verb)=@_;
	File::Find::finddepth(\&check_doit,$dire);
}

sub replace_doit() {
	my($curr)=@_;
	my($full)=$File::Find::name;
	my($dire)=$File::Find::dir;
	my($verb)=0;
	my($demo)=0;
	if(-l $curr) {
		if($verb) {
			Meta::Utils::Output::print("replacing [".$full."]\n");
		}
		if(!$demo) {
			my($read)=readlink($curr);
			if($read) {
				Meta::Utils::File::Copy::copy_unlink($read,$curr);
			} else {
				Meta::Utils::System::die("unable to replace symlink [".$full."]");
			}
		}
	}
}

sub replace($$$) {
	my($dire,$demo,$verb)=@_;
	File::Find::finddepth(\&replace_doit,$dire);
}

sub symlink($$) {
	my($oldx,$newx)=@_;
	if(!CORE::symlink($oldx,$newx)) {
		Meta::Utils::System::die("unable to create symlink from [".$oldx."] to [".$newx."]");
	}
}

sub link($$) {
	my($oldx,$newx)=@_;
	if(!CORE::link($oldx,$newx)) {
		Meta::Utils::System::die("unable to create link from [".$oldx."] to [".$newx."]");
	}
}

1;

__END__

=head1 NAME

Meta::Utils::File::Symlink - module to help you deal with symbolic links.

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

	MANIFEST: Symlink.pm
	PROJECT: meta
	VERSION: 0.24

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Symlink qw();
	my($directory)="~/data";
	my($verbose)=1;
	Meta::Utils::File::Symlink::check($directory,$verbose);

=head1 DESCRIPTION

This is a library enabling you to basically do two things:
1. scan directories in recursive fashion to check that all symlinks in
	those directories are valid.
2. scan directories in recursive fashion to replace all symlinks with the
	files they are pointing at.
This module uses File::Find extensivly.

=head1 FUNCTIONS

	check_doit($)
	check($$)
	replace_doit()
	replace($$$)
	symlink($$)
	link($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<check_doit($)>

This function checks if the file she gets is a symlink and if so verifies
the fact that is is ok.

=item B<check($$)>

This function receives a directory and scans it using File::Find and
fills up a hash with all the files found there.
The routine also receives a verbose parameter.
The routine returns nothing.

=item B<replace_doit()>

This function checks if the file she gets is a symlink and if so removes
it and replaces it with the content of the file it is pointing at.

=item B<replace($$$)>

This function receives a directory and scans it using File::Find and
fills up a hash with all the files found there.
The routine also receives a demo parameter.
The routine also receives a verbose parameter.
The routine returns nothing.

=item B<symlink($$)>

Create a symbolic link.

=item B<link($$)>

Create a hard link.

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
	0.11 MV more perl quality
	0.12 MV perl documentation
	0.13 MV more perl quality
	0.14 MV perl qulity code
	0.15 MV more perl code quality
	0.16 MV revision change
	0.17 MV languages.pl test online
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

-do we need to export the "_doit" routines ? No!!!
