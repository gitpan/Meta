#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Lang::Docb::Params - supply parameters about DocBook usage.

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

MANIFEST: Params.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Lang::Docb::Params qw();>
C<my($object)=Meta::Lang::Docb::Params->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module will supply you with parameters regarding DocBook issues.
currently supported are:
0. encoding.
1. public id.
2. filename.

=head1 EXPORTS

C<get_encoding()>
C<get_public()>
C<get_system()>
C<get_comment()>
C<get_extra()>

=cut

package Meta::Lang::Docb::Params;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub get_encoding();
#sub get_public();
#sub get_system();
#sub get_comment();
#sub get_extra();

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<get_encoding()>

This will supply you with the default encoding that we use.

=cut

sub get_encoding() {
	return("ISO-8859-1");
}

=item B<get_public()>

This method will give you the public id of the document dtd we are using.

=cut

sub get_public() {
	return("-//OASIS//DTD DocBook V4.1//EN");
#	return(undef);
}

=item B<get_system()>

This method will give you the file name of the document dtd we are using.

=cut

sub get_system() {
	return("docbook.dtd");
#	return(undef);
}

=item B<get_comment()>

This method will give you a standard comment to put on all docbook files.

=cut

sub get_comment() {
	return("Base auto generated DocBook file - DO NOT EDIT!");
}

=item B<get_extra()>

This method will give you the extra path where to look for SGML data.

=cut

sub get_extra() {
#	return("/usr/lib/sgml:/usr/lib/sgml/stylesheets/sgmltools");
	return("");
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Sun Feb  4 10:05:44 2001	MV	get graph stuff going
2	Mon Feb  5 03:21:02 2001	MV	more perl quality
3	Tue Feb  6 07:02:13 2001	MV	more perl code quality
4	Tue Feb  6 22:19:51 2001	MV	revision change
5	Thu Feb  8 07:46:51 2001	MV	cook updates
6	Sun Feb 11 04:08:15 2001	MV	languages.pl test online
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-read all the stuff here from some xml configuration file.

=cut
