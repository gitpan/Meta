#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Tool::Xmllint qw();
use Meta::Lang::Xml::Xml qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();
use Meta::Xml::LibXML qw();

my($modu);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_modu("file","what file to check ?",undef,\$modu);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

#my($scod)=Meta::Tool::Xmllint::check_modu($modu);

#my($build)=Meta::Pdmt::BuildInfo->new();
#$build->set_srcx($modu->get_abs_path());
#$build->set_modu($modu->get_name());
#$build->set_path(Meta::Baseline::Aegis::search_path());
#my($scod)=Meta::Lang::Xml::Xml::check($build);

my($parser)=Meta::Xml::LibXML->new_aegis();
$parser->validation(1);
$parser->pedantic_parser(1);
$parser->load_ext_dtd(1);
my($scod)=$parser->check_file($modu->get_abs_path());
#Meta::Utils::Output::print("scod is [".$scod."]\n");

Meta::Utils::System::exit($scod);

__END__

=head1 NAME

xml_lint.pl - check XML files for you.

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

	MANIFEST: xml_lint.pl
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	xml_lint.pl [options]

=head1 DESCRIPTION

This script receives a development module name and checks it for you
using the Meta::Tool::Xmllint module.

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

=item B<file> (type: modu, default: )

what file to check ?

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
	0.02 MV teachers project

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Lang::Xml::Xml(3), Meta::Tool::Xmllint(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::LibXML(3), strict(3)

=head1 TODO

-add method to check using LibXML directly and not xmllint extenral executable.
