#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Tool::Fhist qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(1);
$opts->set_free_stri("[history]");
$opts->set_free_mini(1);
$opts->set_free_maxi(1);
$opts->analyze(\@ARGV);

my($history)=($ARGV[0]);
my($scod)=Meta::Tool::Fhist::query($history);
Meta::Utils::System::exit($scod);

__END__

=head1 NAME

base_aegi_conf_history_query_command.pl - query the history of a file.

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

	MANIFEST: base_aegi_conf_history_query_command.pl
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	base_aegi_conf_history_query_command.pl

=head1 DESCRIPTION

This command will query the history subsystem about the history of a specific
file.

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

minimum of [1] free arguments required
no maximum limit on number of free arguments placed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV more harsh checks on perl code
	0.05 MV fix todo items look in pod documentation
	0.06 MV silense all tests
	0.07 MV fix up the rule system
	0.08 MV Java simulation framework
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV revision change
	0.14 MV all fhist stuff into Fhist.pm
	0.15 MV languages.pl test online
	0.16 MV perl packaging
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

Meta::Tool::Fhist(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.