#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Gzip - call gzip for you.

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

MANIFEST: Gzip.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Gzip qw();>
C<my($object)=Meta::Tool::Gzip->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This class hides the complexity of calling gzip from you.
Currently the implementation calls the command line gzip to do
the work but more advanced implementations will call a module
to do it.

=head1 EXPORTS

C<c2gzxx($)>

=cut

package Meta::Tool::Gzip;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub c2gzxx($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<c2gzz($)>

This method gets a source file and compresses it into the target.
The method returns a success code.
We use the system_shell_nodie function here with the shell as
a mediator because gzip doesnt have a -o flag.

=cut

sub c2gzxx($) {
	my($buil)=@_;
	return(Meta::Utils::System::system_shell_nodie("gzip --stdout ".$buil->get_srcx()." > ".$buil->get_targ()));
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

-stop using the shell in the gzip execution (waste of resources).

-start using a real compression module (much cheaper in resources).

=cut
