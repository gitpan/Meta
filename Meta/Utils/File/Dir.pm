#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Dir - library to do stuff on directories in the file system.

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

MANIFEST: Dir.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Dir qw();>
C<my($dire)="/etc";>
C<if(Meta::Utils::File::Dir::empty($dire)) {>
C<	# do that>
C<} else {>
C<	# do other>
C<}>

=head1 DESCRIPTION

This is a library to help you do things with directories. For instance:
create a directory (also creating its parents) and dying if something
goes wrong, checking if a directory is empty etc...

=head1 EXPORTS

C<empty($)>
C<exist($)>
C<check_exist($)>
C<fixdir($)>

=cut

package Meta::Utils::File::Dir;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Carp qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub empty($);
#sub exist($);
#sub check_exist($);
#sub fixdir($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<empty($)>

This returns a boolean value according to whether the directory
is empty or not. The current implementation seems slow since it
lists our all the files in that directory and checks to see that
we have only one (the ".." link which points to the father...:)
A speedup would be to find a better way in perl to do this...
Using stat maybe ?

=cut

sub empty($) {
	my($dire)=@_;
	opendir(DIRE,$dire) || Meta::Utils::System::die("cannot opendir [".$dire."]");
	my(@file)=readdir(DIRE);
	closedir(DIRE) || Meta::Utils::System::die("cannot closedir [".$dire."]");
	return($#file==1);
}

=item B<exist($)>

This routine returns whether a certain directory is valid.

=cut

sub exist($) {
	my($dire)=@_;
	return(-d $dire);
}

=item B<check_exist($)>

This routine checks if a directory given to it exists and if not dies.

=cut

sub check_exist($) {
	my($dire)=@_;
	if(!(-d $dire)) {
		Carp::confess("directory [".$dire."] does not exist");
	}
}

=item B<fixdir($)>

This routine gets a name of a file or directory and eliminated bad stuff
from it:
0. [pref][somethine]/..[suff] => [pref][suff]

=cut

sub fixdir($) {
	my($name)=@_;
	while($name=~s/[^\/]*\/\.\.\///) {};
	return($name);
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
4	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
5	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
5	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
6	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
7	Thu Jan 18 15:59:13 2001	MV	correct die usage
8	Sun Jan 28 02:34:56 2001	MV	perl code quality
9	Sun Jan 28 13:51:26 2001	MV	more perl quality
10	Tue Jan 30 03:03:17 2001	MV	more perl quality
11	Sat Feb  3 23:41:08 2001	MV	perl documentation
12	Mon Feb  5 03:21:02 2001	MV	more perl quality
13	Tue Feb  6 01:04:52 2001	MV	perl qulity code
14	Tue Feb  6 07:02:13 2001	MV	more perl code quality
15	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-cant we do the empty routine more efficiently ? (some stat or something...)

=cut
