#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Lang::Xml - help you with xml related tasks.

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

MANIFEST: Xml.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Lang::Xml qw();>
C<my($object)=Meta::Lang::Xml->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This class will help you with xml related tasks.
0. checking an xml file for correctness according to dtd.

=head1 EXPORTS

C<get_prefix()>
C<get_search_list($)>
C<setup($)>
C<setup_path()>
C<fail_check($)>
C<check($$$)>
C<c2deps($)>
C<c2chun($)>
C<odeps($$$$)>
C<resolve_dtd($)>
C<resolve_xml($)>
C<get_type($)>

=cut

package Meta::Lang::Xml;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT $errors);
use XML::Checker::Parser qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::System qw();
use Meta::Development::Deps qw();
use XML::DOM qw();
use Meta::Xml::Parsers::Deps qw();
use Meta::Utils::Output qw();
use Meta::Utils::Parse::Text qw();
use Meta::Xml::Parsers::Type qw();
use Meta::Xml::Parsers::Checker qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub get_prefix();
#sub get_search_list($);
#sub setup($);
#sub setup_path();
#sub fail_check($);
#sub check($);
#sub c2deps($);
#sub c2chun($);
#sub odeps($$$$);
#sub resolve_dtd($);
#sub resolve_xml($);
#sub get_type($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<get_prefix()>

This method returns the prefix for xml related material in the baseline.

=cut

sub get_prefix() {
	return("");
}

=item B<get_search_list($)>

This method gives you the search list for XML processing.
The input is the original path.

=cut

sub get_search_list($) {
	my($path)=@_;
	my(@search_path)=split('\:',$path);
	my(@list);
	for(my($i)=0;$i<=$#search_path;$i++) {
		my($curr)=$search_path[$i];
		#Meta::Utils::Output::print("adding [".$curr."]\n");
		#push(@list,$curr);
		#push(@list,$curr."/sgml");
		#push(@list,$curr."/xmlx");
		push(@list,$curr."/dtdx");
		#push(@list,$curr."/dslx");
		#push(@list,$curr."/chun/sgml");
	}
	return(\@list);
}

=item B<setup($)>

This method gets a path and sets up the search path according to this path.

=cut

sub setup($) {
	my($path)=@_;
	my($list)=&get_search_list($path);
	XML::Checker::Parser::set_sgml_search_path(@$list);
}

=item B<setup_path()>

This method will setup path for validating parsers accoding to the baseline.

=cut

sub setup_path() {
	my($path)=Meta::Baseline::Aegis::search_path();
	my($list)=&get_search_list($path);
	XML::Checker::Parser::set_sgml_search_path(@$list);
}

=item B<fail_check($)>

This method will be called by the XML::Checker::Parser if there is an error.
We just print the error message and thats it. We dont die!!! (remmember we
dont die in any routine as it is bad practice...).

=cut

sub fail_check($) {
	my($code)=shift;
	XML::Checker::print_error($code,@_);
	$errors++;
}

=item B<check($)>

This method checks an XML file for structure according to a DTD. This is
achieved by using the XML::Checker::Parser class which is a validating parser
to parse the file. The parser will print the errors to STDERR if any are
encountered (which is good for us) and will return the number of errros
encountered via the global varialbe $errors.

=cut

sub check($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($modu)=$buil->get_modu();
	my($path)=$buil->get_path();
	&setup($path);
	my($parser)=Meta::Xml::Parsers::Checker->new();
	$errors=0;
	eval {
		local($XML::Checker::FAIL)=\&fail_check;
		$parser->parsefile($srcx);
	};
	if($@) {
		Meta::Utils::Output::print("unknown error [".$@."]\n");
		return(0);
	}
	if($errors>0) {
		return(0);
	} else {
		return(1);
	}
}

=item B<c2deps($)>

This method reads a source xml file and produces a deps object which describes
the dependencies for that file.
This method uses an Expat parser to do it which is quite cheap.

=cut

sub c2deps($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($modu)=$buil->get_modu();
	my($parser)=Meta::Xml::Parsers::Deps->new();
	$parser->set_search_path(&get_prefix());
	$parser->set_root($modu);
	$parser->parsefile($srcx);
	return($parser->get_result());
}

=item B<c2chun($)>

This method receives an XML file and removes the DOCTYPE declarations from it so
it could be included in another SGML file.

=cut

sub c2chun($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($modu)=$buil->get_modu();
	my($targ)=$buil->get_targ();
	my($path)=$buil->get_path();
	my($parser)=Meta::Utils::Parse::Text->new();
	$parser->init_file($srcx);
	my($found)=0;
	open(FILE,"> ".$targ) || Meta::Utils::System::die("unable to open file [".$targ."]");
	while(!$parser->get_over()) {
		my($line)=$parser->get_line();
		if($line=~/^\<\!DOCTYPE/) {
			$found=1;
		} else {
			print FILE $line."\n";
		}
		$parser->next();
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$targ."]");
	if(!$found) {
		Meta::Utils::Output::print("unable to find DOCTYPE in document\n");
	}
	return($found);
}

=item B<odeps($$$$)>

This method reads a source xml file and produces a deps object which describes
the dependencies for that file. This method is doing it using a DOM parser
which is quite expensive (it stores the entire docbument in RAM and other
problems...).

=cut

sub odeps($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	&setup_path();

	my($graph)=Meta::Development::Deps->new();
	$graph->node_insert($modu);

	my($parser)=XML::DOM::Parser->new();
	my($doc)=$parser->parsefile($srcx);
	if(!defined($doc)) {
		Meta::Utils::Output::print("unable to parse [".$doc."]\n");
		return(undef);
	}
	my($type)=$doc->getDoctype();
	if(defined($type)) {#there is a type to the xml document
		my($system_id)=$type->getSysId();
#		Meta::Utils::Output::print($system_id);
		my($a_system_id)=&resolve_dtd($system_id);
#		Meta::Utils::Output::print($a_system_id);
		$graph->node_insert($a_system_id);
		$graph->edge_insert($modu,$a_system_id);
		my($entities);
		$entities=$type->getEntities();
		for(my($i)=0;$i<$entities->getLength();$i++) {
			my($entity)=$entities->item($i);
			my($system_id)=$entity->getSysId();
#			Meta::Utils::Output::print($system_id);
			my($a_system_id)=&resolve_xml($system_id);
#			Meta::Utils::Output::print($a_system_id);
			$graph->node_insert($a_system_id);
			$graph->edge_insert($modu,$a_system_id);
			if(!defined($system_id)) {
			Meta::Utils::System::die("no system id");
			}
		}
	}
	return($graph);
}

=item B<resolve_dtd($)>

This method recevies a system id of a dtd file and resolves it to a physical
file. This method should (potentialy) also check that the dtd is a member
of the project.

=cut

sub resolve_dtd($) {
	my($id)=@_;
	return("dtdx/".$id);
}

=item B<resolve_xml($)>

This method recevies a system id of an xml file and resolves it to a physical
file. This method should (potentialy) also check that the xml is a member
of the project.

=cut

sub resolve_xml($) {
	my($id)=@_;
	return("xmlx/".$id);
}

=item B<get_type($)>

This method receives a file name of an XML document and returns the type
of the document (the highest element in it).

=cut

sub get_type($) {
	my($srcx)=@_;
	my($parser)=Meta::Xml::Parsers::Type->new();
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
