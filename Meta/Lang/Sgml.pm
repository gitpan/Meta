#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Lang::Sgml - help you with Sgml related tasks.

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

MANIFEST: Sgml.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Lang::Sgml qw();>
C<my($object)=Meta::Lang::Sgml->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This class will help you with Sgml related tasks.
0. Producing dependency information for an Sgml file.

=head1 EXPORTS

C<get_prefix()>
C<c2deps($$)>

=cut

package Meta::Lang::Sgml;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT $errors);
use Meta::Xml::Parsers::Deps qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub get_prefix();
#sub c2deps($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<get_prefix()>

This method returns the prefix for Sgml related material in the baseline.

=cut

sub get_prefix() {
	return("chun/sgml/");
}

=item B<c2deps($$)>

This method reads a source xml file and produces a deps object which describes
the dependencies for that file.
This method uses an Expat parser to do it which is quite cheap.

=cut

sub c2deps($$) {
	my($modu,$srcx)=@_;
	my($parser)=Meta::Xml::Parsers::Deps->new();
	$parser->set_search_path(&get_prefix());
	$parser->set_root($modu);
	$parser->parsefile($srcx);
	return($parser->get_result());
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

-the way im counting errros here is not nice since I'm using a global variable. This could be pretty bad for multi-threading etc... Try to make that nicer and dump the global var. You could see the errors global variable in the vars section. 

=cut
