#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

Meta::Utils::Output::print("user is [".Meta::Baseline::Test::get_user()."]\n");
Meta::Utils::Output::print("password is [".Meta::Baseline::Test::get_password()."]\n");
Meta::Utils::Output::print("host is [".Meta::Baseline::Test::get_host()."]\n");
Meta::Utils::Output::print("domain is [".Meta::Baseline::Test::get_domain()."]\n");
Meta::Utils::Output::print("mysqldsn is [".Meta::Baseline::Test::get_mysqldsn()."]\n");
Meta::Utils::Output::print("mysqluser is [".Meta::Baseline::Test::get_mysqluser()."]\n");
Meta::Utils::Output::print("mysqlpass is [".Meta::Baseline::Test::get_mysqlpass()."]\n");

Meta::Baseline::Test::redirect_on();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

test.pl - test suite for the Meta::Baseline::Test module.

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

	MANIFEST: test.pl
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	test.pl [options]

=head1 DESCRIPTION

This script will test the Meta::Baseline::Test module by getting a few
configuration variables from it.

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

	0.00 MV web site automation
	0.01 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
