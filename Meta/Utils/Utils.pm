#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Utils - misc utility library for many functions.

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

MANIFEST: Utils.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Utils qw();>
C<my($get_home_dir)=Meta::Utils::Utils::get_home_dir();>

=head1 DESCRIPTION

This is a general utility module for either miscelleneous commands which are hard to calssify or for routines which are just starting to form a module and have not yet been given a module and moved there.

=head1 EXPORTS

C<bnot($)>
C<minus($$)>
C<get_temp_dir()>
C<get_temp_dire()>
C<get_temp_file()>
C<replace_suffix($$)>
C<remove_suffix($)>
C<is_prefix($$)>
C<is_suffix($$)>
C<cuid()>
C<cgid()>
C<get_home_dir()>
C<get_user_home_dir($)>
C<pwd()>
C<remove_comments($)>
C<chdir($)>

=cut

package Meta::Utils::Utils;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();
use Meta::Utils::Env qw();
use IO::File qw();
use POSIX qw();
use Cwd qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub bnot($);
#sub minus($$);
#sub get_temp_dir();
#sub get_temp_dire();
#sub get_temp_file();
#sub replace_suffix($$);
#sub remove_suffix($);
#sub is_prefix($$);
#sub is_suffix($$);
#sub cuid();
#sub cgid();
#sub get_home_dir();
#sub get_user_home_dir($);
#sub pwd();
#sub remove_comments($);
#sub chdir($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<bnot($)>

This does a binary "not" operation which (suprisingly) is not enough to
do using the "!" operator.

=cut

sub bnot($) {
	my($valx)=@_;
	if($valx==0) {
		return(1);
	} else {
		return(0);
	}
}

=item B<minus($$)>

This subtracts one string from another under the assumbtions that the second
is a prefix of the first. This is useful for paths (and hence the names of the
local variables in this function).

=cut

sub minus($$) {
	my($full,$path)=@_;
	if(substr($full,0,length($path)) eq $path) {
		return(substr($full,length($path),length($full)));
	} else {
		Meta::Utils::System::die("whats this path is [".$path."] and full is [".$full."]\n");
	}
}

=item B<get_temp_dir()>

This gives you a temporary directory where you can store temporary files
to your hearts content. Currently this just returns "/tmp" which is ok for
UNIX type systems.

=cut

sub get_temp_dir() {
	return("/tmp");
}

=item B<get_temp_dire()>

This method will give you a directory it created in a temporary location.
Currently it iterates on names until it manages to create the directory.

=cut

sub get_temp_dire() {
	my($base)="/tmp/temp_dir";
	my($i)=0;
	while(!CORE::mkdir($base."_".$i,0755)) {
		$i++;
	}
	return($base."_".$i);
}

=item B<get_temp_file()>

This gives you a temporary file name using the POSIX tmpnam function.

=cut

sub get_temp_file() {
	return(POSIX::tmpnam());
#	This call actually creates the file and this is unneccessary because
#	this is not the intention of the routine. Watch out for a race
#	condition where the routine calling this one will get the name and cant
#	create the file.
#	my($name,$fh);
#	do {
#		$name=POSIX::tmpnam();
#	}
#	until($fh=IO::File->new($name,IO::File::O_RDWR|IO::File::O_CREAT|IO::File::O_EXCL));
#	return($name);
}

=item B<replace_suffix($$)>

This replaces the strings suffix with another one.

=cut

sub replace_suffix($$) {
	my($file,$suff)=@_;
	$file=~s/\..*/$suff/;
	return($file);
}

=item B<remove_suffix($)>

This removes a suffix from the string argument given it.
This just substitues the suffix of the file with nothing...:)

=cut

sub remove_suffix($) {
	my($file)=@_;
	return(replace_suffix($file,""));
}

=item B<is_prefix($$)>

This routine receives a string and a prefix and returns whether the
prefix is a prefix for that string

=cut

sub is_prefix($$) {
	my($stri,$pref)=@_;
	#$pref=quotemeta($pref);
	#Meta::Utils::Output::print("pref is [".$pref."]\n");
	#return($stri=~/^$pref/);
	my($sub)=substr($stri,0,length($pref));
	return($sub eq $pref);
}

=item B<is_suffix($$)>

This routine receives a string and a suffix and returns whether the
suffix is a suffix for that string

=cut

sub is_suffix($$) {
	my($stri,$suff)=@_;
	#$suff=quotemeta($suff);
	#Meta::Utils::Output::print("suff is [".$suff."]\n");
	#return($stri=~/$suff$/);
	my($sub)=substr($stri,-length($suff));
	return($sub eq $suff);
}

=item B<cuid()>

This routine returns the numerical value of the current user (uid).

=cut

sub cuid() {
	return(POSIX::getuid());
#	return($>);
}

=item B<cgid()>

This routine returns the numerical value of the current group (gid).

=cut

sub cgid() {
	return(POSIX::getegid());
#	my($stri)=$);
#	my(@spli)=split(" ",$stri);
#	return($spli[0]);
}

=item B<get_home_dir()>

This routine returns the current users home directory.
The implementation used to work with the environment and getting the
HOME variable but this is very unrobust and works for less platforms
and situations. Currently this uses POSIX which is much more robust
to find the uid of the current user and then the home directory from
the password file using getpwuid.

=cut

sub get_home_dir() {
	my($uid)=POSIX::getuid();
	return((POSIX::getpwuid($uid))[7]);
#	return(Meta::Utils::Env::get("HOME"));
}

=item B<get_user_home_dir($)>

This routine returns the home dir of the user that is given to it as the
argument.

=cut

sub get_user_home_dir($) {
	my($user)=@_;
	my($resu)=((POSIX::getpwnam($user))[7]);
	if(!defined($resu)) {
		Meta::Utils::System::die("get_user_home_dir: user [".$user."] unknown");
	} else {
		return($resu);
	}
}

=item B<pwd()>

This returns the current working directory.
This is currently implemented as getting the "PWD" variable out of the
environment. There should be a better way to do that since the system
knows which is your current working directory so there should be a system
call to find this out...

=cut

sub pwd() {
	return(Cwd::cwd());
}

=item B<remove_comments($)>

This routine will receive a text and will remove all comments from it.
The idea here is C/C++ style comments : /* sdfdaf */

=cut

sub remove_comments($) {
	my($text)=@_;
	$text=~s/\/\/*.*\*\///;
	return($text);
}

=item B<chdir($)>

This routine will change the current working directory by calling the builtin
function "chdir". It will die if it cannot change the directory.

=cut

sub chdir($) {
	my($dire)=@_;
	if(!CORE::chdir($dire)) {
		Meta::Utils::Sysmte::die("unable to change directory to [".$dire."]");
	}
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
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
7	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
8	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
9	Wed Jan 10 18:31:05 2001	MV	more perl code quality
10	Thu Jan 11 12:42:37 2001	MV	put ALL tests back and light the tree
11	Fri Jan 12 13:36:01 2001	MV	make options a lot better
12	Sun Jan 14 02:26:10 2001	MV	introduce docbook into the baseline
13	Thu Jan 18 13:57:59 2001	MV	make lilypond work
14	Thu Jan 18 15:59:13 2001	MV	correct die usage
15	Thu Jan 18 18:05:39 2001	MV	lilypond stuff
15	Sat Jan 27 19:56:28 2001	MV	perl quality change
16	Sun Jan 28 02:34:56 2001	MV	perl code quality
17	Sun Jan 28 13:51:26 2001	MV	more perl quality
18	Tue Jan 30 03:03:17 2001	MV	more perl quality
19	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
20	Sat Feb  3 23:41:08 2001	MV	perl documentation
21	Mon Feb  5 03:21:02 2001	MV	more perl quality
22	Tue Feb  6 01:04:52 2001	MV	perl qulity code
23	Tue Feb  6 07:02:13 2001	MV	more perl code quality
24	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-implement the get_temp_dir routine better... (is there a way of officialy getting such a directory ?).

-is there a better way to implement the get_temp_dire routine ?

-move the get_home_dir and the other function built to some library.

-maybe there is a better way to get my home directory than from the environment ?

-The is suffix routine and is prefix routines should be fixed for cases where the string they match has special (regexp type) characters in it. Watch the example in cook_touch.

-more routines should be moved to their own modules...

-reimplement the home directory of the current user just like any others.

-fix the cgid routine... (isnt there a better way to do it ?!?...)

=cut
