#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Debug - handle debug of perl scripts in base.

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

MANIFEST: Debug.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Debug qw();>
C<Meta::Utils::Debug::debug_use();>

=head1 DESCRIPTION

This package handles perl debugging in base and makes sure that if
you're not a perl developer you will not suffer from the lags of doing
things like: use strict qw(vars refs subs);
use diagnostics;etc...
For all programmers that change this package - this package is the first
that gets used in every package in base - keep it lean and mean...

=head1 EXPORTS

C<debug()>
C<msg($)>

=cut

package Meta::Utils::Debug;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Set qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub debug();
#sub msg($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<set>

This is the set which has all the functions that need debug.

=cut

my($set);

=item B<debug()>

This functions returns a boolean telling you whether your'e in debug mode
or not.

=cut

sub debug() {
	# this should check whether the routine is on the list.
	return(0);
}

=item B<BEGIN BLOCK>

This begin block makes sure that the code in it gets run in compile
time which will load up the debugging libs if indeed the variable
BASE_PERL_DEBU is set.

=cut

BEGIN {
#	my($file)="data/baseline/debug.txt";
#	$file=Meta::Baseline::Aegis::which($file);
#	$set=Meta::Ds::Set->new();
#	$set->read($file);
#	Meta::Utils::Output::print("size of set is [".$set->size()."]\n");
}

=item B<msg($)>

This method will output debug message.
currently it just prints to stderr.

=cut

sub msg($) {
	my($mess)=@_;
	Meta::Utils::Output::print($mess."\n");
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
3	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
4	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
4	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
5	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
6	Wed Jan 10 18:31:05 2001	MV	more perl code quality
7	Thu Jan 11 22:31:19 2001	MV	more perl code quality
8	Thu Jan 25 20:55:06 2001	MV	finish Simul documentation
9	Sun Jan 28 02:34:56 2001	MV	perl code quality
10	Sun Jan 28 13:51:26 2001	MV	more perl quality
11	Tue Jan 30 03:03:17 2001	MV	more perl quality
12	Sat Feb  3 23:41:08 2001	MV	perl documentation
13	Mon Feb  5 03:21:02 2001	MV	more perl quality
14	Tue Feb  6 01:04:52 2001	MV	perl qulity code
15	Tue Feb  6 07:02:13 2001	MV	more perl code quality
16	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
