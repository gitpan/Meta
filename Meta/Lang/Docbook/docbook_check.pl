#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Lang::Sgml qw();
use Meta::Utils::Output qw();

my($verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","should I be noisy ?",1,\$verb);
$opts->set_free_allo(1);
$opts->set_free_stri("[file]");
$opts->set_free_mini(1);
$opts->set_free_maxi(1);
$opts->analyze(\@ARGV);

my($file)=($ARGV[0]);
my($scod)=Meta::Baseline::Lang::Sgml::check($file);
if($verb) {
	if($scod) {
		Meta::Utils::Output::print("Ok\n");
	} else {
		Meta::Utils::Output::print("Error\n");
	}
}
Meta::Utils::System::exit(1);

__END__

=head1 NAME

docbook_check.pl - Cmd line tool for checking DocBook files.

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

	MANIFEST: docbook_check.pl
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	docbook_check.pl [options]

=head1 DESCRIPTION

This script will check a single docbook file for correctness. This is
a quick script to run whenever you edit a docbook source to make sure
that you are on the right path.

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

=item B<verbose> (type: bool, default: 1)

should I be noisy ?

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

	0.00 MV put all tests in modules
	0.01 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Lang::Sgml(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-check multiple files ?
