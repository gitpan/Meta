#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Color - give you options to color the text you're writing.

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

MANIFEST: Color.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Color qw();>
C<Meta::Utils::Color::set_color(*FILE,"red");>
C<Meta::Utils::Output::print("Hello, World!\n");>

=head1 DESCRIPTION

This is a library to give you a clean interface to the ANSIColor.pm module
which enables nice coloring and emition of color escape codes for terminals
and texts.

=head1 EXPORTS

C<set_color($$)>
C<get_color($)>
C<get_reset()>
C<reset($)>

=cut

package Meta::Utils::Color;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Term::ANSIColor qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub set_color($$);
#sub get_color($);
#sub get_reset();
#sub reset($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<set_color($$)>

This sets the current color for writing to the file received.

=cut

sub set_color($$) {
	my($file,$colo)=@_;
	print $file Term::ANSIColor::color($colo);
}

=item B<get_color($)>

This returns the escape sequence needed to provide a certain color on
the console.

=cut

sub get_color($) {
	my($colo)=@_;
	return(Term::ANSIColor::color($colo));
}

=item B<get_reset()>

This method return the escape sequence needed to reset the color on
the console.

=cut

sub get_reset() {
	return(Term::ANSIColor::color("reset"));
}

=item B<reset($)>

This resets the color to the regular color and avoids all kinds
of weird side effects (for the file specified of course).

=cut

sub reset($) {
	my($file)=@_;
	set_color($file,"reset");
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
6	Mon Jan 15 22:37:09 2001	MV	cleanup tests change
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
