#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Hash - general base utility library for many hash functions.

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
C<use Meta::Utils::Hash qw();>
C<my(%hash);>
C<Meta::Utils::Hash::print(*FILE,\%hash);>

=head1 DESCRIPTION

This is a general utility perl library for all kinds of hash routines.
This mainly iterates hashes using the each builtin which is the fastest
to do the job and like the list library uses refernces to avoid duplication
whereever possible.

=head1 EXPORTS

C<size($)>
C<empty($)>
C<notempty($)>
C<read($)>
C<read_exe($)>
C<cmp($$$$$)>
C<print($$)>
C<to_list($)>
C<add_hash($$)>
C<remove_hash($$$)>
C<add_prefix($$)>
C<add_suffix($$)>
C<system($$$$)>
C<add_key_prefix($$)>
C<add_key_suffix($$)>
C<filter_prefix($$$)>
C<filter_prefix_add($$$$)>
C<filter_multi($$$$)>
C<filter_suffix($$$)>
C<filter_regexp($$$)>
C<filter_regexp_add($$$$)>
C<filter_file_sing_regexp($$$)>
C<filter_which($$$)>
C<filter_exists($)>
C<filter_notexists($)>
C<save($$)>
C<load($$)>

=cut

package Meta::Utils::Hash;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Utils qw();
use Meta::Utils::File::File qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub size($);
#sub empty($);
#sub notempty($);
#sub read($);
#sub read_exe($);
#sub cmp($$$$$);
#sub print($$);
#sub to_list($);
#sub add_hash($$);
#sub remove_hash($$$);
#sub add_prefix($$);
#sub add_suffix($$);
#sub system($$$$);

#sub add_key_prefix($$);
#sub add_key_suffix($$);

#sub filter_prefix($$$);
#sub filter_prefix_add($$$$);
#sub filter_multi($$$$);
#sub filter_suffix($$$);
#sub filter_regexp($$$);
#sub filter_regexp_add($$$$);
#sub filter_file_sing_regexp($$$);
#sub filter_which($$$);
#sub filter_exists($);
#sub filter_notexists($);

#sub save($$);
#sub load($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<cmp($$$$$)>

This functions compares two hashes according to keys and prints the values
which exists in any of them but not in the other
The return value is a boolean which is true iff the two hashes are equal.
The routine also receives a boolean value telling it to be verbose or not.

=cut

sub cmp($$$$$) {
	my($has1,$nam1,$has2,$nam2,$verb)=@_;
	Meta::Utils::Arg::check_arg($has1,"HASH");
	Meta::Utils::Arg::check_arg($nam1,"SCALAR");
	Meta::Utils::Arg::check_arg($has2,"HASH");
	Meta::Utils::Arg::check_arg($nam2,"SCALAR");
	my($name,$valx);
	my($stat)=0;
	while(($name,$valx)=each(%$has1)) {
		if(!exists($has2->{$name})) {
			if($verb) {
				Meta::Utils::Output::print("[".$name."] in [".$nam1."] and not in [".$nam2."]\n");
			}
			$stat=1;
		}
	}
	while(($name,$valx)=each(%$has2)) {
		if(!exists($has1->{$name})) {
			if($verb) {
				Meta::Utils::Output::print("[".$name."] in [".$nam2."] and not in [".$nam1."]\n");
			}
			$stat=1;
		}
	}
	return(!$stat);
}

=item B<print($$)>

This prints out the hash given to it.
The first argument is a file.

=cut

sub print($$) {
	my($file,$hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	while(my($key,$val)=each(%$hash)) {
		print $file $key."\n";
	}
}

=item B<to_list($)>

This takes a hash reference as input and produces a list which has all the
keys in the hash in it. since the keys in the hash are unique the list is
unique also...:)

=cut

sub to_list($) {
	my($hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	my(@list);
	while(my($key,$val)=each(%$hash)) {
		push(@list,$key);
	}
	return(\@list);
}

=item B<add_hash($$)>

This function receives two hashes and adds the second one to the first
one the fastest way possible.

=cut

sub add_hash($$) {
	my($from,$hash)=@_;
	Meta::Utils::Arg::check_arg($from,"HASH");
	Meta::Utils::Arg::check_arg($hash,"HASH");
	while(my($key,$val)=each(%$hash)) {
		$from->{$key}=$val;
	}
}

=item B<remove_hash($$$)>

This function receives:
0. A source hash.
1. A hash to remove from the source hash.
2. A strict parameter to tell the function whether to die if an element is
	in the subtracted hash but not in the source one.
The function changes the source hash so as not to contain any elements in
the removed hash.
The function doesnt return anything.

=cut

sub remove_hash($$$) {
	my($from,$hash,$stri)=@_;
	Meta::Utils::Arg::check_arg($from,"HASH");
	Meta::Utils::Arg::check_arg($hash,"HASH");
	while(my($keyx,$valx)=each(%$hash)) {
		if(exists($from->{$keyx})) {
			delete($from->{$keyx});
		} else {
			if($stri) {
				Meta::Utils::System::die("elem [".$keyx."] is a bad value");
			}
		}
	}
}

=item B<add_prefix($$)>

This routine adds a constant prefix to all the element in a hash.
Traversal (ofcourse) is using the each operator

=cut

sub add_prefix($$) {
	my($hash,$pref)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($pref,"SCALAR");
	my(%resu);
	while(my($key,$val)=each(%$hash)) {
		$resu{$key}=$pref.$hash->{$key};
	}
	return(\%resu);
}

=item B<add_suffix($$)>

This routine adds a constant suffix to all the element in a hash.
Traversal (ofcourse) is using the each operator

=cut

sub add_suffix($$) {
	my($hash,$suff)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($suff,"SCALAR");
	my(%resu);
	while(my($key,$val)=each(%$hash)) {
		$resu{$key}=$hash->{$key}.$suff;
	}
	return(\%resu);
}

=item B<add_key_prefix($$)>

This routine adds a constant prefix to all the keys in a hash.
Traversal (ofcourse) is using the each operator

=cut

sub add_key_prefix($$) {
	my($hash,$pref)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($pref,"SCALAR");
	my(%resu);
	while(my($key,$val)=each(%$hash)) {
		$resu{$pref.$key}=$val;
	}
	return(\%resu);
}

=item B<add_key_suffix($$)>

This routine adds a constant suffix to all the keys in a hash.
Traversal (ofcourse) is using the each operator.

=cut

sub add_key_suffix($$) {
	my($hash,$suff)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($suff,"SCALAR");
	my(%resu);
	while(my($key,$val)=each(%$hash)) {
		$resu{$key.$suff}=$val;
	}
	return(\%resu);
}

=item B<read($)>

This reads a hash table from a file by assuming that every line is
a key and giving all the keys a value of undef.
That means that the key will exist but the value will be undefined.

=cut

sub read($) {
	my($file)=@_;
	my(%hash);
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		$hash{$line}=defined;
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return(\%hash);
}

=item B<read_exe($)>

This routine is the same as read except that the argument is
a command line to run out of which will come the stdout file that we need
to run. Why not just dump the outcome to a temp file and then read it
using the previous routine ? because its stupid and uses the disk which
we do not need to do...
What we do is just pipe the output to a file that we open and execute
the same algorithm as before.
As it turns out we do call the previous routine but we change the file
argument to mean "the stdout stream that comes out of the "$cmd" command"...

=cut

sub read_exe($) {
	my($exe)=@_;
	return(&read("$exe |"));
}

=item B<filter_prefix($$$)>

This routines receives a hash and a prefix and returns a hash with only
the elements in the original hash which have such a prefix...
This also receives the a third argument that instructs it to act as a negative
or a positive filter.

=cut

sub filter_prefix($$$) {
	my($hash,$pref,$posi)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($pref,"SCALAR");
	Meta::Utils::Arg::check_arg($posi,"SCALAR");
	my(%retu);
	filter_prefix_add($hash,$pref,$posi,\%retu);
	return(\%retu);
}

=item B<filter_prefix_add($$$$)>

This routine filters according to prefix and instruction a certain hash and
adds the results to a second.

=cut

sub filter_prefix_add($$$$) {
	my($hash,$pref,$posi,$retu)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($pref,"SCALAR");
	Meta::Utils::Arg::check_arg($posi,"SCALAR");
	Meta::Utils::Arg::check_arg($retu,"HASH");
	while(my($keyx,$valx)=each(%$hash)) {
		if(Meta::Utils::Utils::is_prefix($keyx,$pref)) {
			if($posi) {
				$retu->{$keyx}=$valx;
			}
		} else {
			if(!$posi) {
				$retu->{$keyx}=$valx;
			}
		}
	}
}

=item B<filter_multi($$$$)>

This one is a full filter. This gets:
0. a hash.
1. whether to do filtering or not.
2. boolean indicating whether filter is negative or positive.
3. list of modules for filtering data.
And does the entire filtering process in an efficient manner.

=cut

sub filter_multi($$$$) {
	my($hash,$dmod,$dire,$modu)=@_;
	my(@modu)=split(':',$modu);
	my(%rhas);
	if($dmod) {
		if($dire!=2) {
			for(my($i)=0;$i<=$#modu;$i++) {
				&filter_prefix_add($hash,$modu[$i]."/",$dire,\%rhas);
			}
		}
		return(\%rhas);
	} else {
		return($hash);
	}
}

=item B<filter_suffix($$$)>

This routines receives a hash and a suffix and returns a hash with only
the elements in the original hash which had such a suffix...
This also receives the a third argument that instructs it to act as a negative
or a positive filter.

=cut

sub filter_suffix($$$) {
	my($hash,$filt,$posi)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($filt,"SCALAR");
	Meta::Utils::Arg::check_arg($posi,"SCALAR");
	my(%retu);
	while(my($key,$val)=each(%$hash)) {
		if(Meta::Utils::Utils::is_suffix($key,$filt)) {
			if($posi) {
				$retu{$key}=$val;
			}
		} else {
			if(!$posi) {
				$retu{$key}=$val;
			}
		}
	}
	return(\%retu);
}

=item B<filter_regexp($$$)>

This routine filters to the result hash all elements of the hash it
gets which match a regular expression.
There is also a third argument telling the filter to act as positive or
negative.

=cut

sub filter_regexp($$$) {
	my($hash,$rege,$posi)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($rege,"SCALAR");
	Meta::Utils::Arg::check_arg($posi,"SCALAR");
	my(%retu);
	filter_regexp_add($hash,$rege,$posi,\%retu);
	return(\%retu);
}

=item B<filter_regexp_add($$$$)>

This routine adds to the received hash all the elements of the hash that
match/not match (according to the posi argument) elements of the current hash.

=cut

sub filter_regexp_add($$$$)
{
	my($hash,$rege,$posi,$retu)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($rege,"SCALAR");
	Meta::Utils::Arg::check_arg($posi,"SCALAR");
	Meta::Utils::Arg::check_arg($retu,"HASH");
	while(my($keyx,$valx)=each(%$hash)) {
		if($keyx=~/$rege/) {
			if($posi) {
				$retu->{$keyx}=$valx;
			}
		} else {
			if(!$posi) {
				$retu->{$keyx}=$valx;
			}
		}
	}
}

=item B<empty($)>

This routine receives a hash reference.
This routine returns a boolean value according to whether the hash is
empty or not

=cut

sub empty($) {
	my($hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	return(size($hash)==0);
}

=item B<notempty($)>

This routine receives a hash reference.
This routine returns a boolean value accroding to whether the hash is
not empty or not

=cut

sub notempty($) {
	my($hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	return(size($hash)>0);
}

=item B<system($$$$)>

This routine runs a system command for all keys of a hash.
The inputs are: the hash,the system command,demo and verbose.

=cut

sub system($$$$) {
	my($hash,$syst,$demo,$verb)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	while(my($key,$val)=each(%$hash)) {
		if($verb) {
			Meta::Utils::Output::print("doing [".$syst."] [".$key."]\n");
		}
		if(!$demo) {
			Meta::Utils::System::system($syst,[$key]);
		}
	}
}

=item B<size($)>

This routine returns the number of elements in the hash (actual elements
and not in the strange convention for perl where you need to do i=0;i<=num...

=cut

sub size($) {
	my($hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	my(@list)=keys(%$hash);
	my($retu)=$#list;
	$retu++;
	return($retu);
}

=item B<filter_file_sing_regexp($$$)>

This routine receives a hash and a regular expression and returns a hash
containing only the elements in the hash which are pointers to files which
contain a the regular expression.
This also receives as the third variable whether to print the matched lines
or not (this is passes along to Meta::Utils::File::File::check_sing_regexp).

=cut

sub filter_file_sing_regexp($$$) {
	my($hash,$rege,$prin)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	Meta::Utils::Arg::check_arg($rege,"SCALAR");
	Meta::Utils::Arg::check_arg($prin,"SCALAR");
	my(%retu);
	while(my($key,$val)=each(%$hash)) {
		if(Meta::Utils::File::File::check_sing_regexp($key,$rege,$prin)) {
			$retu{$key}=$val;
		}
	}
	return(\%retu);
}

=item B<filter_which()>

This needs to be written.

=cut

=item B<filter_notexists($)>

This does the exact opposite of the previous routine.
Should we also have the same routine that actually does the manipulation on
the list itself ? it would be faster...

=cut

sub filter_notexists($) {
	my($hash)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
	my(%inte);
	while(my($keyx,$valx)=each(%$hash)) {
		my($curr)=$keyx;
		if(!(-e $curr)) {
			$inte{$curr}=defined;
		}
	}
	return(\%inte);
}

=item B<save($$)>

This routine saves the entire hash to a disk file.

=cut

sub save($$) {
	my($hash,$file)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
}

=item B<load($$)>

This routine loads the entire hash from a disk file.

=cut

sub load($$) {
	my($hash,$file)=@_;
	Meta::Utils::Arg::check_arg($hash,"HASH");
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
2	Thu Jan  4 06:30:32 2001	MV	this time really make the databases work
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 17:00:22 2001	MV	fix up perl checks
7	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
8	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
9	Thu Jan 11 09:43:58 2001	MV	fix all tests change
10	Fri Jan 12 09:25:33 2001	MV	more perl quality
11	Thu Jan 18 15:59:13 2001	MV	correct die usage
12	Sun Jan 28 02:34:56 2001	MV	perl code quality
13	Sun Jan 28 13:51:26 2001	MV	more perl quality
14	Tue Jan 30 03:03:17 2001	MV	more perl quality
15	Sat Feb  3 23:41:08 2001	MV	perl documentation
16	Mon Feb  5 03:21:02 2001	MV	more perl quality
17	Tue Feb  6 01:04:52 2001	MV	perl qulity code
18	Tue Feb  6 07:02:13 2001	MV	more perl code quality
19	Tue Feb  6 08:47:46 2001	MV	more perl quality
20	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-improve the print routine by adding modifiers to the output.

-cant we do the size more efficiently ?

-do the sub filter_file_mult_regexp($$) routine

-the read_exe routine gets a shell command line and sometimes you dont want that overhead. make a routine that does the same and doesnt pass through the shell and check where the current routine is used and replace where ever possible.

=cut
