#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Cook qw();
use Meta::Baseline::Aegis qw();
use Meta::Ds::Oset qw();
use Meta::Utils::File::Copy qw();
use Meta::Utils::Output qw();

my($file,$targ,$verbose);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("file","file name to transfer","html/temp/html/projects/Website/main.html",\$file);
$opts->def_dire("directory","directory to copy to","/local/tools/htdocs",\$targ);
#$opts->def_dire("directory","directory to copy to","/var/www/html",\$targ);
$opts->def_bool("verbose","should I be noisy ?",1,\$verbose);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

if($verbose) {
	Meta::Utils::Output::print("reading dependendencies...\n");
}
my($graph)=Meta::Baseline::Cook::read_deps_full($file);
my($set)=Meta::Ds::Oset->new();
$set->insert($file);
my($output_set)=Meta::Ds::Oset->new();
if($verbose) {
	Meta::Utils::Output::print("getting span...\n");
}
$graph->all_ou_new($set,$output_set);

for(my($i)=0;$i<$output_set->size();$i++) {
	my($curr)=$output_set->elem($i);
	if($verbose) {
		Meta::Utils::Output::print("working on [".$curr."]\n");
	}
	my($real)=Meta::Baseline::Aegis::which($curr);
	Meta::Utils::File::Copy::copy_mkdir($real,$targ."/".$curr);
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

website_copy.pl - copy part of the development tree with dependencies.

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

	MANIFEST: website_copy.pl
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	website_copy.pl [options]

=head1 DESCRIPTION

Give this script a list of files that you're interested in and a writer object that can write
to a destination (local directory, ftp site whatever) and it will calculate the forest spanned by those
files and will copy only these files to the target directory/tar.gz/other

This script currently does NOT use the writer object to deduce which files are already on the target
machine and only copy the difference. This is left as an exercise to the reader.

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

=item B<file> (type: devf, default: html/temp/html/projects/Website/main.html)

file name to transfer

=item B<directory> (type: dire, default: /local/tools/htdocs)

directory to copy to

=item B<verbose> (type: bool, default: 1)

should I be noisy ?

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

	0.00 MV web site automation
	0.01 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Cook(3), Meta::Ds::Oset(3), Meta::Utils::File::Copy(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-get this script out of here cause it's generic (it has nothing to do with web sites).

-make this script not copy files which are up to date.

-make this script remove files which are not needed on the target.

-make this script use a generic transfer agent (which could do copy but could also do ftp, sftp etc...)
