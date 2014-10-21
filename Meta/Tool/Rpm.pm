#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Rpm;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub TEST($);

#__DATA__

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Tool::Rpm - library to run the RPM tool for package creation.

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

	MANIFEST: Rpm.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Rpm qw();
	my($code)=Meta::Tool::Rpm::your_proc($proc);

=head1 DESCRIPTION

This package runs RPM for you and knows how to supply it with all the
relevant options. It can also access the RPM database for you and
find out information for there (which packages are installed etc...).

=head1 FUNCTIONS

	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

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

	0.00 MV perl order in packages
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

strict(3)

=head1 TODO

Nothing.
