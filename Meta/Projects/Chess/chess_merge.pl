#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::File::Remove qw();
use Meta::Template::Sub qw();

my($verb,$file,$local);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",0,\$verb);
$opts->def_stri("file","what file to merge ?","[% home_dir %]/.eboard/mygames.pgn",\$file);
$opts->def_devf("local","what local file to merge to ?","pgnx/games.pgn",\$local);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

$file=Meta::Template::Sub::interpolate($file);
if(!(-e $file)) {
	Meta::Utils::System::die("unable to find file [".$file."]");
}

# check the file out if needed
if(!Meta::Baseline::Aegis::in_change($local)) {
	if($verb) {
		Meta::Utils::Output::print("checking out file");
	}
	Meta::Baseline::Aegis::checkout_file($local);
}
my($curr)=Meta::Baseline::Aegis::which($local);
Meta::Utils::Utils::cat($curr,$file,$curr);
Meta::Utils::File::Remove::rm($file);

Meta::Utils::System::exit(1);

__END__

=head1 NAME

chess_merge.pl - get latest pgn games and merge them with current ones.

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

	MANIFEST: chess_merge.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	chess_merge.pl [options]

=head1 DESCRIPTION

This script takes your latest set of pgn games coming out of your favorite
chess playing software and puts merges them with the appropriate baseline
file.

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

=item B<verbose> (type: bool, default: 0)

noisy or quiet ?

=item B<file> (type: stri, default: [% home_dir %]/.eboard/mygames.pgn)

what file to merge ?

=item B<local> (type: devf, default: pgnx/games.pgn)

what local file to merge to ?

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

	0.00 MV web site development

=head1 SEE ALSO

Meta::Template::Sub(3), Meta::Utils::File::Remove(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-have Opts::Opts support interpolated vars and do all the checks I'm doing here itself.
