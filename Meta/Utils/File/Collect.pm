#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::Collect - utility for generate a list of all the files under a certain dir.

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

MANIFEST: Collect.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::Collect qw();>
C<my($hash)=Meta::Utils::File::Collect::hash($directory,0);>
C<my($list)=Meta::Utils::File::Collect::list($directory,0);>

=head1 DESCRIPTION

This is a library providing functions to generate a list or a hash of
all the files under a certain dir.

=head1 EXPORTS

C<doit()>
C<hash($$)>
C<list($$)>

=cut

package Meta::Utils::File::Collect;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Utils qw();
use Meta::Utils::Hash qw();
use File::Find qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub doit();
#sub hash($$);
#sub list($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<$hash>

This variable stores all the files found so far.

=cut

my($hash);

=item B<doit()>

This function actually does the purging by checking if the handle at
hand is a regular file and if os adding it to a hash.

=cut

sub doit() {
	my($name)=$File::Find::name;
	my($dirx)=$File::Find::dir;
#	Meta::Utils::Output::print("in here with name [".$name."]\n");
#	Meta::Utils::Output::print("in here with dirx [".$dirx."]\n");
	if(-f $name) {
		$hash->{$name}=defined;
	}
}

=item B<hash($$)>

This function receives a directory and scans it using File::Find and
fills up a hash with all the files found there.
The function also receives whether the file names requested should be
with full path or not.

=cut

sub hash($$) {
	my($dire,$abso)=@_;
	$hash={};
	File::Find::find({wanted=>\&doit,no_chdir=>1},$dire);
	if(!$abso) {
		my($other)={};
		$dire.="/";
		while(my($keyx,$valx)=each(%$hash)) {
			my($curr)=Meta::Utils::Utils::minus($keyx,$dire);
			$other->{$curr}=defined;
		}
		$hash=$other;
	}
	return($hash);
}

=item B<list($$)>

This does the same as hash but returns a list as a result.

=cut

sub list($$) {
	my($dire,$abso)=@_;
	my($hash)=hash($dire,$abso);
	my($list)=Meta::Utils::Hash::to_list($hash);
	return($list);
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
11	Tue Feb  6 01:04:52 2001	MV	perl qulity code
12	Tue Feb  6 07:02:13 2001	MV	more perl code quality
13	Tue Feb  6 22:19:51 2001	MV	revision change
14	Fri Feb  9 03:09:51 2001	MV	revision in files
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-clean up the code (absolute path wise...).

=cut
