#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use Meta::Utils::File::Move qw();

my($start,$prefix,$verbose,$demo);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_inte("start","what number should I start at ?",0,\$start);
$opts->def_stri("pref","what prefix should I give ?","prefix",\$prefix);
$opts->def_bool("verbose","should I be noisy ?",1,\$verbose);
$opts->def_bool("demo","should I just fake it ?",0,\$demo);
$opts->set_free_allo(1);
$opts->set_free_stri("[files]");
$opts->set_free_mini(1);
$opts->set_free_noli(1);
$opts->analyze(\@ARGV);

my($counter)=$start;
for(my($i)=0;$i<=$#ARGV;$i++) {
	my($curr)=$ARGV[$i];
	my($new)=$prefix.$counter.".jpg";
	if($verbose) {
		Meta::Utils::Output::print("doing [".$curr."] [".$new."]\n");
	}
	if(!$demo) {
		Meta::Utils::File::Move::mv($curr,$new);
	}
	$counter++;
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

pics_give_serial_names.pl - give serial names to files.

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

	MANIFEST: pics_give_serial_names.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	pics_give_serial_names.pl [options]

=head1 DESCRIPTION

Give this script a set of files and hell move them to a same prefix with
a serial number attached (to make sure they dont overlap).

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

=item B<start> (type: inte, default: 0)

what number should I start at ?

=item B<pref> (type: stri, default: prefix)

what prefix should I give ?

=item B<verbose> (type: bool, default: 1)

should I be noisy ?

=item B<demo> (type: bool, default: 0)

should I just fake it ?

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

	0.00 MV books XML into database
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV thumbnail user interface
	0.05 MV more thumbnail issues
	0.06 MV website construction
	0.07 MV improve the movie db xml
	0.08 MV web site automation
	0.09 MV SEE ALSO section fix
	0.10 MV move tests to modules

=head1 SEE ALSO

Meta::Utils::File::Move(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
