#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Jar;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.08";
@ISA=qw();

#sub your_proc($);

#__DATA__

sub your_proc($) {
	my($proc)=@_;
	return(0);
}

1;

__END__

=head1 NAME

Meta::Tool::Jar - library to run Jar.

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

	MANIFEST: Jar.pm
	PROJECT: meta
	VERSION: 0.08

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Jar qw();
	my($code)=Meta::Tool::Jar::your_proc($proc);

=head1 DESCRIPTION

This library eases the job of running the Java Jar utility to create
a Java Jar file.

=head1 FUNCTIONS

	your_proc($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<your_proc($)>

This routine will return "yes" if the procedure which is given to it is one
which is handled by this module.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl order in packages
	0.01 MV perl 5.6.1 upgrade
	0.02 MV perl packaging
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV thumbnail user interface
	0.08 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
