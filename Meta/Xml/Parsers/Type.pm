#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Xml::Parsers::Type - find type of an XML file.

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

MANIFEST: Type.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Xml::Parsers::Type qw();>
C<my($deps_parser)=Meta::Xml::Parsers::Type->new();>
C<$deps_parser->parsefile($file);>
C<my($deps)=$desp_parser->get_result();>

=head1 DESCRIPTION

This is an Expat based parser who's sole purpose is to find the
type of certain XML file.

=head1 EXPORTS

C<new($)>
C<get_result($)>
C<handle_doctype($$$$$)>

=cut

package Meta::Xml::Parsers::Type;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Xml::Parsers::Base qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Xml::Parsers::Base);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub get_result($);
#sub handle_doctype($$$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new object for a parser.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=XML::Parser::Expat->new();
	if(!$self) {
		Meta::Utils::System::die("didn't get a parser");
	}
	$self->setHandlers(
		'Doctype'=>\&handle_doctype,
	);
	bless($self,$clas);
	$self->{TYPE}=defined;
	return($self);
}

=item B<get_result($)>

This will return the dependency object which is the result of the parse.

=cut

sub get_result($$) {
	my($self)=@_;
	return($self->{TYPE});
}

=item B<handle_doctype($$$$$)>

This method will handle the document type declarations and will add the
dependency on the dtd to the deps object.

=cut

sub handle_doctype($$$$$) {
	my($self,$name,$sysid,$pubid,$internal)=@_;
#	Meta::Utils::Output::print("in handle_doctype\n");
	$self->{TYPE}=$name;
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

-couldnt we stop the parsing after we found the type ? (saves time).

=cut
