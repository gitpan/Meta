#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Baseline::Cook qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($cook)=Meta::Baseline::Cook->new();
my($search_list)=$cook->search_list();
Meta::Utils::Output::print("search_list is [".$search_list."]\n");
my($inte)=$cook->inte();
Meta::Utils::Output::print("inte is [".$inte."]\n");
my($deve)=$cook->deve();
Meta::Utils::Output::print("deve is [".$deve."]\n");
my($temp_dir)=$cook->temp_dir();
Meta::Utils::Output::print("temp_dir is [".$temp_dir."]\n");

my($graph)=Meta::Baseline::Cook::read_deps_full("deps/html/projects/Website/computing.deps");
Meta::Utils::Output::print("number of nodes is [".$graph->node_size()."]\n");

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

cook.pl - testing program for the Meta::Baseline::Cook.pm module.

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

	MANIFEST: cook.pl
	PROJECT: meta
	VERSION: 0.21

=head1 SYNOPSIS

	cook.pl

=head1 DESCRIPTION

This script tests the Meta::Baseline::Cook module.
This just prints out some statistics out of that module.

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
	0.03 MV fix up the cook module
	0.04 MV perl code quality
	0.05 MV more perl quality
	0.06 MV more perl quality
	0.07 MV revision change
	0.08 MV languages.pl test online
	0.09 MV html site update
	0.10 MV perl packaging
	0.11 MV license issues
	0.12 MV md5 project
	0.13 MV database
	0.14 MV perl module versions in files
	0.15 MV thumbnail user interface
	0.16 MV more thumbnail issues
	0.17 MV website construction
	0.18 MV improve the movie db xml
	0.19 MV web site automation
	0.20 MV SEE ALSO section fix
	0.21 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Cook(3), Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
