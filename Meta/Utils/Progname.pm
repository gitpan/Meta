#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Progname - give you the name of the current script.

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

MANIFEST: Progname.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Progname qw();>
C<my($prog)=Meta::Utils::Progname::progname();>

=head1 DESCRIPTION

This is a lean and mean library to give you the name of the current script
you're running.

=head1 EXPORTS

C<progname()>

=cut

package Meta::Utils::Progname;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use File::Basename qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub progname();

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<progname()>

Give you the name of the current perl script you are running in.
The implementation is currently just taking the $0 variable (which
holds the running image path) and removes all the junk using the basename
function.

=cut

sub progname() {
	return(File::Basename::basename($0));
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
11	Tue Feb  6 07:02:13 2001	MV	more perl code quality
12	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
