#!/bin/echo This is a perl module and should not be run

package Meta::Distrib::Cpan;

use strict qw(vars refs subs);
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub upload($$$);
#sub TEST($);

#__DATA__

sub upload($$$) {
	my($user,$pass,$file)=@_;
	Meta::Utils::Output::print("uploading [".$user."] [".$pass."] [".$file."]\n");
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Distrib::Cpan - upload a module to cpan.

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

	MANIFEST: Cpan.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Distrib::Cpan qw();
	my($object)=Meta::Distrib::Cpan->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Give this modules a few parameters and it will upload a module to
CPAN for you. You need to be registered in CPAN to do this.
The details needed are:
1. user name on CPAN.
2. password for that user name.
3. name of the file you want to upload.

=head1 FUNCTIONS

	upload($$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<upload($$$)>

This method will upload a module to CPAN.
The parameters needed are:
0. The user name on CPAN.
1. The password on CPAN.
2. The file to be uploaded.
The routine returns an error code according to it's success.

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

	0.00 MV database
	0.01 MV perl module versions in files
	0.02 MV movies and small fixes
	0.03 MV thumbnail user interface
	0.04 MV more thumbnail issues
	0.05 MV website construction
	0.06 MV web site automation
	0.07 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
