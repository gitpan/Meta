#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($search_path)=Meta::Baseline::Aegis::search_path();
Meta::Utils::Output::print("search_path is [".$search_path."]\n");
my($baseline)=Meta::Baseline::Aegis::baseline();
Meta::Utils::Output::print("baseline is [".$baseline."]\n");
my($project)=Meta::Baseline::Aegis::project();
Meta::Utils::Output::print("project is [".$project."]\n");
my($change)=Meta::Baseline::Aegis::change();
Meta::Utils::Output::print("change is [".$change."]\n");
my($version)=Meta::Baseline::Aegis::version();
Meta::Utils::Output::print("version is [".$version."]\n");
my($architecture)=Meta::Baseline::Aegis::architecture();
Meta::Utils::Output::print("architecture is [".$architecture."]\n");
my($state)=Meta::Baseline::Aegis::state();
Meta::Utils::Output::print("state is [".$state."]\n");
my($developer)=Meta::Baseline::Aegis::developer();
Meta::Utils::Output::print("developer is [".$developer."]\n");
my($developer_list)=Meta::Baseline::Aegis::developer_list();
Meta::Utils::Output::print("developer_list is [".$developer_list."]\n");
my($reviewer_list)=Meta::Baseline::Aegis::reviewer_list();
Meta::Utils::Output::print("reviewer_list is [".$reviewer_list."]\n");
my($integrator_list)=Meta::Baseline::Aegis::integrator_list();
Meta::Utils::Output::print("integrator_list is [".$integrator_list."]\n");
my($administrator_list)=Meta::Baseline::Aegis::administrator_list();
Meta::Utils::Output::print("administrator_list is [".$administrator_list."]\n");
my($history_directory)=Meta::Baseline::Aegis::history_directory();
Meta::Utils::Output::print("history_directory is [".$history_directory."]\n");
my($deve)=Meta::Baseline::Aegis::deve();
Meta::Utils::Output::print("deve is [".$deve."]\n");
my($inte)=Meta::Baseline::Aegis::inte();
Meta::Utils::Output::print("inte is [".$inte."]\n");
my($work_dir)=Meta::Baseline::Aegis::work_dir();
Meta::Utils::Output::print("work_dir is [".$work_dir."]\n");
my($file)=Meta::Baseline::Aegis::which_f("/tmp/tmp");
Meta::Utils::Output::print("file is [".$file."]\n");
my($in_change)=Meta::Baseline::Aegis::in_change("txtx/todo/todo.txt");
Meta::Utils::Output::print("in_change todo.txt [".$in_change."]\n");
my($in_change_2)=Meta::Baseline::Aegis::in_change("foo");
Meta::Utils::Output::print("in_change foo [".$in_change_2."]\n");
my($have_aegis)=Meta::Baseline::Aegis::have_aegis();
Meta::Utils::Output::print("have_aegis is [".$have_aegis."]\n");

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

aegis.pl - testing program for the Meta::Baseline::Aegis.pm module.

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

	MANIFEST: aegis.pl
	PROJECT: meta
	VERSION: 0.24

=head1 SYNOPSIS

	aegis.pl

=head1 DESCRIPTION

This script tests the Meta::Baseline::Aegis module.
This just prints out some statistics out of that module.
This does not pring state related information (for instance - the
development_directory feature is only available in development...).

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
	0.03 MV make lilypond work
	0.04 MV perl code quality
	0.05 MV more perl quality
	0.06 MV more perl quality
	0.07 MV revision change
	0.08 MV languages.pl test online
	0.09 MV history change
	0.10 MV PDMT stuff
	0.11 MV perl packaging
	0.12 MV license issues
	0.13 MV md5 project
	0.14 MV database
	0.15 MV perl module versions in files
	0.16 MV graph visualization
	0.17 MV thumbnail user interface
	0.18 MV more thumbnail issues
	0.19 MV website construction
	0.20 MV improve the movie db xml
	0.21 MV web site automation
	0.22 MV SEE ALSO section fix
	0.23 MV move tests to modules
	0.24 MV web site development

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
