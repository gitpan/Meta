#!/bin/echo This is a perl module and should not be run

package Meta::Development::Patch;

use strict qw(vars refs subs);
use Meta::Baseline::Aegis qw();
use Meta::Class::MethodMaker qw();
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw();

#sub BEGIN();
#sub file_list($);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_file",
	);
}

sub file_list($) {
	my($self)=@_;
	my($lines)=Meta::Utils::System::system_out_list("lsdiff",[$self->get_file()]);
	return($lines);
}

sub TEST($) {
	my($context)=@_;
#	my($patch)=Meta::Development::Patch->new();
#	my($file)=Meta::Baseline::Aegis::which("patc/example.patch");
#	$patch->set_file($file);
#	my($list)=$patch->file_list();
	return(1);
}

1;

__END__

=head1 NAME

Meta::Development::Patch - object which represents a patch.

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

	MANIFEST: Patch.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Development::Patch qw();
	my($patch)=Meta::Development::Patch->new();
	$patch->set_file("linux-2.4.17-dj-2.patch");
	my($file_list)=$patch->file_list();

=head1 DESCRIPTION

This object encapsulates the concepts of a patch file. A patch
file is a file generated by running diff on two directories
and contains the difference between the files in the two
directories. Read more about patch in "man patch" and "man diff".

You can construct the object using a patch that you generated
using two directories. You can then apply the patch on a
directory or list the files which participate in the patch.

=head1 FUNCTIONS

	BEGIN()
	file_list($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method will set up a constructor with a new method and an accessor
for attribute file.

=item B<file_list($)>

This method will return the list of files which participate in the
patch.

=item B<TEST($)>

This is a testing suite for the Meta::Development::Patch module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

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

	0.00 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Class::MethodMaker(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-do actual parsing of the patch file

-enable methods to list which lines are changed, original and new lines and more...