#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Set;

use strict qw(vars refs subs);
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.35";
@ISA=qw();

#sub new($);
#sub clear($);
#sub insert($$);
#sub remove($$);
#sub has($$);
#sub hasnt($$);
#sub check_elem($$);
#sub check_not_elem($$);
#sub print($$);
#sub size($);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{SIZE}=0;
	return($self);
}

sub clear($) {
	my($self)=@_;
	my($hash)=$self->{HASH};
	while(my($key,$val)=each(%$hash)) {
		$self->remove($key);
	}
}

sub insert($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is a set element");
	} else {
		$self->{HASH}->{$elem}=defined;
		$self->{SIZE}++;
	}
}

sub remove($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		delete($self->{HASH}->{$elem});
		$self->{SIZE}--;
	} else {
		Meta::Utils::System::die("elem [".$elem."] is not a set element");
	}
}

sub has($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if(exists($self->{HASH}->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

sub hasnt($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if(exists($self->{HASH}->{$elem})) {
		return(0);
	} else {
		return(1);
	}
}

sub check_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is not an element of the set");
	}
}

sub check_not_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is an element of the set");
	}
}

sub print($$) {
	my($self,$file)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
#	Meta::Utils::Arg::check_arg($file,"ANY");
	my($hash)=$self->{HASH};
	while(my($keyx,$valx)=each(%$hash)) {
		print $file $keyx."\n";
	}
}

sub size($) {
	my($self)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Set");
	return($self->{SIZE});
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Ds::Set - data structure that represents a set.

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

	MANIFEST: Set.pm
	PROJECT: meta
	VERSION: 0.35

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Set qw();
	my($set)=Meta::Ds::Set->new();
	$set->insert("mark");

=head1 DESCRIPTION

This is a library to let you create a set like data structure.
The set data structure is akin to the mathematical object of a set.
A set is a collection of items where duplicates are not allowed (if
you insert an item which is already in the set the set does not
change).
The sets operations are mainly insert, remove and testing whether
elements are memebers of it or not.
The set here is not ordered so you CANT iterate it's elements.
If you do want to iterate them use the Oset object. If you don't -
use this object and same time and memory. Don't worry - if you don't
know if you do or you don't - use this object for starters - if you
wind up needing iteration just switch to using the Oset - they have
the same interface so you will only need to change your code in the use
and object construction points.
The implementation is simply based on a perl hash table and does not
use the capability of the hash table to store value items beside the
keys in the table.

=head1 FUNCTIONS

	new($)
	clear($)
	insert($$)
	remove($$)
	has($$)
	hasnt($$)
	check_elem($$)
	check_not_elem($$)
	print($$)
	size($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Set object.

=item B<clear($)>

This will clear the set (make it the empty set).

=item B<insert($$)>

Inserts a new element into the set.

=item B<remove($$)>

Removes an element from the set.

=item B<has($$)>

Returns whether the current element is a member of the set.

=item B<hasnt($$)>

Returns whether the current element is not a member of the set.

=item B<check_elem($$)>

Check that the element received is in the set and die if it is not.
This method receives:
0. The object handle.
1. The element to check for.
This method does not return anything.

=item B<check_not_elem($$)>

Check that the element received is in not the set and die if it is.
This method receives:
0. The object handle.
1. The element to check for.
This method does not return anything.

=item B<print($$)>

Prints the current set to a specified file.
This method receives:
0. The object handle.
1. The file handle to print to.
This method returns nothing.

=item B<size($)>

Return the size of the set. The real size (not size-1).
This method receives:
0. The object handle.
This method returns the size of the set object in question.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV bring databases on line
	0.02 MV ok. This is for real
	0.03 MV make quality checks on perl code
	0.04 MV more perl checks
	0.05 MV make Meta::Utils::Opts object oriented
	0.06 MV check that all uses have qw
	0.07 MV fix todo items look in pod documentation
	0.08 MV more on tests/more checks to perl
	0.09 MV silense all tests
	0.10 MV correct die usage
	0.11 MV finish Simul documentation
	0.12 MV perl code quality
	0.13 MV more perl quality
	0.14 MV more perl quality
	0.15 MV get basic Simul up and running
	0.16 MV perl documentation
	0.17 MV more perl quality
	0.18 MV perl qulity code
	0.19 MV more perl code quality
	0.20 MV revision change
	0.21 MV languages.pl test online
	0.22 MV PDMT/SWIG support
	0.23 MV Pdmt stuff
	0.24 MV perl packaging
	0.25 MV some chess work
	0.26 MV md5 project
	0.27 MV database
	0.28 MV perl module versions in files
	0.29 MV movies and small fixes
	0.30 MV more thumbnail code
	0.31 MV thumbnail user interface
	0.32 MV more thumbnail issues
	0.33 MV website construction
	0.34 MV web site automation
	0.35 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
