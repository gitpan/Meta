#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Arg - module to help you checking argument types to methods/functions.

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

MANIFEST: Arg.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Arg qw();>
C<Meta::Utils::Arg::check_arg_num(\@_,3);>

=head1 DESCRIPTION

This is a general utility module for either miscelleneous commands which are hard to calssify or for routines which are just starting to form a module and have not yet been given a module and moved there.

=head1 EXPORTS

C<bnot($)>
C<minus($$)>
C<get_temp_dir()>
C<get_temp_dire()>
C<get_temp_file()>
C<check_arg_num($$)>
C<check_arg($$)>
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

package Meta::Utils::Arg;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub check_arg_num($$);
#sub check_arg($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<check_arg_num($$)>

This method will check that the number of arguments is the correct one.

=cut

sub check_arg_num($$) {
	my($arra,$numx)=@_;
	my($size)=$#$arra+1;
	if($size!=$numx) {
		Meta::Utils::System::die("number of arguments is wrong [".$size."] and not [".$numx."]");
	}
}

=item B<check_arg($$)>

This checks that the type of argument given to it has the type give to it
using the ref routine (very useful for when receiving lists,hashes etc..).

=cut

sub check_arg($$) {
	my($varx,$type)=@_;
	if(!defined($varx)) {
		Meta::Utils::System::die("undefined variable");
	}
	if(defined($type)) {
		if($type eq "ANY") {
			return(1);
		}
		if($type eq "SCALAR") {
			my($ref)=CORE::ref($varx);
			if($ref eq "") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of SCALAR is [".$ref."]");
			}
		}
		if($type eq "SCALARref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "SCALAR") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of SCALARref is [".$ref."]");
			}
		}
		if($type eq "ARRAYref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "ARRAY") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of ARRAYref is [".$ref."]");
			}
		}
		if($type eq "HASHref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "HASH") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of HASHref is [".$ref."]");
			}
		}
		if(UNIVERSAL::isa($varx,$type)) {
			return(1);
		} else {
			Meta::Utils::System::die("variable [".$varx."] is not of type [".$type."]");
		}
	} else {
		Meta::Utils::System::die("why is type undef ?");
		return(0);
	}
#	my($resu)=ref($varx);
#	if(defined($resu)) {
#		if($resu ne $type) {
#			Meta::Utils::System::die("variable is not of type [".$varx."] but of type [".$resu."]");
#		}
#	} else {
#		Meta::Utils::System::die("ref didn't return defined value");
#	}
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
