#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Ohash;

use strict qw(vars refs subs);
use Meta::Ds::Hash qw();

our($VERSION,@ISA);
$VERSION="0.31";
@ISA=qw(Meta::Ds::Hash);

#sub new($);
#sub insert($$$);
#sub remove($$);
#sub elem($$);
#sub keyx($$);
#sub valx($$);
#sub print($$);
#sub get_elem_number($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Hash->new();
	bless($self,$clas);
	$self->{KEYX}=[];
	$self->{VALX}=[];
	$self->{OHASH}={};
	return($self);
}

sub insert($$$) {
	my($self,$keyx,$valx)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Ohash");
	if($self->Meta::Ds::Hash::insert($keyx,$valx)) {
		my($list)=$self->{KEYX};
		my($num1)=push(@$list,$keyx);
		my($tsil)=$self->{VALX};
		my($num2)=push(@$tsil,$valx);
		my($numb)=$num1-1;#arbitrary
		$self->{OHASH}->{$keyx}=$numb;
		return(1);
	} else {
		return(0);
	}
}

sub remove($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Ohash");
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

sub elem($$) {
	my($self,$elem)=@_;
	return($self->{VALX}->[$elem]);
}

sub keyx($$) {
	my($self,$elem)=@_;
	return($self->{KEYX}->[$elem]);
}

sub valx($$) {
	my($self,$elem)=@_;
	return($self->{VALX}->[$elem]);
}

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

sub get_elem_number($$) {
	my($self,$elem)=@_;
	return($self->{OHASH}->{$elem});
}

1;

__END__

=head1 NAME

Meta::Ds::Ohash - Ordered hash data structure.

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

	MANIFEST: Ohash.pm
	PROJECT: meta
	VERSION: 0.31

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Ohash qw();

=head1 DESCRIPTION

This is an object which is a hash table which can also give you a random
element.

=head1 FUNCTIONS

	new($)
	insert($$$)
	remove($$)
	elem($$)
	keyx($$)
	valx($$)
	print($$)
	get_elem_number($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Ohash object.

=item B<insert($$$)>

Inserts an element into the hash.
This just does a Hash insert and updates the list if the hash was actually
inserted.

=item B<remove($$)>

Remove an element from the hash.
This just calls the Meta::Ds::Hash remove and removes the element from the
list if it was successful.

=item B<elem($$)>

This returns a specific element in the hash.

=item B<keyx($$)>

This returns the key with the specified number.

=item B<valx($$)>

This returns the value with the specified number.

=item B<print($$)>

This will print the Ohash object to the specified file for you.

=item B<get_elem_number($$)>

This method will give you the sequential number of an element in the ordered hash.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV bring databases on line
	0.02 MV ok. This is for real
	0.03 MV make quality checks on perl code
	0.04 MV more perl checks
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV add enumerated types to options
	0.08 MV more on tests/more checks to perl
	0.09 MV fix all tests change
	0.10 MV change new methods to have prototypes
	0.11 MV perl code quality
	0.12 MV more perl quality
	0.13 MV more perl quality
	0.14 MV perl documentation
	0.15 MV more perl quality
	0.16 MV perl qulity code
	0.17 MV more perl code quality
	0.18 MV revision change
	0.19 MV languages.pl test online
	0.20 MV finish db export
	0.21 MV upload system revamp
	0.22 MV PDMT/SWIG support
	0.23 MV perl packaging
	0.24 MV md5 project
	0.25 MV database
	0.26 MV perl module versions in files
	0.27 MV movies and small fixes
	0.28 MV graph visualization
	0.29 MV more thumbnail code
	0.30 MV thumbnail user interface
	0.31 MV more thumbnail issues

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
