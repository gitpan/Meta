#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Remove - package that eases removal of files and directories.

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

MANIFEST: Remove.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Remove qw();>
C<Meta::Utils::File::Remove::rm($filename);>
C<Meta::Utils::File::Remove::rmdir($dirname);>

=head1 DESCRIPTION

This module eases the use of rm. Instead of checking for errors all of the
time just let this module remove a file or directory for you (it has all
the options including a recursive one...). If something happens wrong
it dies on you but hey - thats the price you got to pay...

=head1 EXPORTS

C<rm_nodie($)>
C<rm($)>
C<rm_demo_verb($$$)>
C<rm_rmdir($)>
C<rmdir($)>
C<rmdir_demo_verb($$$$)>
C<rmall()>
C<rmrecusrive($)>
C<rmhash_demo_verb($$$)>
C<rmlist_demo_verb($$$)>
C<rmmult_demo_verb($$)>

=cut

package Meta::Utils::File::Remove;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use File::Find qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub rm_nodie($);
#sub rm($);
#sub rm_demo_verb($$$);
#sub rm_rmdir($);
#sub rmdir($);
#sub rmdir_demo_verb($$$$);
#sub rmall();
#sub rmrecursive($);
#sub rmhash_demo_verb($$$);
#sub rmlist_demo_verb($$$);
#sub rmmult_demo_verb($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<rm_nodie($)>

This function removes a single file and does not do anything if it does not
exist. This function returns whether it managed to do it or not...

=cut

sub rm_nodie($) {
	my($file)=@_;
	return(CORE::unlink($file));
}

=item B<rm($)>

This function removes a single file and dies if it cannot do so.
It does not return a value.

=cut

sub rm($) {
	my($file)=@_;
	my($resu)=rm_nodie($file);
	if($resu!=1) {
		Meta::Utils::System::die("unable to remove [".$file."]");
	}
}

=item B<rm_demo_verb($$$)>

This function removes a file only if the demo is false and also emits a
message if the verbose flag is true

=cut

sub rm_demo_verb($$$) {
	my($file,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("removing file [".$file."]\n");
	}
	if($demo) {
		return(1);
	} else {
		return(&rm($file));
	}
}

=item B<rm_rmdir($)>

This function removes a file and then removes the directory in which it is
located if it remains empty.
Actually this function should continues going higher....:) up the directory
tree.

=cut

sub rm_rmdir($) {
	my($file)=@_;
	rm($file);
	my($dire)=dirname($file);
	if(dir_empty($dire)) {
		&rmdir($dire);
	}
}

=item B<rmdir($)>

This function removes a directory and dies if it cannot do so.
This function does not return a value.

=cut

sub rmdir($) {
	my($dire)=@_;
	my($resu)=CORE::rmdir($dire);
	if(!$resu) {
		Meta::Utils::System::die("unable to remove directory [".$dire."]");
	}
}

=item B<rmdir_demo_verb($$$$)>

This function removes a directory only if the demo flag is false.
The function also emits a message about the directory begin removed
if the verbose flag is true.

=cut

sub rmdir_demo_verb($$$$) {
	my($dire,$prin,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("removing dir [".$prin."]\n");
	}
	if($demo) {
		return(1);
	} else {
		return(&rmdir($dire));
	}
}

=item B<rmall()>

This function assumes that you dont know if what you're looking to remove
is a file or a directory and removes whichever this is...
It dies if it cannot perform.

=cut

sub rmall() {
	my($unkn)=$File::Find::name;
	if(-d $unkn) {
		&rmdir($unkn);
	} else {
		&rm($unkn);
	}
}

=item B<rmrecusive($)>

This function removes a directory in a recursive fashion.
It uses the File::Find function to achieve this (unlinking dirs is not
good...:)
It also uses the rmall function to achieve this (nice trick...).

=cut

sub rmrecursive($) {
	my($dir)=@_;
	File::Find::finddepth(\&rmall,$dir);
}

=item B<rmhash_demo_verb($$$)>

This routine removes a whole hash. As expected, demo and verbose arguments
are also allowed.

=cut

sub rmhash_demo_verb($$$) {
	my($hash,$demo,$verb)=@_;
	my($resu)=1;
	while(my($keyx,$valx)=each(%$hash)) {
		my($tmpr)=rm_demo_verb($keyx,$demo,$verb);
		$resu=$resu && $tmpr;
	}
	return($resu);
}

=item B<rmlist_demo_verb($$$)>

This routine removes a whole list. As expected, demo and verbose arguments
are also allowed.

=cut

sub rmlist_demo_verb($$$) {
	my($list,$demo,$verb)=@_;
	for(my($i)=0;$i<=$#$list;$i++) {
		rm_demo_verb($list->[$i],$demo,$verb);
	}
}

=item B<rmmult_demo_verb($$)>

This function receives the regular demo and verbose variables and treats the
standard input as a source for lines, each representing a file to be removed.
The function removes all the files refered as such.
The function returns whether all the removals were successful or not.

=cut

sub rmmult_demo_verb($$) {
	my($demo,$verb)=@_;
	my($line);
	my($resu)=1;
	while($line=<> || 0) {
		chop($line);
		$resu=$resu && Meta::Utils::File::Remove::rm_demo_verb($line,$demo,$verb);
	}
	return($resu);
}

1;

=back

=head1 BUGS

None

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
3	Sat Jan  6 17:14:09 2001	MV	more perl checks
4	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
5	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
6	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
7	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
8	Thu Jan 18 13:57:59 2001	MV	make lilypond work
8	Thu Jan 18 15:59:13 2001	MV	correct die usage
9	Thu Jan 18 18:05:39 2001	MV	lilypond stuff
10	Sun Jan 28 02:34:56 2001	MV	perl code quality
11	Sun Jan 28 13:51:26 2001	MV	more perl quality
12	Tue Jan 30 03:03:17 2001	MV	more perl quality
13	Sat Feb  3 23:41:08 2001	MV	perl documentation
14	Mon Feb  5 03:21:02 2001	MV	more perl quality
15	Tue Feb  6 01:04:52 2001	MV	perl qulity code
16	Tue Feb  6 07:02:13 2001	MV	more perl code quality
17	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-rm_rmdir should climb higher and keep removing dirs (its not doing that right now...).

-add a die parameter to the rm($) function and propagate it up.

-add an option to the rmmult_demo_verb function to remove files from any file source (not just stdin...).

=cut
