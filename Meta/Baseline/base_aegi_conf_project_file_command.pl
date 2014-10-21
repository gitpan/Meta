#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Utils::System::exit(1);

__END__

=head1 NAME

base_aegi_conf_project_file_command.pl - hook for new project files.

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

	MANIFEST: base_aegi_conf_project_file_command.pl
	PROJECT: meta
	VERSION: 0.21

=head1 SYNOPSIS

	base_aegi_conf_project_file_command.pl

=head1 DESCRIPTION

This script is called by aegis whenever a new file is added to the project or
a file is copied to the project.
This will:
	0) Authorise that this file is allowed for insertion.
	1) Authorise that the current developer is allowed to insert this file.
	2) If the file is new it will run templates on it.
Currently it does nothing.

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

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV more harsh checks on perl code
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV silense all tests
	0.08 MV perl code quality
	0.09 MV more perl quality
	0.10 MV more perl quality
	0.11 MV revision change
	0.12 MV languages.pl test online
	0.13 MV perl packaging
	0.14 MV md5 project
	0.15 MV database
	0.16 MV perl module versions in files
	0.17 MV thumbnail user interface
	0.18 MV more thumbnail issues
	0.19 MV website construction
	0.20 MV web site automation
	0.21 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
