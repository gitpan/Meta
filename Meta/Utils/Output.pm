#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Output - write output messages to console.

=head1 COPYRIGHT

Copyright (C) 2001 Mark Veltzer;
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

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Output qw();>
C<my($object)=Meta::Utils::Output->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

SPECIAL STDERR FILE

This is a central controller of output to the console. All output to the
console (i.e. what usually you did using stdout and stderr) you should do
through this.

=head1 EXPORTS

C<print($)>
C<get_file()>

=cut

package Meta::Utils::Output;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use IO::Handle qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub print($);
#sub get_file();

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<BEGIN>

This is the BEGIN block for this module.
It is executed when the module is loaded.
Currently it just sets the autoflush on STDOUT which is not so by default.
The reason I don't do this for STDERR bacause by default STDERR is already
so.

=cut

BEGIN {
	STDOUT->IO::Handle::autoflush(1);
}

=item B<print($)>

This prints out an output method to the console.

=cut

sub print($) {
	my($stri)=@_;
	print STDOUT $stri;
}

=item B<get_file()>

This method will return a file handle that other code can write to in order
to get output on the console.

=cut

sub get_file() {
	return(*STDOUT);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

None.

=head1 SEE ALSO

Nothing.

=head1 TODO

-use Text::Wrap here to wrap up lines.

-do colorization.

-do reading of arguments from XML options database and control in here.

-read whether we should do the flushing from the XML options file.

=cut
