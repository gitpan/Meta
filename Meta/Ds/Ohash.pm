#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Ohash - Ordered hash data structure.

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

MANIFEST: Ohash.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Ds::Ohash qw();>

=head1 DESCRIPTION

This is an object which is a hash table which can also give you a random
element.

=head1 EXPORTS

C<new($)>
C<insert($$$)>
C<remove($$)>
C<elem($$)>
C<keyx($$)>
C<valx($$)>
C<print($$)>
C<get_elem_number($$)>

=cut

package Meta::Ds::Ohash;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Hash qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Hash);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub insert($$$);
#sub remove($$);
#sub elem($$);
#sub keyx($$);
#sub valx($$);
#sub print($$);
#sub get_elem_number($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Ohash object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Hash->new();
	bless($self,$clas);
	$self->{KEYX}=[];
	$self->{VALX}=[];
	$self->{OHASH}={};
	return($self);
}

=item B<insert($$$)>

Inserts an element into the hash.
This just does a Hash insert and updates the list if the hash was actually
inserted.

=cut

sub insert($$$) {
	my($self,$keyx,$valx)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Ohash");
	if($self->Meta::Ds::Hash::insert($keyx,$valx)) {
		my($list)=$self->{KEYX};
		my($num1)=push(@$list,$keyx);
		my($tsil)=$self->{VALX};
		my($num2)=push(@$tsil,$valx);
		my($numb)=$num1;#arbitrary
		$self->{OHASH}->{$keyx}=$numb;
		return(1);
	} else {
		return(0);
	}
}

=item B<remove($$)>

Remove an element from the hash.
This just calls the Meta::Ds::Hash remove and removes the element from the
list if it was successful.

=cut

sub remove($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Ohash");
	if($self->Meta::Ds::Hash::remove($elem)) {
		my($numb)=$self->{OHASH}->{$elem};
		#now remove the element number $numb from both list and tsil
		#and update ohash accordingly.
		#mind that ->size is already less by 1 because we are after
		#the remove
		my($list)=$self->{KEYX};
		my($tsil)=$self->{VALX};
		for(my($i)=$numb+1;$i<=$self->size();$i++) {
			$list->[$i]=$list->[$i+1];
			$tsil->[$i]=$tsil->[$i+1];
			$self->{OHASH}->{$list->[$i]}--;
		}
		$#$list--;
		$#$tsil--;
		return(1);
	} else {
		return(0);
	}
}

=item B<elem($$)>

This returns a specific element in the hash.

=cut

sub elem($$) {
	my($self,$elem)=@_;
	return($self->{VALX}->[$elem]);
}

=item B<keyx($$)>

This returns the key with the specified number.

=cut

sub keyx($$) {
	my($self,$elem)=@_;
	return($self->{KEYX}->[$elem]);
}

=item B<valx($$)>

This returns the value with the specified number.

=cut

sub valx($$) {
	my($self,$elem)=@_;
	return($self->{VALX}->[$elem]);
}

=item B<print($$)>

This will print the Ohash object to the specified file for you.

=cut

sub print($$) {
	my($self,$file)=@_;
	my($list)=$self->{LIST};
	my($size)=$self->size();
	for(my($i)=0;$i<$size;$i++) {
		my($keyx)=$self->keyx($i);
		my($valx)=$self->valx($i);
		print $file "[".$keyx."]\n";
		$valx->print($file);
	}
}

=item B<get_elem_number($$)>

This method will give you the sequential number of an element in the ordered hash.

=cut

sub get_elem_number($$) {
	my($self,$elem)=@_;
	return($self->{OHASH}->{$elem});
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
3	Thu Jan  4 13:36:17 2001	MV	ok. This is for real
4	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
5	Sat Jan  6 17:14:09 2001	MV	more perl checks
6	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
7	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
8	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
9	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
10	Thu Jan 11 09:43:58 2001	MV	fix all tests change
11	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
12	Sun Jan 28 02:34:56 2001	MV	perl code quality
13	Sun Jan 28 13:51:26 2001	MV	more perl quality
14	Tue Jan 30 03:03:17 2001	MV	more perl quality
15	Sat Feb  3 23:41:08 2001	MV	perl documentation
16	Mon Feb  5 03:21:02 2001	MV	more perl quality
17	Tue Feb  6 01:04:52 2001	MV	perl qulity code
18	Tue Feb  6 07:02:13 2001	MV	more perl code quality
19	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add/subtract a hash.

-read/write a hash from a file.

-get a list from a hash.

-get a set from a hash.

-get a hash from a list.

-get a hash from a set.

-insert an element and make sure that he wasnt there.

-remove an element and make sure that he was there.

-add a limitation on the types of objects going into the hash (they must be inheritors from some kind of object).

=cut
