#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Move - library to help you move files.

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

MANIFEST: Move.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Move qw();>
C<Meta::Utils::File::Move::mv($file1,$file2);>

=head1 DESCRIPTION

This module eases the case for moving files.

=head1 EXPORTS

C<mv_nodie($$)>
C<mv($$)>
C<mv_noov($$)>

=cut

package Meta::Utils::File::Move;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use File::Copy qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub mv_nodie($$);
#sub mv($$);
#sub mv_noov($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<mv_nodie($$)>

This function moves a file to another and does not die if it fails.

=cut

sub mv_nodie($$) {
	my($fil1,$fil2)=@_;
	if(!File::Copy::move($fil1,$fil2)) {
		return(0);
	} else {
		return(1);
	}
}

=item B<mv($$)>

This function moves a file to another and dies if it fails.

=cut

sub mv($$) {
	my($fil1,$fil2)=@_;
	my($scod)=mv_nodie($fil1,$fil2);
	if(!$scod) {
		Meta::Utils::System::die("unable to move [".$fil1."] to [".$fil2."]");
	}
}

=item B<mv_noov($$)>

This function moves a file to another and dies if it fails or the target
file already exists.

=cut

sub mv_moov($$) {
	my($fil1,$fil2)=@_;
	if(-f $fil2) {
		Meta::Utils::System::die("file [".$fil2."] exists");
	}
	return(&mv($fil1,$fil2));
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
6	Sun Jan 14 02:26:10 2001	MV	introduce docbook into the baseline
7	Thu Jan 18 01:55:38 2001	MV	spelling change
8	Thu Jan 18 13:57:59 2001	MV	make lilypond work
8	Thu Jan 18 15:59:13 2001	MV	correct die usage
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
