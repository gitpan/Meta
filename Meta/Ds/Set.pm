#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Set - data structure that represents a set.

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

MANIFEST: Set.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Ds::Set qw();>
C<my($set)=Meta::Ds::Set->new();>
C<$set->insert("mark");>

=head1 DESCRIPTION

This is a library to let you create a set like data structure.

=head1 EXPORTS

C<new($)>
C<insert($$)>
C<remove($$)>
C<has($$)>
C<hasnt($$)>
C<check_elem($$)>
C<check_not_elem($$)>
C<print($$)>
C<size($)>

=cut

package Meta::Ds::Set;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub insert($$);
#sub remove($$);
#sub has($$);
#sub hasnt($$);
#sub check_elem($$);
#sub check_not_elem($$);
#sub print($$);
#sub size($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Set object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{SIZE}=0;
	return($self);
}

=item B<insert($$)>

Inserts a new element into the set.

=cut

sub insert($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is a set element");
	} else {
		$self->{HASH}->{$elem}=defined;
		$self->{SIZE}++;
	}
}

=item B<remove($$)>

Removes an element from the set.

=cut

sub remove($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		delete($self->{HASH}->{$elem});
		$self->{SIZE}--;
	} else {
		Meta::Utils::System::die("elem [".$elem."] is not a set element");
	}
}

=item B<has($$)>

Returns whether the current element is a member of the set.

=cut

sub has($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if(exists($self->{HASH}->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

=item B<hasnt($$)>

Returns whether the current element is not a member of the set.

=cut

sub hasnt($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if(exists($self->{HASH}->{$elem})) {
		return(0);
	} else {
		return(1);
	}
}

=item B<check_elem($$)>

Check that the element received is in the set and die if it is not.

=cut

sub check_elem($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is not an element of the set");
	}
}

=item B<check_not_elem($$)>

Check that the element received is in not the set and die if it is.

=cut

sub check_not_elem($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is an element of the set");
	}
}

=item B<print($$)>

Prints the current set.
This also receives the name of the file to print to.

=cut

sub print($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	Meta::Utils::Arg::check_arg($file,"ANY");
	my($hash)=$self->{HASH};
	while(my($keyx,$valx)=each(%$hash)) {
		print $file $keyx."\n";
	}
}

=item B<size($)>

Return the size of the set.

=cut

sub size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	return($self->{SIZE});
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
2	Thu Jan  4 13:36:17 2001	MV	ok. This is for real
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
6	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
7	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
8	Thu Jan 11 17:46:02 2001	MV	silense all tests
9	Thu Jan 18 15:59:13 2001	MV	correct die usage
10	Thu Jan 25 20:55:06 2001	MV	finish Simul documentation
11	Sun Jan 28 02:34:56 2001	MV	perl code quality
12	Sun Jan 28 13:51:26 2001	MV	more perl quality
13	Tue Jan 30 03:03:17 2001	MV	more perl quality
14	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
15	Sat Feb  3 23:41:08 2001	MV	perl documentation
16	Mon Feb  5 03:21:02 2001	MV	more perl quality
17	Tue Feb  6 01:04:52 2001	MV	perl qulity code
18	Tue Feb  6 07:02:13 2001	MV	more perl code quality
19	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
