#!/bin/echo This is a perl module and should not be run

package Meta::Info::Author;

use strict qw(vars refs subs);
use Meta::Info::Affiliation qw();
use Meta::Xml::Parsers::Author qw();
use Meta::Baseline::Aegis qw();
use Meta::Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.15";
@ISA=qw();

#sub BEGIN();
#sub init($);
#sub new_file($);
#sub new_deve($);
#sub get_perl_makefile($);
#sub get_perl_source($);
#sub get_perl_copyright($);
#sub get_email_signature($);
#sub get_vcard($);
#sub get_html_copyright($);
#sub get_html_info($);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new_with_init("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_honorific",
		-java=>"_firstname",
		-java=>"_surname",
		-java=>"_cpanid",
		-java=>"_cpanpassword",
		-java=>"_cpanemail",
		-java=>"_sourceforgeid",
		-java=>"_sourceforgepassword",
		-java=>"_sourceforgeemail",
		-java=>"_advogatoid",
		-java=>"_advogatopassword",
		-java=>"_advogatoemail",
		-java=>"_initials",
		-java=>"_handle",
		-java=>"_homepage",
		-java=>"_affiliation",
	);
	Meta::Class::MethodMaker->print([
		"honorific",
		"firstname",
		"surname",
		"cpanid",
		"cpanpassword",
		"cpanemail",
		"sourceforgeid",
		"sourceforgepassword",
		"sourceforgeemail",
		"advogatoid",
		"advogatopassword",
		"advogatoemail",
		"initials",
		"handle",
		"homepage",
		"affiliation",
	]);
}

sub init($) {
	my($self)=@_;
	$self->set_affiliation(Meta::Info::Affiliation->new());
}

sub new_file($) {
	my($file)=@_;
	my($parser)=Meta::Xml::Parsers::Author->new();
	$parser->parsefile($file);
	return($parser->get_result());
}

sub new_deve($) {
	my($modu)=@_;
	my($file)=Meta::Baseline::Aegis::which($modu);
	return(new_file($file));
}

sub get_perl_makefile($) {
	my($self)=@_;
	return($self->get_firstname()." ".$self->get_surname()." <".$self->get_cpanemail().">");
}

sub get_perl_source($) {
	my($self)=@_;
	return(
		"\tName: ".$self->get_firstname()." ".$self->get_surname()."\n".
		"\tEmail: mailto:".$self->get_cpanemail()."\n".
		"\tWWW: ".$self->get_homepage()."\n".
		"\tCPAN id: ".$self->get_cpanid()."\n"
	);
}

sub get_perl_copyright($) {
	my($self)=@_;
	return("Copyright (C) ".Meta::Baseline::Aegis::copyright_years()." ".$self->get_firstname()." ".$self->get_surname().";\nAll rights reserved.\n");
}

sub get_email_signature($) {
	my($self)=@_;
	return(
		"Name: ".$self->get_firstname()." ".$self->get_surname()."\n".
#		"Title: ".$self->get_title()."\n".
		"Homepage: ".$self->get_homepage()."\n".
		"CPAN id: ".$self->get_cpanid()." (http://cpan.org,\ mailto:".$self->get_cpanemail().")\n".
		"sourceforge id: ".$self->get_sourceforgeid()." (http://www.sourceforge.net,\ mailto:".$self->get_sourceforgeemail().")\n".
		"advogator id:".$self->get_advogatoid()." (http://www.advogato.org,\ mailto:".$self->get_advogatoemail().")\n"
	);
}

sub get_vcard($) {
	my($self)=@_;
	return("VCARD");
}

sub get_html_copyright($) {
	my($self)=@_;
	return("Copyright (C) ".Meta::Baseline::Aegis::copyright_years()." ".
		"<a href=\"mailto:".$self->get_affiliation()->get_address()->get_email()."\">".
		$self->get_firstname()." ".$self->get_surname()."</a>".
		"\;\ All rights reserved."
	);
}

sub get_html_info($) {
	my($self)=@_;
	return(
		"<li><a href=\"".$self->get_homepage()."\">\n".
		"Home page: ".$self->get_homepage()."</a></li>\n".
		"<li><a href=\"mailto: ".$self->get_affiliation()->get_address()->get_email()."\">\n".
		"Email: ".$self->get_affiliation()->get_address()->get_email()."</a></li>"
	);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Info::Author - object oriented author personal information.

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
	VERSION: 0.15

=head1 SYNOPSIS

	package foo;
	use Meta::Info::Author qw();
	my($object)=Meta::Info::Author->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class provides author information according to the DocBook DTD.

=head1 FUNCTIONS

	BEGIN()
	init($)
	new_file($)
	new_deve($)
	get_perl_makefile($)
	get_perl_source($)
	get_perl_copyright($)
	get_email_signature($)
	get_vcard($)
	get_html_copyright($)
	get_html_info($)
	TEST($);

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method builds the attribute access method for this class.
The attributes are:
0. "honorific"
1. "firstname"
2. "surname"
3. "cpanid"
4. "cpanpasswd"
5. "cpanemail"
6. "sourceforgeid"
7. "sourceforgepasswd"
8. "sourceforgeemail"
9. "advogatoid"
10. "advogatopasswd"
11." advogatoemail"
12. "initials"
13. "handle"
14. "homepage"
15. "affiliation".
For their meaning please consult the Docbook DTD.

=item B<new_file($)>

This method will create a new instance from an XML/author file.

=item B<new_deve($)>

This method will create a new instance from an XML/author file
which will be located in the development path.

=item B<get_perl_makefile($)>

This method will return the name of the author suitable for inclusion in
a perl makefile (Makefile.PL).

=item B<get_perl_source($)>

This method will return the name of the author suitable for inclusion
in a perl source file under a POD AUTHOR section.

=item B<get_perl_copyright($)>

This method will return the perl copyright notice for this author.
in a perl source file under a POD COPYRIGHT section.
The copyright years are taken from Aegis.

=item B<get_email_signature($)>

This method will provide you with a text fitting for an email signature.

=item B<get_vcard($)>

This method will provide you with a string which contains VCARD information
that could be sent (for instance) as an email attachment so the recipient will
automatically have your details in his contacts software.

Here is a sample VCARD:
-----------------------
BEGIN:VCARD
X-EVOLUTION-FILE-AS:Falk, Rachel
FN:Rachel Falk
N:Falk;Rachel
TEL;WORK;VOICE:02-5892301
TEL;CELL:050-256655
EMAIL;INTERNET:rachel.falk@intel.com
ORG:Intel
NOTE;QUOTED-PRINTABLE:Cvish Begin=0ATake light to right=0AUp the ramp=0AFirst light Left=0AReach=
industrial zone=0AFirst right=0AFirst Left=0APass 500 meters=0AIntel buil=
ding on right
CATEGORIES:Business
UID:file:///local/home/mark/evolution/local/Contacts/addressbook.db/pas-id-3B73B04400000015
END:VCARD
-----------------------

=item B<get_html_copyright($)>

Get a copyright suitable for inserting into an HTML page.

=item B<get_html_info($)>

Get info suitable for inclusing in an HTML page.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging
	0.01 MV perl packaging again
	0.02 MV PDMT
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV more Class method generation
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues
	0.10 MV md5 project
	0.11 MV website construction
	0.12 MV improve the movie db xml
	0.13 MV web site development
	0.14 MV web site automation
	0.15 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Class::MethodMaker(3), Meta::Info::Affiliation(3), Meta::Xml::Parsers::Author(3), strict(3)

=head1 TODO

-make the signature routine produce a better signature.

-make the VCARD method do its thing.

-add more info and track the Docbook DTD more strictly.
