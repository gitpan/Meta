#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use SGI::FAM qw();

my($dire);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_dire("directory","what directory to monitor ?","/tmp",\$dire);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($fam)=SGI::FAM->new();
$fam->monitor($dire);
while(1) {
	my($event)=$fam->next_event();# Blocks
	Meta::Utils::Output::print("Event\n");
	Meta::Utils::Output::print("Pathname: ".$event->filename()."\n");
	Meta::Utils::Output::print("Type: ".$event->type()."\n");
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

fam.pl - demo the usage of the FAM library.

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

	MANIFEST: fam.pl
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	fam.pl [options]

=head1 DESCRIPTION

This program demostrates the use of the SGI::FAM library to monitor
activity of file.

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

=item B<directory> (type: dire, default: /tmp)

what directory to monitor ?

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

	0.00 MV graph visualization
	0.01 MV thumbnail user interface
	0.02 MV more thumbnail issues
	0.03 MV website construction
	0.04 MV improve the movie db xml
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix
	0.07 MV move tests to modules

=head1 SEE ALSO

Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), SGI::FAM(3), strict(3)

=head1 TODO

Nothing.
