#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Time - module to let you access dates and times.

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

MANIFEST: Time.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Time qw();>
C<my($string)=Meta::Utils::Time::now_string();>

=head1 DESCRIPTION

This is a library to make it easier on you to access dates and time,
do calculations on them and other stuff without knowing all the gorry
details.
Note that we do not want to add routines like "epoch_to_tm" or "string_to_tm"
since the tm object is not to be used directly according to Tom Christiansen
who maintains these modules.
Therefore we use the string and epoch as merely printing and you should
hold internal representations of time in tm's which you cannot!!! generate
by yourself...(sad but true...).

=head1 EXPORTS

C<tm_to_string($)>
C<tm_to_epoch($)>
C<now_tm()>
C<now_string()>
C<now_epoch()>

=cut

package Meta::Utils::Time;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Time::localtime qw();
use Time::Local qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub tm_to_string($);
#sub tm_to_epoch($);
#sub now_tm();
#sub now_string();
#sub now_epoch();

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<tm_to_string($)>

Convert time structure to one coherent string that we use to denote time.

=cut

sub tm_to_string($) {
	my($tm)=@_;
	my($retu)=sprintf("%04d_%02d_%02d_%02d_%02d_%02d",
		$tm->year+1900,
		$tm->mon+1,
		$tm->mday,
		$tm->hour,
		$tm->min,
		$tm->sec);
	return($retu);
}

=item B<tm_to_epoch($)>

This routine receives a tm structure time and converts it to epoch.

=cut

sub tm_to_epoch($) {
	my($tm)=@_;
	return(Time::Local::timelocal(
		$tm->sec,
		$tm->min,
		$tm->hour,
		$tm->mday,
		$tm->mon,
		$tm->year));
}

=item B<now_tm()>

This routine returns the current time as a tm structure.

=cut

sub now_tm() {
	return(Time::localtime::localtime());
}

=item B<now_string()>

This routine gives you the current time in a standard form of two digits per
each element , larget to smaller of the current date and time up to the second.

=cut

sub now_string() {
	return(tm_to_string(now_tm()));
}

=item B<now_epoch()>

Routine that returns the current time in epoch terms (seconds since
1/1/1970). Dont ask why we need this (something to do with cook).

=cut

sub now_epoch() {
	return(tm_to_epoch(now_tm()));
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
5	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
6	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
7	Sun Jan 28 02:34:56 2001	MV	perl code quality
8	Sun Jan 28 13:51:26 2001	MV	more perl quality
9	Tue Jan 30 03:03:17 2001	MV	more perl quality
10	Sat Feb  3 23:41:08 2001	MV	perl documentation
11	Mon Feb  5 03:21:02 2001	MV	more perl quality
12	Tue Feb  6 01:04:52 2001	MV	perl qulity code
13	Tue Feb  6 07:02:13 2001	MV	more perl code quality
14	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-Rewrite this whole thing with my own time structure (Tom Christiansen sucks in that he wont allow people to use his...).

=cut
