#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use Meta::Lang::Xml::Xml qw();
use Meta::Baseline::Aegis qw();
use XML::Parser qw();
use XML::XPath qw();
use IO::File qw();
use IO::Filter::sort qw();

my($file,$verb,$sort,$outf);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("file","what contacts file to use ?","xmlx/contacts/contacts.xml",\$file);
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->def_bool("sort","sort the output to kmail ?",0,\$sort);
$opts->def_newf("outf","what output file to generate ?","/tmp/kmail_addressbook",\$outf);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($io);
if($sort) {
	$io=IO::Filter::sort->new($outf,"w");
} else {
	$io=IO::File->new($outf,"w");
}
if(!defined($io)) {
	Meta::Utils::System::die("unable to open output file [".$outf."]");
}

my($prefix)="# kmail addressbook file\n";
$io->print($prefix);

Meta::Lang::Xml::Xml::setup_path();
my($file)=Meta::Baseline::Aegis::which($file);
my($par)=XML::Parser->new();
if(!defined($par)) {
	Meta::Utils::System::die("unable to create XML::Parser");
}
my($parser)=XML::XPath::XMLParser->new(filename=>$file,parser=>$par);
if(!defined($parser)) {
	Meta::Utils::System::die("unable to create XML::XPath::XMLParser");
}
my($root_node)=$parser->parse();
my($nodes)=$root_node->find('/contacts/contact');
#my($nodes)=$root_node->find('/contacts/contact/emails/email/value');

my($size)=$nodes->size();
if($verb) {
	Meta::Utils::Output::print("size is [".$size."]\n");
}
foreach my $node ($nodes->get_nodelist()) {
	my($emails)=$node->find('emails/email/value');
	my($use_firstname)=undef;
	my($firstname)=$node->find('firstname');
	if($firstname->size()) {
		$use_firstname=$firstname->get_node(0)->getChildNode(1)->getValue();
	}
	my($use_surname)=undef;
	my($surname)=$node->find('surname');
	if($surname->size()) {
		$use_surname=$surname->get_node(0)->getChildNode(1)->getValue();
	}
	my($use_company)=undef;
	my($company)=$node->find('company');
	if($company->size()) {
		$use_company=$company->get_node(0)->getChildNode(1)->getValue();
	}
	my($use_title)=undef;
	my($title)=$node->find('title');
	if($title->size()) {
		$use_title=$title->get_node(0)->getChildNode(1)->getValue();
	}
	my($name)=undef;
	if(defined($use_firstname) && !defined($use_surname)) {
		$name=$use_firstname;
	}
	if(defined($use_firstname) && defined($use_surname)) {
		$name=join(' ',$use_firstname,$use_surname);
	}
	if(defined($use_company)) {
		$name.=' ('.$use_company.')';
	}
	if(defined($use_title)) {
		$name=$use_title;
	}
	foreach my $email ($emails->get_nodelist()) {
		my($email_text)=$email->getChildNode(1)->getValue();
		$io->print($name. " <".$email_text.">\n");
#		Meta::Utils::Output::print($name. " <".$email_text.">\n");
	}
#	my($parent)=$node->getParentNode()->getParentNode()->getParentNode();
#	my($set)=$parent->find("firstname");
#	Meta::Utils::Output::print("set is [".$set."]\n");
}
$io->close();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

contacts_export.pl - export contact information in various formats.

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

	MANIFEST: contacts_export.pl
	PROJECT: meta
	VERSION: 0.03

=head1 SYNOPSIS

	contacts_export.pl [options]

=head1 DESCRIPTION

This script will read an XML/contacts file and will export it to a particular
formats. Formats which are planned to be supported:
1. kmail - a file that you could use so that you will have all your
	contact information in kmail. This is a text file which only
	has "John Doe john@doe.com\n" type entries.
2. evolution - a file that you could use so that you will have all
	your contact information in evolution. In essense this file
	is a Bekeley DB file and I use perl modules for manipulating
	Berkeley DB files to do that.
3. gnokii - a file fit to be transferred using gnokii to a Nokia cellular
	phone (I still dont know what that format is and still is still
	not implemented).

Ths use of XML::Parser here is mandatory since if you do not supply your
own parser the XML::XPath uses it's own which cannot do Aegis resolution and so
this kills everything.

Current script only supports the first option (kmail).

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<description> (type: bool, default: 0)

show description and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<file> (type: devf, default: xmlx/contacts/contacts.xml)

what contacts file to use ?

=item B<verbose> (type: bool, default: 0)

noisy or quiet ?

=item B<sort> (type: bool, default: 0)

sort the output to kmail ?

=item B<outf> (type: newf, default: /tmp/kmail_addressbook)

what output file to generate ?

=back

no free arguments are allowed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV put all tests in modules
	0.01 MV move tests to modules
	0.02 MV download scripts
	0.03 MV move tests into modules

=head1 SEE ALSO

IO::File(3), IO::Filter::sort(3), Meta::Baseline::Aegis(3), Meta::Lang::Xml::Xml(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), XML::Parser(3), XML::XPath(3), strict(3)

=head1 TODO

-the sorting option somehow does not work (complain of an error - maybe it's a bug of IO::Filter::sort. Check it out).
