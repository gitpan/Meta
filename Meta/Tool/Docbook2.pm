#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Docbook2 - run docbook2 tool.

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

MANIFEST: Docbook2.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Docbook2 qw();>
C<my($object)=Meta::Tool::Docbook2->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This job will make it easier to run the Docbook2 type tool.

=head1 EXPORTS

C<c2manx($)>

=cut

package Meta::Tool::Docbook2;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Baseline::Utils qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub c2manx($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<c2manx($)>

This routine will convert sgml DocBook files to manual page format.

=cut

sub c2manx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
