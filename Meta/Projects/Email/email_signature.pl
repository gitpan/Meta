#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Info::Author qw();
use Meta::Utils::Output qw();
use Meta::Template::Sub qw();
use Meta::Utils::File::File qw();
use Meta::Baseline::Aegis qw();
use XML::LibXSLT qw();
use XML::LibXML qw();

my($xml_file,$xslt_file,$outf);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("author_file","what author/XML file to use as input ?","xmlx/author/author.xml",\$xml_file);
$opts->def_devf("xslt_file","what XSL file to use for the transformation ?","xslt/signature.xsl",\$xslt_file);
$opts->def_stri("output_file","what output file to write ?","[% home_dir %]/.signature",\$outf);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

$xml_file=Meta::Baseline::Aegis::which($xml_file);
$xslt_file=Meta::Baseline::Aegis::which($xslt_file);
$outf=Meta::Template::Sub::interpolate($outf);

my($parser)=XML::LibXML->new();
my($xslt)=XML::LibXSLT->new();
my($source)=$parser->parse_file($xml_file);
my($style_doc)=$parser->parse_file($xslt_file);
my($stylesheet)=$xslt->parse_stylesheet($style_doc);
my($results)=$stylesheet->transform($source);
my($out)=$stylesheet->output_string($results);
Meta::Utils::File::File::save($outf,$out);

#my($author)=Meta::Info::Author->new_deve($file);
#Meta::Utils::File::File::save($outf,$author->get_email_signature());
#Meta::Utils::Output::print($author->get_email_signature());

Meta::Utils::System::exit(1);

__END__

=head1 NAME

email_signature.pl - provide you with a signature fit for an email.

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

	MANIFEST: email_signature.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	email_signature.pl [options]

=head1 DESCRIPTION

This program assumes that you're using an XML/author file to store
all of your personal information (email, name, address etc...).
It reads this information and provides you with a text which looks
good as a signature at the end of your emails. You can use this
software from your email client directly if it supports running an
external program to provide your signature.

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

=item B<author_file> (type: devf, default: xmlx/author/author.xml)

what author/XML file to use as input ?

=item B<xslt_file> (type: devf, default: xslt/signature.xsl)

what XSL file to use for the transformation ?

=item B<output_file> (type: stri, default: [% home_dir %]/.signature)

what output file to write ?

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

	0.00 MV database
	0.01 MV perl module versions in files
	0.02 MV thumbnail user interface
	0.03 MV more thumbnail issues
	0.04 MV website construction
	0.05 MV improve the movie db xml
	0.06 MV web site automation
	0.07 MV SEE ALSO section fix
	0.08 MV move tests to modules
	0.09 MV bring movie data
	0.10 MV web site development

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Info::Author(3), Meta::Template::Sub(3), Meta::Utils::File::File(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), XML::LibXML(3), XML::LibXSLT(3), strict(3)

=head1 TODO

Nothing.
