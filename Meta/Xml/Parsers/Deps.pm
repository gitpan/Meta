#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Xml::Parsers::Deps - dependency analyzer for XML files.

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

MANIFEST: Deps.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Xml::Parsers::Deps qw();>
C<my($deps_parser)=Meta::Xml::Parsers::Deps->new();>
C<$deps_parser->parsefile($file);>
C<my($deps)=$desp_parser->get_result();>

=head1 DESCRIPTION

This is an expat based parser whose sole purpose is finiding dependencies
for xml files.

=head1 EXPORTS

C<new($)>
C<get_result($)>
C<get_root($)>
C<set_root($$)>
C<handle_doctype($$$$$)>
C<handle_externent($$$$)>

=cut

package Meta::Xml::Parsers::Deps;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Xml::Parsers::Base qw();
use Meta::Development::Deps qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Xml::Parsers::Base);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub get_result($);
#sub get_root($);
#sub set_root($$);
#sub get_search_path($);
#sub set_search_path($$);
#sub handle_doctype($$$$$);
#sub handle_externent($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new object for a parser.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=XML::Parser::Expat->new(ParseParamEnt=>0);
	$self->{DEPS}=Meta::Development::Deps->new();
	$self->{ROOT}=defined;
	$self->{SEARCH_PATH}=defined;
	if(!$self) {
		Meta::Utils::System::die("didn't get a parser");
	}
	$self->setHandlers(
		'Doctype'=>\&handle_doctype,
		'ExternEnt'=>\&handle_externent,
	);
	bless($self,$clas);
	return($self);
}

=item B<get_result($)>

This will return the dependency object which is the result of the parse.

=cut

sub get_result($$) {
	my($self)=@_;
	return($self->{DEPS});
}

=item B<get_root($)>

This method will retrieve the root node for the dependency object.

=cut

sub get_root($) {
	my($self)=@_;
	return($self->{ROOT});
}

=item B<set_root($$)>

This will set the root node that the deps will be attached to.

=cut

sub set_root($$) {
	my($self,$valx)=@_;
	$self->{ROOT}=$valx;
	$self->{DEPS}->node_insert($valx);
}

=item B<get_search_path($)>

This method will retrieve the baseline relative path where this
parser thinks the deps are.

=cut

sub get_search_path($) {
	my($self)=@_;
	return($self->{SEARCH_PATH});
}

=item B<set_search_path($$)>

This method will set the search path.

=cut

sub set_search_path($$) {
	my($self,$valx)=@_;
	$self->{SEARCH_PATH}=$valx;
}

=item B<handle_doctype($$$$$)>

This method will handle the document type declarations and will add the
dependency on the dtd to the deps object.

=cut

sub handle_doctype($$$$$) {
	my($self,$name,$sysid,$pubid,$internal)=@_;
#	Meta::Utils::Output::print("in handle_doctype\n");
	if($sysid ne "") {
		my($name)="dtdx/".$sysid;
		$self->{DEPS}->node_insert($name);
		$self->{DEPS}->edge_insert($self->get_root(),$name);
	}
}

=item B<handle_externent($$$$)>

This method will handle external entities.
Remember that in a Deps parser we do not wish to process the external
entity (if we had access to the graph we would have made sure that
the file existed in the graph but since we dont we just omit it as
dependency).

=cut

sub handle_externent($$$$) {
	my($self,$base,$sysid,$pubid)=@_;
#	Meta::Utils::Output::print("in handle_externent\n");
#	Meta::Utils::Output::print("base is [".$base."]\n");
#	Meta::Utils::Output::print("sysid is [".$sysid."]\n");
#	Meta::Utils::Output::print("pubid is [".$pubid."]\n");
	my($name)=$self->get_search_path().$sysid;
	$self->{DEPS}->node_insert($name);
	$self->{DEPS}->edge_insert($self->get_root(),$name);
#	return($self->Meta::Xml::Parsers::Base::handle_externent($$base,$sysid,$pubid));
	return("");
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

Nothing.

=cut
