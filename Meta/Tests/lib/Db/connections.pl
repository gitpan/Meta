#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Db::Connections qw();
use Meta::Baseline::Aegis qw();
use Meta::Xml::Parsers::Connections qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($parser)=Meta::Xml::Parsers::Connections->new();
my($file)=Meta::Baseline::Aegis::which("xmlx/connections/connections.xml");
$parser->parsefile($file);
my($obje)=$parser->get_result();
$obje->print(Meta::Utils::Output::get_file());

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

connections.pl - testing program for the Meta::Db::Connections.pm module.

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

	MANIFEST: connections.pl
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	connections.pl

=head1 DESCRIPTION

This is a test suite for the Connections class.

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

	0.00 MV put ALL tests back and light the tree
	0.01 MV silense all tests
	0.02 MV more perl code quality
	0.03 MV perl code quality
	0.04 MV more perl quality
	0.05 MV more perl quality
	0.06 MV revision change
	0.07 MV languages.pl test online
	0.08 MV history change
	0.09 MV perl reorganization
	0.10 MV good xml support
	0.11 MV fix up xml parsers
	0.12 MV perl packaging
	0.13 MV XSLT, website etc
	0.14 MV PDMT
	0.15 MV license issues
	0.16 MV md5 project
	0.17 MV database
	0.18 MV perl module versions in files
	0.19 MV more thumbnail code
	0.20 MV thumbnail user interface
	0.21 MV more thumbnail issues
	0.22 MV website construction
	0.23 MV improve the movie db xml
	0.24 MV web site automation
	0.25 MV SEE ALSO section fix
	0.26 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Test(3), Meta::Db::Connections(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::Parsers::Connections(3), strict(3)

=head1 TODO

Nothing.
