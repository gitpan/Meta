#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Purge - utility for recursivly removing empty directories.

=head1 COPYRIGHT

Copyright (C) 2001 Mark Veltzer;
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

MANIFEST: Purge.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Purge qw();>
C<my($done)=Meta::Utils::File::Purge::purge($my_directory,$demo,$verbose);>

=head1 DESCRIPTION

This is a general utility to clean up whole directory trees from empty
dirs which are created in the build process.
This library utilizes the finddepth routine to do the purging, meaning
it scans the directory at hand in the order of children before fathers,
if a directory is empty it removes it and if a father is left empty
after all children were removed it removes the father and so on...

=head1 EXPORTS

C<init($$$)>
C<doit()>
C<purge($$$$)>

=cut

package Meta::Utils::File::Purge;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::File::Remove qw();
use File::Find qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub init($$$);
#sub doit();
#sub purge($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<$demo,$verb,$done>

These routines hold the data for the entire process.
demo is whether the run is a dry run.
verb is whether we should be verbose or not.
done is whether we have anything so far.

=cut

my($demo,$verb,$done,$erro);

=item B<init($$$)>

This function starts up all the vars in the purge process.
This is an internal routine and you should not call it directly.

=cut

sub init($$$) {
	($demo,$verb,$done)=@_;
	$$done=0;
	$erro=0;
}

=item B<doit()>

This function actually does the purging.
This is an internal routine and you should not call it directly.

=cut

sub doit() {
	my($curr)=$File::Find::name;
	my($dirx)=$File::Find::dir;
	if(-d $curr) {
		if(Meta::Utils::File::Dir::empty($curr)) {
			Meta::Utils::File::Remove::rmdir_demo_verb($curr,$curr,$demo,$verb);
			$$done++;
		}
	}
}

=item B<purge($$$$)>

This function purges a directory tree meaning removes all sub directories
which are empty in recursion (meaning that directories which had only
empty dirs in them will be removed etc.. etc.. etc..).
The inputs are a directory name, demo boolean that controls whether the
dirs are actually removed or not, and a verbose flag.
The routine also receives a pointer of where to store the number
of directories actually removed.

This routine returns a success value.

=cut

sub purge($$$$) {
	my($dire,$demo,$verb,$done)=@_;
	init($demo,$verb,$done);
	File::Find::finddepth(\&doit,$dire);
	return(!$erro);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
3	Sat Jan  6 17:14:09 2001	MV	more perl checks
4	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
4	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
5	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
6	Sun Jan 28 02:34:56 2001	MV	perl code quality
7	Sun Jan 28 13:51:26 2001	MV	more perl quality
8	Tue Jan 30 03:03:17 2001	MV	more perl quality
9	Sat Feb  3 23:41:08 2001	MV	perl documentation
10	Mon Feb  5 03:21:02 2001	MV	more perl quality
11	Tue Feb  6 01:04:52 2001	MV	perl qulity code
12	Tue Feb  6 07:02:13 2001	MV	more perl code quality
13	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
