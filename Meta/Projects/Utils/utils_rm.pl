#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::File::Remove qw();

my($verb,$demo);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->def_bool("demo","play around or do it for real ?",0,\$demo);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($scod)=Meta::Utils::File::Remove::rmmult_demo_verb($demo,$verb);
Meta::Utils::System::exit($scod);

__END__

=head1 NAME

utils_rm.pl - remove files specified in standard input.

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

	MANIFEST: utils_rm.pl
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	utils_rm.pl

=head1 DESCRIPTION

This tool is intended to aid in removing large quantities of files.
The idea is that the UNIX command line is a little too short in that
it is a problem if you want to remove thousands of files in a single
stroke of an "rm" command. The idea is to feed this command with a standard
input where every line is a name of a file to be removed and this command
will do it. This should be faster than running a lot of rm's since it doesnt
load the rm binary and run a different process for each rm.
This is just a peep hole to the rmmult_demo_verb function in
Meta::Utils::File::Remove. See that functions documentation for more
details about the inner workings of this.

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

=item B<demo> (type: bool, default: 0)

play around or do it for real ?

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

	0.00 MV md5 progress
	0.01 MV thumbnail user interface
	0.02 MV more thumbnail issues
	0.03 MV website construction
	0.04 MV improve the movie db xml
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::File::Remove(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
