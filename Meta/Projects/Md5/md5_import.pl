#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::File::Iter qw();
use Meta::Utils::File::Prop qw();
use Meta::Digest::MD5 qw();
use Meta::Projects::Md5::Node qw();

my($dire,$verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_dire("directory","what directory to scan ?",undef,\$dire);
$opts->def_bool("verbose","should I be noisy ?",1,\$verb);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($iterator)=Meta::Utils::File::Iter->new();
$iterator->add_directory($dire);
$iterator->set_want_dirs(1);
$iterator->start();

while(!$iterator->get_over()) {
	my($curr)=$iterator->get_curr();
	if($verb) {
		Meta::Utils::Output::print("doing [".$curr."]\n");
	}
	my($sb)=Meta::Utils::File::Prop::stat($curr);
	my($node)=Meta::Projects::Md5::Node->new();
	$node->time($sb->mtime());
	$node->mode($sb->mode());
	$node->inode($sb->ino());
	$node->name($iterator->curr_base());
	$node->md5(Meta::Digest::MD5::get_filename_digest($curr));
	$node->size($sb->size());
	$node->commit();
	$iterator->next();
}
$iterator->fini();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

md5_import.pl - import directory md5 data into a database.

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

	MANIFEST: md5_import.pl
	PROJECT: meta
	VERSION: 0.15

=head1 SYNOPSIS

	md5_import.pl [options]

=head1 DESCRIPTION

This script receives a directory, traverses it, and adds it's data
to a given Md5 database. The resulting data base will the 
information about the hirarchy of the directory and checksum
information on each file.

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

=item B<directory> (type: dire, default: )

what directory to scan ?

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

	0.00 MV movie stuff
	0.01 MV more thumbnail code
	0.02 MV more thumbnail stuff
	0.03 MV thumbnail user interface
	0.04 MV import tests
	0.05 MV more thumbnail issues
	0.06 MV md5 project
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix
	0.11 MV move tests to modules
	0.12 MV download scripts
	0.13 MV teachers project
	0.14 MV more pdmt stuff
	0.15 MV md5 issues

=head1 SEE ALSO

Meta::Digest::MD5(3), Meta::Projects::Md5::Node(3), Meta::Utils::File::Iter(3), Meta::Utils::File::Prop(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-do an update version of this script which only changes the information which is no longer needed.

-fix the problem that we always start with an ID of 1.

-do this script using the Class::DBI tools.
