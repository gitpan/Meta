#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
 
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();
#doit 
Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

import_export.pl - test import/export database utilities.

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

	MANIFEST: import_export.pl
	PROJECT: meta
	VERSION: 0.24

=head1 SYNOPSIS

	import_export.pl

=head1 DESCRIPTION

This test will do the following:
0. create a temporary database.
1. import data into that database.
2. export the data back.
3. remove the database.
4. compare the files.
5. removes the exported files.
This uses the perl native File::Compare module.

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

	0.00 MV more perl checks
	0.01 MV make Meta::Utils::Opts object oriented
	0.02 MV more harsh checks on perl code
	0.03 MV fix todo items look in pod documentation
	0.04 MV put ALL tests back and light the tree
	0.05 MV silense all tests
	0.06 MV more perl code quality
	0.07 MV perl quality change
	0.08 MV perl code quality
	0.09 MV more perl quality
	0.10 MV more perl quality
	0.11 MV revision change
	0.12 MV languages.pl test online
	0.13 MV perl packaging
	0.14 MV license issues
	0.15 MV md5 project
	0.16 MV database
	0.17 MV perl module versions in files
	0.18 MV thumbnail user interface
	0.19 MV more thumbnail issues
	0.20 MV website construction
	0.21 MV improve the movie db xml
	0.22 MV web site automation
	0.23 MV SEE ALSO section fix
	0.24 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
