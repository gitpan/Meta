#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Touch - library to help you touch files.

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

MANIFEST: Touch.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Touch qw();>
C<my($ok)=Meta::Utils::File::Touch::now($file1);>

=head1 DESCRIPTION

This module eases the case for touching files.
It will change a files date to a certain date or do the same with the current
date (which is usually just refered to as "touching" the file...).

=head1 EXPORTS

C<date($$$$)>
C<now($$$)>

=cut

package Meta::Utils::File::Touch;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub date($$$$);
#sub now($$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<date($$$$)>

This routine receives:
0. file - file to be modiles (by modify time).
1. time - time to set modify time of file to.
2. demo - whether to touch or just a demo.
3. verb - whether to be verbose or not.

The routine uses the utime function of perl to change to modify time
of the file to the time required doing nothing if demo is not 0 and
printing a message if verbose is 1.

=cut

sub date($$$$) {
	my($file,$time,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("touching file [".$file."]\n");
	}
	if(!$demo) {
		my($atime,$mtime)=(stat($file))[8,9];
		if(!utime($atime,$time,$file)) {
			Meta::Utils::System::die("cannot utime [".$file."]");
			return(0);
		}
	}
	return(1);
}

=item B<now($$$)>

This receievs a files and sets touches it so its modified date becomes now.
This just uses Meta::Utils::Time::now_epoch to get the current time and
the date function in this module.

=cut

sub now($$$) {
	my($file,$demo,$verb)=@_;
	my($time)=Meta::Utils::Time::now_epoch();
	return(date($file,$time,$demo,$verb));
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
6	Thu Jan 18 15:59:13 2001	MV	correct die usage
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

Nothing.

=cut
