#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Output qw();
use Meta::Utils::File::Move qw();
use File::Basename qw();
use Meta::Ds::Enum qw();
use Meta::Utils::String qw();

my($enum)=Meta::Ds::Enum->new();
$enum->insert("rename");
$enum->insert("process");
my($verbose,$demo,$from,$to,$filter);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","should I be noisy ?",0,\$verbose);
$opts->def_bool("demo","should I just fake it ?",0,\$demo);
$opts->def_stri("from","what suffix to move from ?",".JPG",\$from);
$opts->def_stri("to","what suffix to move to ?",".jpg",\$to);
$opts->def_enum("filter","what filter to apply to the files ?","rename",\$filter,$enum);
$opts->set_free_allo(1);
$opts->set_free_stri("[files]");
$opts->set_free_mini(1);
$opts->set_free_noli(1);
$opts->analyze(\@ARGV);

for(my($i)=0;$i<=$#ARGV;$i++) {
	my($curr)=$ARGV[$i];
	if($verbose) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
	}
	my($new);
	my($doit)=0;
	if($enum->is_selected($filter,"rename")) {
		my($name,$path,$suffix)=File::Basename::fileparse($curr,$from);
		if($suffix eq $from) {
			if($verbose) {
				Meta::Utils::Output::print("doing [".$curr."]\n");
			}
			$new=$path."/".$name.$to;
			$doit=1;
		}
	}
	if($enum->is_selected($filter,"process")) {
		$doit=1;
		$new=Meta::Utils::String::separate($curr);
	}
	if($verbose) {
		Meta::Utils::Output::print("moving [".$curr."] to [".$new."]\n");
	}
	if(!$demo) {
		Meta::Utils::File::Move::mv_noov($curr,$new);
	}
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

utils_move_files.pl - move multiple files according to filter.

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

	MANIFEST: utils_move_files.pl
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	utils_move_files.pl [options]

=head1 DESCRIPTION

Give this script a list of files and select a filter to run them through and
their names will be changed using the filter. The script is ofcourse careful
not to step over existing files.

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

should I be noisy ?

=item B<demo> (type: bool, default: 0)

should I just fake it ?

=item B<from> (type: stri, default: .JPG)

what suffix to move from ?

=item B<to> (type: stri, default: .jpg)

what suffix to move to ?

=item B<filter> (type: enum, default: rename)

what filter to apply to the files ?

options [rename,process]

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

	0.00 MV md5 project
	0.01 MV website construction
	0.02 MV improve the movie db xml
	0.03 MV web site automation
	0.04 MV SEE ALSO section fix
	0.05 MV move tests to modules
	0.06 MV bring movie data

=head1 SEE ALSO

File::Basename(3), Meta::Ds::Enum(3), Meta::Utils::File::Move(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::String(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-add more filters.
