#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Hash;

use strict qw(vars refs subs);
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.34";
@ISA=qw();

#sub new($);
#sub insert($$$);
#sub remove($$);
#sub size($);
#sub has($$);
#sub check_elem($$);
#sub elem($$);
#sub get($$);
#sub print($$);
#sub read($$);
#sub write($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{SIZE}=0;
	return($self);
}

sub insert($$$) {
	my($self,$elem,$valx)=@_;
#	Meta::Utils::Arg::check_arg_num(\@_,3);
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
#	Meta::Utils::Arg::check_arg($elem,"ANY");
#	Meta::Utils::Arg::check_arg($valx,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(0);
	} else {
		$hash->{$elem}=$valx;
		$self->{SIZE}++;
		return(1);
	}
}

sub remove($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		delete($hash->{$elem});
		$self->{SIZE}--;
		return(1);
	} else {
		return(0);
	}
}

sub size($) {
	my($self)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	return($self->{SIZE});
}

sub has($$) {
	my($self,$elem)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

sub check_elem($$) {
	my($self,$elem)=@_;
	if(!($self->has($elem))) {
		Meta::Utils::System::die("elem [".$elem."] is not a member of the hash");
	}
}

sub elem($$) {
	my($self,$elem)=@_;
}

sub get($$) {
	my($self,$elem)=@_;
	if(!$self->has($elem)) {
		Meta::Utils::System::die("I dont have an elem [".$elem."]");
	}
	return($self->{HASH}->{$elem});
}

sub print($$) {
	my($self,$file)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
#	Meta::Utils::Arg::check_arg($file,"ANY");
	my($hash)=$self->{HASH};
	while(my($keyx,$valx)=each(%$hash)) {
		print $file "[".$keyx."]\n";
		$valx->print($file);
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
			Meta::Utils::System::die("number of fields is not 1 in line [".$line."]");
		}
		$self->insert($fiel[0],$fiel[1]);
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

sub write($$) {
	my($self,$file)=@_;
	open(FILE,"> ".$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($hash)=$self->{HASH};
	while(my($keyx,$valx)=each(%$hash)) {
		print FILE $keyx." ".$valx."\n";
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

1;

__END__

=head1 NAME

Meta::Ds::Hash - data structure that represents a hash table.

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

	MANIFEST: Hash.pm
	PROJECT: meta
	VERSION: 0.34

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Hash qw();
	my($hash)=Meta::Ds::Hash->new();
	$hash->insert("mark","veltzer");
	$hash->insert("doro","linus");
	$hash->remove("mark");
	if($hash->has("mark")) {
		Meta::Utils::System::die("error");
	}

=head1 DESCRIPTION

This is a library to let you create a hash like data structure.
"Why should I have such a data strcuture ?" you rightly ask...
Perl already supports hashes as built in structures, but these dont
have a size method (for one...)... This encapsulates hash as a object
and is much better (built over the builtin implementation).
This is a value less hash (no values for the inserted ones...),
so it effectivly acts as a set.

=head1 FUNCTIONS

	new($)
	insert($$$)
	remove($$)
	size($)
	has($$)
	check_elem($$)
	elem($$)
	get($$)
	print($$)
	read($$)
	write($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Hash object.

=item B<insert($$$)>

Inserts an element into the hash.
This receives:
0. Hash object.
1. Element to insert.
2. Value to insert.
This returns whether the value was actually inserted.

=item B<remove($$)>

Remove an element from the hash.
This receives:
0. Hash object.
1. Element to remove.
This returns whether the value was actually removed.

=item B<size($)>

Return the number of elements in the hash.
This receives:
0. Hash object.

=item B<has($$)>

Returns a boolean value according to whether the specified element is
in the hash or not.
This receives:
0. Hash object.
1. Element to check for.

=item B<check_elem($$)>

This method will verify that a certain element is indeed a member of the hash.
If it is not - the method will raise an exception.

=item B<elem($$)>

This returns a specific element in the hash.

=item B<get($$)>

This returns a certain element from the hash.

=item B<print($$)>

This will print the hash while running the print routine on each of the sub
elemes.

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

	0.00 MV initial code brought in
	0.01 MV bring databases on line
	0.02 MV handle architectures better
	0.03 MV get the databases to work
	0.04 MV ok. This is for real
	0.05 MV ok - this time I realy mean it
	0.06 MV make quality checks on perl code
	0.07 MV more perl checks
	0.08 MV make Meta::Utils::Opts object oriented
	0.09 MV check that all uses have qw
	0.10 MV fix todo items look in pod documentation
	0.11 MV add enumerated types to options
	0.12 MV more on tests/more checks to perl
	0.13 MV change new methods to have prototypes
	0.14 MV correct die usage
	0.15 MV finish Simul documentation
	0.16 MV perl code quality
	0.17 MV more perl quality
	0.18 MV more perl quality
	0.19 MV perl documentation
	0.20 MV more perl quality
	0.21 MV perl qulity code
	0.22 MV more perl code quality
	0.23 MV revision change
	0.24 MV languages.pl test online
	0.25 MV PDMT/SWIG support
	0.26 MV Pdmt stuff
	0.27 MV perl packaging
	0.28 MV md5 project
	0.29 MV database
	0.30 MV perl module versions in files
	0.31 MV movies and small fixes
	0.32 MV more thumbnail stuff
	0.33 MV thumbnail user interface
	0.34 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-Add many more routines: 1. add/subtract a hash. 2. get a list from a hash. 3. get a set from a hash. 4. get a hash from a list. 5. get a hash from a set. 6. insert an element and make sure that he wasnt there. 7. remove an element and make sure that he was there.

-add a limitation on the types of objects going into the hash (they must be inheritors from some kind of object).

-make option for hash to be strict (that insert twice will yell).
