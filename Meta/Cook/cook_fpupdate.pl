#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();

my($demo,$verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("demo","play around or do it for real ?",0,\$demo);
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Utils::System::exit(1);

__END__

=head1 NAME

cook_fpupdate.pl - update the fingerprints for all files.

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

	MANIFEST: cook_fpupdate.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	cook_fpupdate.pl

=head1 DESCRIPTION

This will update all of cooks fingerprints.
This will do it by removing all the .cook.fp files in the change and asking
cook to recalculate them.
The method is the same as peters (just doing it with perl...):

	======EXAMPLE START======
	build_time_adjust_notify_command=
	"set +e;find . -name .cook.fp -print | xargs rm;cook -nl -st --fp-update";
	======EXAMPLE END========

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

=item B<demo> (type: bool, default: 0)

play around or do it for real ?

=item B<verbose> (type: bool, default: 0)

noisy or quiet ?

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

	0.00 MV move tests to modules

=head1 SEE ALSO

Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
