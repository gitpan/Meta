#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Net::Md;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.26";
@ISA=qw();

#sub doit($$$$$$);
#sub TEST($);

#__DATA__

sub doit($$$$$$) {
	my($verb,$demo,$name,$user,$pass,$cdir)=@_;
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Utils::Net::Md - library to handle making of directories on remote machines.

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

	MANIFEST: Md.pm
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Net::Md qw();
	my($stat)=Meta::Utils::Net::Md::doit([params]);
	if(!$stat) {
		throw Meta::Error::Simple("unable to make directory on remote machine");
	}

=head1 DESCRIPTION

This will help you create directories on remove machines.
This currently uses ftp (yes, I know its funny) to do its thing.

=head1 FUNCTIONS

	doit($$$$$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<doit($$$$$$)>

This function will actualy do the distribution.

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

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV correct die usage
	0.07 MV perl code quality
	0.08 MV more perl quality
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
	0.26 MV md5 issues

=head1 SEE ALSO

strict(3)

=head1 TODO

Nothing.
