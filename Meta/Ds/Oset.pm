#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Oset;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();

our($VERSION,@ISA);
$VERSION="0.26";
@ISA=qw();

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
#sub sort($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{LIST}=Meta::Ds::Array->new();
	return($self);
}

sub insert($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		my($hash)=$self->{HASH};
		$hash->{$elem}=defined;
		my($list)=$self->{LIST};
		$list->push($elem);
	}
}

sub remove($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		my($hash)=$self->{HASH};
		$hash->{$elem}=undef;#remove the element
		my($list)=$self->{LIST};
		$list->remove_first($elem);
	}
}

sub has($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

sub hasnt($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(0);
	} else {
		return(1);
	}
}

sub check_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->hasnt($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is not an element");
	}
}

sub check_not_elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	if($self->has($elem)) {
		Meta::Utils::System::die("elem [".$elem."] is an element");
	}
}

sub print($$) {
	my($self,$file)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($file,"ANY");
	my($list)=$self->{LIST};
	$list->print($file);
}

sub size($) {
	my($self)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
	return($self->{LIST}->size());
}

sub elem($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Oset");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
	return($self->{LIST}->getx($elem));
}

sub sort($$) {
	my($self,$ref)=@_;
	$self->{LIST}->sort($ref);
}

1;

__END__

=head1 NAME

Meta::Ds::Oset - Ordered hash data structure.

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

	MANIFEST: Oset.pm
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Oset qw();
	my($oset)=Meta::Ds::Oset->new();
	$oset->insert("mark");

=head1 DESCRIPTION

This is a set object which is also ordered. This means you can access the
n'th element. You get performance penalties in this implementation (especially
upon removal of elements) so if you dont need the ordered feature please use
the Meta::Ds::Set class.

=head1 FUNCTIONS

	new($)
	insert($$)
	remove($$)
	has($$)
	hasnt($$)
	check_elem($$)
	check_not_elem($$)
	print($$)
	size($)
	elem($$)
	sort($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Oset object.

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
0. An Oset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=item B<check_not_elem($$)>

Thie method receives:
0. An Oset object.
1. An element to check fore.
This method makes sure that the element is a member of the set and
dies if it is not.

=item B<print($$)>

This will print the Oset object to the specified file for you.

=item B<size($)>

This method returns the size of the set.

=item B<elem($$)>

This method receives:
0. An Oset object.
1. A location.
And retrieves the element at that location.

=item B<sort($$)>

This method receives:
0. An Oset object.
1. A comparison function.
And sorts the set according to the comparison function.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV add enumerated types to options
	0.01 MV more on tests/more checks to perl
	0.02 MV fix all tests change
	0.03 MV change new methods to have prototypes
	0.04 MV UI for Opts.pm
	0.05 MV perl code quality
	0.06 MV more perl quality
	0.07 MV more perl quality
	0.08 MV get basic Simul up and running
	0.09 MV perl documentation
	0.10 MV more perl quality
	0.11 MV perl qulity code
	0.12 MV more perl code quality
	0.13 MV revision change
	0.14 MV better general cook schemes
	0.15 MV languages.pl test online
	0.16 MV PDMT/SWIG support
	0.17 MV Pdmt stuff
	0.18 MV perl packaging
	0.19 MV PDMT
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV more thumbnail code
	0.25 MV thumbnail user interface
	0.26 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-how can we ease the performance penalties of the removal of elements ?

-why not inherit from Array ?
