#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Deps;

use strict qw(vars refs subs);
use Meta::Xml::Parsers::Base qw();
use Meta::Development::Deps qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.13";
@ISA=qw(Meta::Xml::Parsers::Base);

#sub new($);
#sub get_result($);
#sub get_root($);
#sub set_root($$);
#sub get_search_path($);
#sub set_search_path($$);
#sub handle_doctype($$$$$);
#sub handle_externent($$$$);

#__DATA__

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

sub get_result($$) {
	my($self)=@_;
	return($self->{DEPS});
}

sub get_root($) {
	my($self)=@_;
	return($self->{ROOT});
}

sub set_root($$) {
	my($self,$valx)=@_;
	$self->{ROOT}=$valx;
	$self->{DEPS}->node_insert($valx);
}

sub get_search_path($) {
	my($self)=@_;
	return($self->{SEARCH_PATH});
}

sub set_search_path($$) {
	my($self,$valx)=@_;
	$self->{SEARCH_PATH}=$valx;
}

sub handle_doctype($$$$$) {
	my($self,$name,$sysid,$pubid,$internal)=@_;
#	Meta::Utils::Output::print("in handle_doctype\n");
	if($sysid ne "") {
		my($name)="dtdx/".$sysid;
		$self->{DEPS}->node_insert($name);
		$self->{DEPS}->edge_insert($self->get_root(),$name);
	}
}

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

__END__

=head1 NAME

Meta::Xml::Parsers::Deps - dependency analyzer for XML files.

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

	MANIFEST: Deps.pm
	PROJECT: meta
	VERSION: 0.13

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Deps qw();
	my($deps_parser)=Meta::Xml::Parsers::Deps->new();
	$deps_parser->parsefile($file);
	my($deps)=$desp_parser->get_result();

=head1 DESCRIPTION

This is an expat based parser whose sole purpose is finiding dependencies
for xml files.

=head1 FUNCTIONS

	new($)
	get_result($)
	get_root($)
	set_root($$)
	handle_doctype($$$$$)
	handle_externent($$$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a parser.

=item B<get_result($)>

This will return the dependency object which is the result of the parse.

=item B<get_root($)>

This method will retrieve the root node for the dependency object.

=item B<set_root($$)>

This will set the root node that the deps will be attached to.

=item B<get_search_path($)>

This method will retrieve the baseline relative path where this
parser thinks the deps are.

=item B<set_search_path($$)>

This method will set the search path.

=item B<handle_doctype($$$$$)>

This method will handle the document type declarations and will add the
dependency on the dtd to the deps object.

=item B<handle_externent($$$$)>

This method will handle external entities.
Remember that in a Deps parser we do not wish to process the external
entity (if we had access to the graph we would have made sure that
the file existed in the graph but since we dont we just omit it as
dependency).

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV real deps for docbook files
	0.01 MV fix up xml parsers
	0.02 MV spelling and papers
	0.03 MV finish lit database and convert DocBook to SGML
	0.04 MV XML rules
	0.05 MV perl packaging
	0.06 MV perl packaging
	0.07 MV PDMT
	0.08 MV md5 project
	0.09 MV database
	0.10 MV perl module versions in files
	0.11 MV movies and small fixes
	0.12 MV thumbnail user interface
	0.13 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
