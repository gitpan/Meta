#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Dhash;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.28";
@ISA=qw();

#sub new($);
#sub insert($$$);
#sub remove_a($$);
#sub remove_b($$);
#sub size($);
#sub has_a($$);
#sub has_b($$);
#sub get_a($$);
#sub get_b($$);
#sub print($$);
#sub read($$);
#sub write($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH_A}={};
	$self->{HASH_B}={};
	$self->{SIZE}=0;
	return($self);
}

sub insert($$$) {
	my($self,$elem_a,$elem_b)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Dhash");
	my($hash_a)=$self->{HASH_A};
	my($hash_b)=$self->{HASH_B};
	if(exists($hash_a->{$elem_a})) {
		return(0);
	}
	if(exists($hash_b->{$elem_b})) {
		return(0);
	}
	$hash_a->{$elem_a}=$elem_b;
	$hash_b->{$elem_b}=$elem_a;
	$self->{SIZE}++;
	return(1);
}

sub remove_a($$) {
	my($self,$elem_a)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Dhash");
	my($hash_a)=$self->{HASH_A};
	my($hash_b)=$self->{HASH_B};
	if(!$self->has_a($elem_a)) {
		return(0);
	}
	my($elem_b)=$self->get_a($elem_a);
	delete($hash_a->{$elem_a});
	delete($hash_b->{$elem_b});
	$self->{SIZE}--;
	return(1);
}

sub size($) {
	my($self)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Dhash");
	return($self->{SIZE});
}

sub has_a($$) {
	my($self,$elem_a)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Dhash");
	my($hash_a)=$self->{HASH_A};
	return(exists($hash_a->{$elem_a}));
}

sub get_a($$) {
	my($self,$elem_a)=@_;
	return($self->{HASH_A}->{$elem_a});
}

sub get_b($$) {
	my($self,$elem_b)=@_;
	return($self->{HASH_B}->{$elem_b});
}

sub print($$) {
	my($self,$file)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Dhash");
#	Meta::Utils::Arg::check_arg($file,"ANY");
	my($hash_a)=$self->{HASH_A};
	while(my($elem_a,$elem_b)=each(%$hash_a)) {
		print $file "[".$elem_a."]-[".$elem_b."]\n";
	}
}

sub read($$) {
	my($self,$file)=@_;
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($line)=0;
	while($line=<FILE> || 0) {
		chop($line);
		my(@fiel)=split(" ",$line);
		if($#fiel!=1) {
			Meta::Utils::System::die("how many filelds are in line [".$line."] ?");
		}
		$self->insert($fiel[0],$fiel[1]);
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

sub write($$) {
	my($self,$file)=@_;
	open(FILE,"> ".$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($hash_a)=$self->{HASH_A};
	while(my($elem_a,$elem_b)=each(%$hash_a)) {
		print FILE $elem_a." ".$elem_b."\n";
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

1;

__END__

=head1 NAME

Meta::Ds::Dhash - data structure that represents a 1-1 hash table.

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

	MANIFEST: Dhash.pm
	PROJECT: meta
	VERSION: 0.28

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Dhash qw();
	my($hash)=Meta::Ds::Dhash->new();
	$hash->insert("mark","veltzer");
	$hash->insert("linus","torvalds");
	$hash->remove("mark");
	$hash->get_a("mark");
	$hash->get_b("linus");

=head1 DESCRIPTION

This is a 1-1 mapping which is held by two hash tables.

=head1 FUNCTIONS

	new($)
	insert($$$)
	remove_a($$)
	remove_b($$)
	size($)
	has_a($$)
	has_b($$)
	get_a($$)
	get_b($$)
	print($$)
	read($$)
	write($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Dhash object.

=item B<insert($$$)>

Inserts an element into the 1-1.
This receives:
0. Dhash object.
1. Element_a to insert.
2. Element_b to insert.
This returns whether the value was actually inserted.

=item B<remove_a($$)>

Remove an element from the 1-1.
This receives:
0. Dhash object.
1. Element to remove.
This returns whether the value was actually removed.

=item B<size($)>

Return the number of elements in the hash.
This receives:
0. Dhash object.

=item B<has_a($$)>

Returns a boolean value according to whether the specified element is
in the hash or not.
This receives:
0. Dhash object.
1. Element_a to check for.

=item B<get_a($$)>

This returns a certain element from the 1-1.
This receives:
0. Dhash object.
1. Elemenet_a to retrieve.

=item B<get_b($$)>

This returns a certain element from the 1-1.
This receives:
0. Dhash object.
1. Elemenet_b to retrieve.

=item B<print($$)>

Print the current graph to a file.
This rourine receives:
0. Dhash object.
1. File to print to.

=item B<read($$)>

This will read a hash from a file assuming that file has an entry for the
hash as two string separated by a space on each line until the end of the
file.

=item B<write($$)>

This will write a hash table as in the read method. See that methods
documentation for details.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV handle architectures better
	0.01 MV ok. This is for real
	0.02 MV make quality checks on perl code
	0.03 MV more perl checks
	0.04 MV make Meta::Utils::Opts object oriented
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV more on tests/more checks to perl
	0.08 MV more perl code quality
	0.09 MV change new methods to have prototypes
	0.10 MV correct die usage
	0.11 MV perl code quality
	0.12 MV more perl quality
	0.13 MV more perl quality
	0.14 MV perl documentation
	0.15 MV more perl quality
	0.16 MV perl qulity code
	0.17 MV more perl code quality
	0.18 MV revision change
	0.19 MV languages.pl test online
	0.20 MV PDMT/SWIG support
	0.21 MV perl packaging
	0.22 MV md5 project
	0.23 MV database
	0.24 MV perl module versions in files
	0.25 MV movies and small fixes
	0.26 MV more thumbnail stuff
	0.27 MV thumbnail user interface
	0.28 MV more thumbnail issues

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

-make option for hash to be strict (that insert twice will yell).
