#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Hash - data structure that represents a hash table.

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

MANIFEST: Hash.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Ds::Hash qw();>
C<my($hash)=Meta::Ds::Hash->new();>
C<$hash->insert("mark","veltzer");>
C<$hash->insert("doro","linus");>
C<$hash->remove("mark");>
C<if($hash->has("mark")) {>
C<	Meta::Utils::System::die("error");>
C<}>

=head1 DESCRIPTION

This is a library to let you create a hash like data structure.
"Why should I have such a data strcuture ?" you rightly ask...
Perl already supports hashes as built in structures, but these dont
have a size method (for one...)... This encapsulates hash as a object
and is much better (built over the builtin implementation).
This is a value less hash (no values for the inserted ones...),
so it effectivly acts as a set.

=head1 EXPORTS

C<new($)>
C<insert($$$)>
C<remove($$)>
C<size($)>
C<has($$)>
C<check_elem($$)>
C<elem($$)>
C<get($$)>
C<print($$)>
C<read($$)>
C<write($$)>

=cut

package Meta::Ds::Hash;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

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

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Hash object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{HASH}={};
	$self->{SIZE}=0;
	return($self);
}

=item B<insert($$$)>

Inserts an element into the hash.
This receives:
0. Hash object.
1. Element to insert.
2. Value to insert.
This returns whether the value was actually inserted.

=cut

sub insert($$$) {
	my($self,$elem,$valx)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,3);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	Meta::Utils::Arg::check_arg($valx,"ANY");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(0);
	} else {
		$hash->{$elem}=$valx;
		$self->{SIZE}++;
		return(1);
	}
}

=item B<remove($$)>

Remove an element from the hash.
This receives:
0. Hash object.
1. Element to remove.
This returns whether the value was actually removed.

=cut

sub remove($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		delete($hash->{$elem});
		$self->{SIZE}--;
		return(1);
	} else {
		return(0);
	}
}

=item B<size($)>

Return the number of elements in the hash.
This receives:
0. Hash object.

=cut

sub size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	return($self->{SIZE});
}

=item B<has($$)>

Returns a boolean value according to whether the specified element is
in the hash or not.
This receives:
0. Hash object.
1. Element to check for.

=cut

sub has($$) {
	my($self,$elem)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	my($hash)=$self->{HASH};
	if(exists($hash->{$elem})) {
		return(1);
	} else {
		return(0);
	}
}

=item B<check_elem($$)>

This method will verify that a certain element is indeed a member of the hash.
If it is not - the method will raise an exception.

=cut

sub check_elem($$) {
	my($self,$elem)=@_;
	if(!($self->has($elem))) {
		Meta::Utils::System::die("elem [".$elem."] is not a member of the hash");
	}
}

=item B<elem($$)>

This returns a specific element in the hash.

=cut

sub elem($$) {
	my($self,$elem)=@_;
}

=item B<get($$)>

This returns a certain element from the hash.

=cut

sub get($$) {
	my($self,$elem)=@_;
	if(!$self->has($elem)) {
		Meta::Utils::System::die("I dont have an elem [".$elem."]");
	}
	return($self->{HASH}->{$elem});
}

=item B<print($$)>

This will print the hash while running the print routine on each of the sub
elemes.

=cut

sub print($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Hash");
	Meta::Utils::Arg::check_arg($file,"ANY");
	my($hash)=$self->{HASH};
	while(my($keyx,$valx)=each(%$hash)) {
		print $file "[".$keyx."]\n";
		$valx->print($file);
	}
}

=item B<read($$)>

This will read a hash from a file assuming that file has an entry for the
hash as two string separated by a space on each line until the end of the
file.

=cut

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

=item B<write($$)>

This will write a hash table as in the read method. See that methods
documentation for details.

=cut

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

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
3	Wed Jan  3 07:02:01 2001	MV	handle architectures better
4	Wed Jan  3 11:26:48 2001	MV	get the databases to work
5	Thu Jan  4 13:36:17 2001	MV	ok. This is for real
6	Thu Jan  4 18:28:58 2001	MV	ok - this time I realy mean it
7	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
8	Sat Jan  6 17:14:09 2001	MV	more perl checks
9	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
10	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
11	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
12	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
13	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
14	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
15	Thu Jan 18 15:59:13 2001	MV	correct die usage
16	Thu Jan 25 20:55:06 2001	MV	finish Simul documentation
17	Sun Jan 28 02:34:56 2001	MV	perl code quality
18	Sun Jan 28 13:51:26 2001	MV	more perl quality
19	Tue Jan 30 03:03:17 2001	MV	more perl quality
20	Sat Feb  3 23:41:08 2001	MV	perl documentation
21	Mon Feb  5 03:21:02 2001	MV	more perl quality
22	Tue Feb  6 01:04:52 2001	MV	perl qulity code
23	Tue Feb  6 07:02:13 2001	MV	more perl code quality
24	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-Add many more routines: 1. add/subtract a hash. 2. get a list from a hash. 3. get a set from a hash. 4. get a hash from a list. 5. get a hash from a set. 6. insert an element and make sure that he wasnt there. 7. remove an element and make sure that he was there.

-add a limitation on the types of objects going into the hash (they must be inheritors from some kind of object).

-make option for hash to be strict (that insert twice will yell).

=cut
