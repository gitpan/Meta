#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Noset;

use strict qw(vars refs subs);
use Meta::Ds::Map qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Meta::Ds::Map);

#sub insert($$);
#sub remove($$);
#sub has($$);
#sub hasnt($$);
#sub check_elem($$);
#sub check_not_elem($$);
#sub elem($$);
#sub TEST($);

#__DATA__

sub insert($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	return($self->SUPER::insert($self->size(),$elem));
}

sub remove($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($size)=$self->size();
	my($index)=$self->get_a($elem);
	if($index!=$size-1) {
		my($last)=$self->get_b($size-1);
		$self->SUPER::remove($size-1,$last);
		$self->SUPER::remove($index,$elem);
		$self->SUPER::insert($index,$last);
	} else {
		$self->SUPER::remove($index,$elem);
	}
	return(1);
}

sub has($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	return($self->has_b($elem));
}

sub hasnt($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	return(!$self->has($elem));
}

sub check_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is not an element");
	}
}

sub check_not_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is an element");
	}
}

sub elem($$) {
	my($self,$index)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Noset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	return($self->get_b($index));
}

sub TEST($) {
	my($context)=@_;
	my($set)=__PACKAGE__->new();
	$set->insert("el1");
	$set->insert("el2");
	$set->insert("el3");
	Meta::Utils::Output::dump($set);
	$set->remove("el2");
	Meta::Utils::Output::dump($set);
	return(1);
}

1;

__END__

=head1 NAME

Meta::Ds::Noset - Ordered hash data structure.

=head1 COPYRIGHT

Copyright (C) 2001, 2002 Mark Veltzer;
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

	MANIFEST: Noset.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Noset qw();
	my($oset)=Meta::Ds::Noset->new();
	$oset->insert("mark");

=head1 DESCRIPTION

This is a set object which is also ordered (meaning you can find
the ordinal number of each element and also the reverse - move from
an ordinal number to the element). The structure is able to hold
any perl object or scalar as element. Duplicates are not allowed (this
is a set after all...). The structure uses a 1-1 mapping to do its
thing by mapping numbers to the elements that you put in. This means
that you can iterate over all elements of the set quite easily with
little performance penalty (except the hash function lookup every
loop). The set also supports the remove operation by changing
the ordinal of the last element to the element which is removed. This
means that removing elements while traversing the ordinals is not
supported. The removal is, however, O(1).

=head1 FUNCTIONS

	insert($$)
	remove($$)
	has($$)
	hasnt($$)
	check_elem($$)
	check_not_elem($$)
	elem($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<insert($$)>

This inserts a new element into the Set.
If the element is already an element it is not an error.

=item B<remove($$)>

This removes an element from the Set.
If the element is not an element of the set it is not an error.

=item B<has($$)>

This returns whether a specific element is a member of the set.

=item B<hasnt($$)>

This returns whether a specific element is not a member of the set.

=item B<check_elem($$)>

Thie method receives:
0. An Noset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=item B<check_not_elem($$)>

Thie method receives:
0. An Noset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=item B<elem($$)>

This method receives:
0. An Noset object.
1. A location.
And retrieves the element at that location.

=item B<TEST($)>

Test suite for this module.

Currently creates a set and manipulates it a little.

=back

=head1 SUPER CLASSES

Meta::Ds::Map(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV teachers project
	0.01 MV more pdmt stuff

=head1 SEE ALSO

Meta::Ds::Map(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
