#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Tool::Aegis qw();
use Meta::Utils::Output qw();
use Meta::Info::Authors qw();

my($module);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_file("module","what module to use ?",undef,\$module);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($authors)=Meta::Info::Authors->new();
my($revision)=Meta::Tool::Aegis::history($module,$authors);
$revision->print(Meta::Utils::Output::get_file());

Meta::Utils::System::exit_ok();

__END__

=head1 NAME

fhist_ahistory.pl - list history of a module.

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

	MANIFEST: fhist_ahistory.pl
	PROJECT: meta
	VERSION: 0.09

=head1 SYNOPSIS

	fhist_ahistory.pl [options]

=head1 DESCRIPTION

Give this program a development module and it will list it's history.
You can then use an edit number and retrieve that version etc...

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

=item B<module> (type: file, default: )

what module to use ?

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
	0.08 MV bring movie data
	0.09 MV md5 issues

=head1 SEE ALSO

Meta::Info::Authors(3), Meta::Tool::Aegis(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
