#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Output;

use strict qw(vars refs subs);
use IO::Handle qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub print($);
#sub get_file();
#sub get_handle();

#__DATA__

sub BEGIN() {
	STDOUT->IO::Handle::autoflush(1);
#	STDERR->IO::Handle::autoflush(1);
}

sub print($) {
	my($stri)=@_;
	print STDOUT $stri;
}

sub get_file() {
	return(*STDOUT);
}

sub get_handle() {
	return(\*STDOUT);
}

1;

__END__

=head1 NAME

Meta::Utils::Output - write output messages to console.

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

	MANIFEST: Output.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Output qw();
	my($object)=Meta::Utils::Output->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is a central controller of output to the console. All output to the
console (i.e. what usually you did using stdout and stderr) you should do
through this.

this is a SPECIAL STDERR FILE

=head1 FUNCTIONS

	print($)
	get_file()
	get_handle()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This is the BEGIN block for this module.
It is executed when the module is loaded.
Currently it just sets the autoflush on STDOUT which is not so by default.
The reason I don't do this for STDERR bacause by default STDERR is already
so.

=item B<print($)>

This prints out an output method to the console.

=item B<get_file()>

This method will return a file handle that other code can write to in order
to get output on the console.

=item B<get_handle()>

This method will return the code handle that other code can write to in order
to get output to the console.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV languages.pl test online
	0.01 MV get imdb ids of directors and movies
	0.02 MV perl packaging
	0.03 MV more movies
	0.04 MV md5 project
	0.05 MV database
	0.06 MV perl module versions in files
	0.07 MV movies and small fixes
	0.08 MV thumbnail user interface
	0.09 MV import tests
	0.10 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-use Text::Wrap here to wrap up lines.

-do colorization.

-do reading of arguments from XML options database and control in here.

-read whether we should do the flushing from the XML options file.

-get rid of the "SPECIAL STDERR FILE" tag here intended to allow using STDERR.
