#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();

my($verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->set_free_allo(1);
$opts->set_free_stri("[file_names]");
$opts->set_free_mini(1);
$opts->set_free_maxi(1);
$opts->analyze(\@ARGV);

Meta::Utils::System::exit(1);

__END__

=head1 NAME

base_aegi_conf_change_file_undo_command.pl - handle Aegis change_file_undo_command notification.

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

	MANIFEST: base_aegi_conf_change_file_undo_command.pl
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	base_aegi_conf_change_file_undo_command.pl

=head1 DESCRIPTION

This script is called by Aegis whenever a files is aecpu, aermu
or similar stuff. It currently does nothing.

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

	0.00 MV more Class method generation
	0.01 MV thumbnail user interface
	0.02 MV more thumbnail issues
	0.03 MV website construction
	0.04 MV improve the movie db xml
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-I can go up here and remove directories so that the development directory does not get clobbered up.