#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use XML::XPath::XMLParser qw();
use Meta::Utils::Output qw();
use Meta::Lang::Xml::Xml qw();

my($file);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("file","what contacts file to use ?","xmlx/contacts/contacts.xml",\$file);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

#Meta::Lang::Xml::Xml::setup_path();
my($parser)=XML::XPath::XMLParser->new(filename=>$file);
my($root_node)=$parser->parse();
my($nodes)=$parser->find('/contacts/contact');

my($size)=$nodes->size();
Meta::Utils::Output::print("size is [".$size."]\n");
#foreach my $node ($nodeset->get_nodelist)

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
	VERSION: 0.00

=head1 SYNOPSIS

	contacts_export.pl [options]

=head1 DESCRIPTION

This script will read an XML/contacts file and will export it to a particular
formats. Formats which are planned to be supported:
1. kmail - a file that you could use so that you will have all your
	contact information in kmail. This is a text file which only
	has "John Doe john@doe.com" type entries.
2. evolution - a file that you could use so that you will have all
	your contact information in evolution. In essense this file
	is a Bekeley DB file and I use perl modules for manipulating
	Berkeley DB files to do that.
3. gnokii - a file fit to be transferred using gnokii to a Nokia cellular
	phone (I still dont know what that format is and still is still
	not implemented).

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

=item B<history> (type: bool, default: 0)

show history and exit

=item B<file> (type: devf, default: xmlx/contacts/contacts.xml)

what contacts file to use ?

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

=head1 SEE ALSO

Meta::Lang::Xml::Xml(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), XML::XPath::XMLParser(3), strict(3)

=head1 TODO

Nothing.
