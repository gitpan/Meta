#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Oset - Ordered hash data structure.

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

MANIFEST: Oset.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Ds::Oset qw();>
C<my($oset)=Meta::Ds::Oset->new();>
C<$oset->insert("mark");>

=head1 DESCRIPTION

This is a set object which is also ordered. This means you can access the
n'th element. You get performance penalties in this implementation (especially
upon removal of elements) so if you dont need the ordered feature please use
the Meta::Ds::Set class.

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
C<elem($$)>

=cut

package Meta::Ds::Oset;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Array qw();

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
#sub elem($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Oset object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{LIST}=Meta::Ds::Array->new();
	return($self);
}

=item B<insert($$)>

This inserts a new element into the Set.
If the element is already an element it is not an error.

=cut

sub insert($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		my($hash)=$self->{HASH};
		$hash->{$elem}=defined;
		my($list)=$self->{LIST};
		$list->push($elem);
	}
}

=item B<remove($$)>

This removes an element from the Set.
If the element is not an element of the set it is not an error.

=cut

sub remove($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		my($hash)=$self->{HASH};
		$hash->{$elem}=undef;#remove the element
		my($list)=$self->{LIST};
		$list->remove_first($elem);
	}
}

=item B<has($$)>

This returns whether a specific element is a member of the set.

=cut

sub has($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

=item B<hasnt($$)>

This returns whether a specific element is not a member of the set.

=cut

sub hasnt($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(0);
	} else {
		return(1);
	}
}

=item B<check_elem($$)>

Thie method receives:
0. An Oset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=cut

sub check_elem($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is not an element");
	}
}

=item B<check_not_elem($$)>

Thie method receives:
0. An Oset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=cut

sub check_not_elem($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is an element");
	}
}

=item B<print($$)>

This will print the Oset object to the specified file for you.

=cut

sub print($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($file,"ANY");
	my($list)=$self->{LIST};
	$list->print($file);
}

=item B<size($)>

This method returns the size of the set.

=cut

sub size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	return($self->{LIST}->size());
}

=item B<elem($$)>

This method receives:
0. An Oset object.
1. A location.
And retrieves the element at that location.

=cut

sub elem($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	return($self->{LIST}->getx($elem));
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
2	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
3	Thu Jan 11 09:43:58 2001	MV	fix all tests change
4	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
5	Sat Jan 13 08:28:57 2001	MV	UI for Opts.pm
6	Sun Jan 28 02:34:56 2001	MV	perl code quality
7	Sun Jan 28 13:51:26 2001	MV	more perl quality
8	Tue Jan 30 03:03:17 2001	MV	more perl quality
9	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
10	Sat Feb  3 23:41:08 2001	MV	perl documentation
11	Mon Feb  5 03:21:02 2001	MV	more perl quality
12	Tue Feb  6 01:04:52 2001	MV	perl qulity code
13	Tue Feb  6 07:02:13 2001	MV	more perl code quality
14	Tue Feb  6 22:19:51 2001	MV	revision change
14	Thu Feb  8 00:23:21 2001	MV	betern general cook schemes
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-how can we ease the performance penalties of the removal of elements ?

=cut
