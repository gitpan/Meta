#!/bin/echo This is a perl module and should not be run

package Meta::Cgi::Patch;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw();

#sub new($);
#sub method($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	return($self);
}

sub method($) {
	my($self)=@_;
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Cgi::Patch - CGI script to help you in browsing patch files.

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
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Cgi::Patch qw();
	my($object)=Meta::Cgi::Patch->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class generates a CGI interface for browsing patch/diff files.
It is able to show you the files that are patched and the nature of
the change in each.

=head1 FUNCTIONS

	new($)
	method($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Cgi::Patch object.

=item B<method($)>

This is an object method.

=item B<TEST($)>

This is a testing suite for the Meta::Cgi::Patch module.
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
	0.01 MV bring movie data

=head1 SEE ALSO

strict(3)

=head1 TODO

Nothing.
