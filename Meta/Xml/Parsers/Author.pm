#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Author;

use strict qw(vars refs subs);
use Meta::Info::Author qw();
use Meta::Xml::Parsers::Collector qw();
#use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.12";
@ISA=qw(Meta::Xml::Parsers::Collector);

#sub new($);
#sub get_result($);
#sub handle_start($$);
#sub handle_end($$);
#sub handle_endchar($$$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Xml::Parsers::Collector->new();
	$self->setHandlers(
		'Start'=>\&handle_start,
		'End'=>\&handle_end,
	);
	bless($self,$clas);
	$self->{TEMP_AUTHOR}=defined;
	return($self);
}

sub get_result($) {
	my($self)=@_;
	return($self->{TEMP_AUTHOR});
}

sub handle_start($$) {
	my($self,$elem)=@_;
	$self->SUPER::handle_start($elem);
	#Meta::Utils::Output::print("in handle_start with elem [".$elem."]\n");
	if($elem eq "author") {
		$self->{TEMP_AUTHOR}=Meta::Info::Author->new();
	}
}

sub handle_end($$) {
	my($self,$elem)=@_;
	$self->SUPER::handle_end($elem);
}

sub handle_endchar($$$) {
	my($self,$elem,$name)=@_;
#	Meta::Utils::Output::print("in here with elem [".$elem."],[".join(',',$self->context())."]\n");
	$self->SUPER::handle_endchar($elem);
	if($self->in_context("author.honorific",$name)) {
		$self->{TEMP_AUTHOR}->set_honorific($elem);
	}
	if($self->in_context("author.firstname",$name)) {
		$self->{TEMP_AUTHOR}->set_firstname($elem);
	}
	if($self->in_context("author.surname",$name)) {
		$self->{TEMP_AUTHOR}->set_surname($elem);
	}
	if($self->in_context("author.title",$name)) {
		$self->{TEMP_AUTHOR}->set_title($elem);
	}
	if($self->in_context("author.cpanid",$name)) {
		$self->{TEMP_AUTHOR}->set_cpanid($elem);
	}
	if($self->in_context("author.cpanpassword",$name)) {
		$self->{TEMP_AUTHOR}->set_cpanpassword($elem);
	}
	if($self->in_context("author.cpanemail",$name)) {
		$self->{TEMP_AUTHOR}->set_cpanemail($elem);
	}
	if($self->in_context("author.sourceforgeid",$name)) {
		$self->{TEMP_AUTHOR}->set_sourceforgeid($elem);
	}
	if($self->in_context("author.sourceforgepassword",$name)) {
		$self->{TEMP_AUTHOR}->set_sourceforgepassword($elem);
	}
	if($self->in_context("author.sourceforgeemail",$name)) {
		$self->{TEMP_AUTHOR}->set_sourceforgeemail($elem);
	}
	if($self->in_context("author.advogatoid",$name)) {
		$self->{TEMP_AUTHOR}->set_advogatoid($elem);
	}
	if($self->in_context("author.advogatopassword",$name)) {
		$self->{TEMP_AUTHOR}->set_advogatopassword($elem);
	}
	if($self->in_context("author.advogatoemail",$name)) {
		$self->{TEMP_AUTHOR}->set_advogatoemail($elem);
	}
	if($self->in_context("author.initials",$name)) {
		$self->{TEMP_AUTHOR}->set_initials($elem);
	}
	if($self->in_context("author.handle",$name)) {
		$self->{TEMP_AUTHOR}->set_handle($elem);
	}
	if($self->in_context("author.homepage",$name)) {
		$self->{TEMP_AUTHOR}->set_homepage($elem);
	}
	if($self->in_context("author.affiliation.orgname",$name)) {
		$self->{TEMP_AUTHOR}->get_affiliation()->set_orgname($elem);
	}
	if($self->in_context("author.affiliation.address.email",$name)) {
		$self->{TEMP_AUTHOR}->get_affiliation()->get_address()->set_email($elem);
	}
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Xml::Parsers::Author - Object to parse an XML/author file.

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

	MANIFEST: Author.pm
	PROJECT: meta
	VERSION: 0.12

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Author qw();
	my($def_parser)=Meta::Xml::Parsers::Author->new();
	$def_parser->parsefile($file);
	my($def)=$def_parser->get_result();

=head1 DESCRIPTION

This object will create a Meta::Info::Author for you from an XML/author file. 

=head1 FUNCTIONS

	new($)
	get_result($)
	handle_start($$)
	handle_end($$)
	handle_endchar($$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a parser.

=item B<get_result($)>

This method will retrieve the result of the parsing process.

=item B<handle_start($$)>

This will handle start tags.

=item B<handle_end($$)>

This will handle end tags.
This currently does nothing.

=item B<handle_endchar($$$)>

This will handle actual text.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Meta::Xml::Parsers::Collector(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging again
	0.01 MV perl packaging again
	0.02 MV fix database problems
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV thumbnail user interface
	0.08 MV more thumbnail issues
	0.09 MV website construction
	0.10 MV web site automation
	0.11 MV SEE ALSO section fix
	0.12 MV web site development

=head1 SEE ALSO

Meta::Info::Author(3), Meta::Xml::Parsers::Collector(3), strict(3)

=head1 TODO

Nothing.
