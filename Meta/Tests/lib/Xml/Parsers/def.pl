#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Xml::Parsers::Def qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($file)=Meta::Baseline::Aegis::which("xmlx/def/contacts.xml");
my($pars)=Meta::Xml::Parsers::Def->new();
$pars->parsefile($file);
my($obje)=$pars->get_result();
Meta::Utils::Output::print("got [".$obje->get_tables()->size()."] tables\n");
$obje->print(Meta::Utils::Output::get_file());

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

def.pl - testing program for the Meta::Xml::Parsers::Def.pm module.

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

	MANIFEST: def.pl
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	def.pl

=head1 DESCRIPTION

This will test the Meta::Xml::Parsers::Def.pm module.
Currently it will just read the "xmlx/def/chess.def" file and print out the
resulting Def object.

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
	0.06 MV get graph stuff going
	0.07 MV revision change
	0.08 MV languages.pl test online
	0.09 MV perl reorganization
	0.10 MV fix up xml parsers
	0.11 MV more c++ stuff
	0.12 MV move def to xml directory
	0.13 MV automatic data sets
	0.14 MV perl packaging
	0.15 MV XSLT, website etc
	0.16 MV db inheritance
	0.17 MV license issues
	0.18 MV md5 project
	0.19 MV database
	0.20 MV perl module versions in files
	0.21 MV thumbnail user interface
	0.22 MV more thumbnail issues
	0.23 MV website construction
	0.24 MV improve the movie db xml
	0.25 MV web site automation
	0.26 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::Parsers::Def(3), strict(3)

=head1 TODO

Nothing.
