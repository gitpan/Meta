#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Xml::Dom qw();
use Meta::Lang::Xml::Xml qw();

my($verb,$file,$vali);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->def_devf("file","where is the xml db file ?","xmlx/chess/chess.xml",\$file);
$opts->def_bool("vali","use a validating parser ?",0,\$vali);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

if($verb) {
	Meta::Utils::Output::print("Analyzing...\n");
}
Meta::Lang::Xml::Xml::setup_path();
my($file)=Meta::Baseline::Aegis::which($file);
my($parser)=Meta::Xml::Dom->new_vali($vali);
my($doc)=$parser->parsefile($file);
 
my($opponent_number)=$doc->getElementsByTagName("opponent")->getLength();
my($game_number)=$doc->getElementsByTagName("game")->getLength();

Meta::Utils::Output::print("number of opponents is [".$opponent_number."]\n");
Meta::Utils::Output::print("number of games is [".$game_number."]\n");

Meta::Utils::System::exit(1);

__END__

=head1 NAME

chess_stats.pl - show statistics from my private xml chess database.

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

	MANIFEST: chess_stats.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	chess_stats.pl [options]

=head1 DESCRIPTION

This script reports various statistics about chess games from my provate
chess xml database.
Currently it reports these metrics:
0. Number of opponents in the database.
1. Number of games in the database.
2. Total number of games of every type (won,lost,pat,tie).
3. State against each opponent.

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

=item B<verbose> (type: bool, default: 0)

noisy or quiet ?

=item B<file> (type: devf, default: xmlx/chess/chess.xml)

where is the xml db file ?

=item B<vali> (type: bool, default: 0)

use a validating parser ?

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

	0.00 MV fix database problems
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV more Class method generation
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Lang::Xml::Xml(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), Meta::Xml::Dom(3), strict(3)

=head1 TODO

-do totals for games of each type.

-do stats against each player.
