#!/bin/echo This is a perl module and should not be run

package Meta::Digest::MD5;

use strict qw(vars refs subs);
use Digest::MD5 qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw(Digest::MD5);

#sub get_filename_digest($$);

#__DATA__

sub get_filename_digest($) {
	my($name)=@_;
	my($md)=Digest::MD5->new();
	open(FILE,$name) || Meta::Utils::System::die("unable to open file [".$name."]");
	$md->addfile(*FILE);
	close(FILE) || Meta::Utils::System::die("unable to close file [".$name."]");
	return($md->digest());
}

1;

__END__

=head1 NAME

Meta::Digest::MD5 - extend the standard Digest::MD5 module.

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

	MANIFEST: MD5.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Digest::MD5 qw();
	my($result)=$object->method();

=head1 DESCRIPTION

This module extends the functionality found in the Digest::MD5
standard module with code that otherwise will have to be written
many times in places of Digest::MD5. The object inherits from
Digest::MD5 so you can use all of that modules functionality too.
I try very hard not to override existing MD5 methods.

=head1 FUNCTIONS

	get_filename_digest($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_filename_digest($$)>

This method adds a file name to the current Meta::Digest::MD5 object.
The reason we use the object oriented methodology here (creating an
object and then adding the file using the addfile method) is that it
could be that this method is much more memory effective since we don't
have to load the entire blob to memory at one time as we would do if
we had uploaded everything and then used the "md5" method of the package.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more perl packaging
	0.01 MV tree type organization in databases
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
