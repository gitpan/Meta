#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Array - data structure that represents a array table.

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

MANIFEST: Array.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Ds::Array qw();>
C<my($array)=Meta::Ds::Array->new();>
C<$array->push("mark");>
C<$array->setx(5,"mark");>
C<Meta::Utils::Output::print($array->getx(0));>
C<Meta::Utils::Output::print($array->size()."\n");>

=head1 DESCRIPTION

This is a library to let you create an array like data structure.
"Why should I have such a data strcuture ?" you rightly ask...
Perl already supports arrays as built in structures.
But the usage of the perl array is cryptic and non object oriented
(try to inherit from an array..:)
This will give you a clean object.

=head1 EXPORTS

C<new($)>
C<push($$)>
C<getx($$)>
C<setx($$$)>
C<remove($$)>
C<remove_first($$)>
C<size($)>
C<print($$)>

=cut

package Meta::Ds::Array;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Arg qw();
use Meta::Utils::System qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub push($$);
#sub getx($$);
#sub setx($$$);
#sub remove($$);
#sub remove_first($$);
#sub size($);
#sub print($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Array object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{LIST}=[];
	return($self);
}

=item B<push($$)>

Inserts an element into the array.
This receives:
0. Array object.
1. Element to insert.

=cut

sub push($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	my($arra)=$self->{LIST};
	my($nums)=push(@$arra,$elem);
}

=item B<getx($$)>

Get an element from a certain location in the array.
This receives:
0. Array object.
1. Element number to get.
This returns the n'th elemnt from the array.

=cut

sub getx($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	my($arra)=$self->{LIST};
	return($arra->[$elem]);
}

=item B<setx($$$)>

This receives:
0. Array object.
1. Location.
2. Element to put.

=cut

sub setx($$$) {
	my($self,$loca,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	Meta::Utils::Arg::check_arg($loca,"ANY");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($arra)=$self->{LIST};
	$arra->[$loca]=$elem;
}

=item B<remove($$)>

This method receives:
0. Array object.
1. Location at which to remove an element.
And remove the element at that location.

=cut

sub remove($$) {
	my($self,$loca)=@_;
#	Meta::Utils::Output::print("loca is [".$loca."]\n");
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	Meta::Utils::Arg::check_arg($loca,"ANY");
	my($arra)=$self->{LIST};
	for(my($i)=$loca;$i<$self->size()-1;$i++) {
#		Meta::Utils::Output::print("removing\n");
#		$arra->[$loca]->print(Meta::Utils::Output::get_file());
#		Meta::Utils::Output::print("and putting\n");
#		$arra->[$loca+1]->print(Meta::Utils::Output::get_file());
		$arra->[$loca]=$arra->[$loca+1];
	}
	$#$arra-=1;
}

=item B<remove_first($$)>

This method receives:
0. Array object.
1. Elemet to remove.
And it removes the first occurance of the element from the array.

=cut

sub remove_first($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	for(my($i)=0;$i<$self->size();$i++) {
		if($self->getx($i) eq $elem) {
			$self->remove($i);
			return;
		}
	}
	Meta::Utils::System::die("unable to find element [".$elem."]");
}

=item B<size($$)>

This returs the size of the array.
This receives:
0. Array object.

=cut

sub size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	my($arra)=$self->{LIST};
	return($#$arra+1);
}

=item B<print($$)>

This will print an array of printable objects.

=cut

sub print($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Array");
	Meta::Utils::Arg::check_arg($file,"ANY");
	my($arra)=$self->{LIST};
	my($size)=$#$arra+1;
	print $file "size of array is [".$size."]\n";
	for(my($i)=0;$i<$size;$i++) {
		$arra->[$i]->print($file);
	}
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
6	Tue Jan  9 17:00:22 2001	MV	fix up perl checks
7	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
7	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
8	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
9	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
10	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
11	Tue Jan 23 14:08:51 2001	MV	Java simulation framework
12	Sun Jan 28 02:34:56 2001	MV	perl code quality
13	Sun Jan 28 13:51:26 2001	MV	more perl quality
14	Tue Jan 30 03:03:17 2001	MV	more perl quality
15	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
16	Sat Feb  3 23:41:08 2001	MV	perl documentation
17	Mon Feb  5 03:21:02 2001	MV	more perl quality
18	Tue Feb  6 01:04:52 2001	MV	perl qulity code
19	Tue Feb  6 07:02:13 2001	MV	more perl code quality
20	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
