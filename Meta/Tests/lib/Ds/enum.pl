#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Ds::Enum qw();
use Meta::Ds::String qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($enum)=Meta::Ds::Enum->new();
my($string_mark)=Meta::Ds::String->new();
$string_mark->set_text("mark");
my($string_doro)=Meta::Ds::String->new();
$string_doro->set_text("doro");
$enum->insert($string_mark);
$enum->insert($string_doro);
$enum->print(Meta::Utils::Output::get_file());
Meta::Utils::Output::print("mark is elemet [".$enum->has("mark")."]\n");
Meta::Utils::Output::print("string_mark is elemet [".$enum->has($string_mark)."]\n");
Meta::Utils::Output::print("size of enum is [".$enum->size()."]\n");

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

enum.pl - testing program for the Meta::Ds::Enum.pm module.

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

	MANIFEST: enum.pl
	PROJECT: meta
	VERSION: 0.20

=head1 SYNOPSIS

	enum.pl

=head1 DESCRIPTION

This will test the Meta::Ds::Enum.pm module.
Currently it creates an object and queries about values.

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
	0.06 MV get basic Simul up and running
	0.07 MV revision change
	0.08 MV languages.pl test online
	0.09 MV Pdmt stuff
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

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Ds::Enum(3), Meta::Ds::String(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
