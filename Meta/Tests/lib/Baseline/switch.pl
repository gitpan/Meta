#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Baseline::Switch qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($fil0)="perl/lib/my.pm";
my($mod0)=Meta::Baseline::Switch::get_module($fil0);
Meta::Utils::Output::print("modu for file [".$fil0."] is [".$mod0."]\n");
my($fil1)="pyth/that.py";
my($mod1)=Meta::Baseline::Switch::get_module($fil1);
Meta::Utils::Output::print("modu for file [".$fil1."] is [".$mod1."]\n");
my($fil2)="ccxx/other.tt";
my($mod2)=Meta::Baseline::Switch::get_module($fil2);
Meta::Utils::Output::print("modu for file [".$fil2."] is [".$mod2."]\n");
my($fil3)="rule/law.rule";
my($mod3)=Meta::Baseline::Switch::get_module($fil3);
Meta::Utils::Output::print("modu for file [".$fil3."] is [".$mod3."]\n");

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

switch.pl - testing program for the Meta::Baseline::Switch.pm module.

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

	MANIFEST: switch.pl
	PROJECT: meta
	VERSION: 0.18

=head1 SYNOPSIS

	switch.pl

=head1 DESCRIPTION

This script tests the Meta::Baseline::Switch module.
It currently just checks to see that it gets the perl module for "my.pm".

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

	0.00 MV perl quality change
	0.01 MV perl code quality
	0.02 MV more perl quality
	0.03 MV more perl quality
	0.04 MV more perl quality
	0.05 MV revision change
	0.06 MV languages.pl test online
	0.07 MV perl packaging
	0.08 MV license issues
	0.09 MV md5 project
	0.10 MV database
	0.11 MV perl module versions in files
	0.12 MV thumbnail user interface
	0.13 MV more thumbnail issues
	0.14 MV website construction
	0.15 MV improve the movie db xml
	0.16 MV web site automation
	0.17 MV SEE ALSO section fix
	0.18 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Switch(3), Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
