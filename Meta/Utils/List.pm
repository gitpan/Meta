#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::List - general library for list functions.

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

MANIFEST: List.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::List qw();>
C<my(@list)=["sunday","monday",...];>
C<Meta::Utils::List::print(*FILE,\@list);>

=head1 DESCRIPTION

This is a general utility perl library for list manipulation in perl.
This library works mostly with list references rather than the list
themselves to avoid extra work when copying them.

=head1 EXPORTS

C<size($)>
C<empty($)>
C<notempty($)>
C<cmp($$$$$)>
C<print($$)>
C<add_postfix($$)>
C<to_hash($)>
C<chop($)>
C<add_prefix($$)>
C<add_suffix($$)>
C<add_hash_style($$)>
C<has_elem($$)>
C<add_star($$)>
C<add_endx($$)>
C<filter_prefix($$)>
C<filter_suffix($$)>
C<filter_file_regexp($$)>
C<filter_which($$$)>
C<filter_exists($)>
C<filter_notexists($)>
C<read($)>
C<read_exe($)>
C<equa($$)>
C<is_prefix($$)>

=cut

package Meta::Utils::List;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Arg qw();
use Meta::Utils::Hash qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub size($);
#sub empty($);
#sub notempty($);
#sub cmp($$$$$);
#sub print($$);
#sub add_postfix($$);
#sub to_hash($);
#sub chop($);
#sub add_prefix($$);
#sub add_suffix($$);
#sub add_hash_style($$);
#sub has_elem($$);
#sub add_star($$);
#sub add_endx($$);

#sub filter_prefix($$);
#sub filter_suffix($$);
#sub filter_file_regexp($$);
#sub filter_which($$$);
#sub filter_exists($);
#sub filter_notexists($);

#sub read($);
#sub read_exe($);

#sub equa($$);
#sub is_prefix($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<size($)>

This routine returns the list size at hand (using the #$ shit...)
The input is a list reference.

=cut

sub size($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	my($resu)=$#$list;
	return($resu+1);
}

=item B<empty($)>

This routine receives a list reference.
This routine returns a boolean value according to whether the list is
empty or not

=cut

sub empty($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	return(size($list)==0);
}

=item B<notempty($)>

This routine receives a list reference.
This routine returns a boolean value according to whether the list is
not empty or not

=cut

sub notempty($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	return(size($list)>0);
}

=item B<cmp($$$$$)>

This routine compares two lists by printing any value which is in one of them
but not in the other. This uses the Meta::Utils::Hash::cmp routine to chieve this.
The routine also receives a verbose boolean to direct it whether to write the
differences or not.

=cut

sub cmp($$$$$) {
	my($lst1,$nam1,$lst2,$nam2,$verb)=@_;
	Meta::Utils::Arg::check_arg($lst1,"ARRAY");
	Meta::Utils::Arg::check_arg($nam1,"SCALAR");
	Meta::Utils::Arg::check_arg($lst2,"ARRAY");
	Meta::Utils::Arg::check_arg($nam2,"SCALAR");
	my($has1)=to_hash($lst1);
	my($has2)=to_hash($lst2);
	return(Meta::Utils::Hash::cmp($has1,$nam1,$has2,$nam2,$verb));
}

=item B<print($$)>

This prints out a list.
Currently just receives a list reference as input but could be enriched

=cut

sub print($$) {
	my($file,$list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	my($size)=$#$list+1;
	for(my($i)=0;$i<$size;$i++) {
		print $file $list->[$i]."\n";
	}
}

=item B<add_postfix()>

This postfixes every element in a list.

=cut

sub add_postfix($$) {
	my($list,$post)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($post,"ANY");
	for(my($i)=0;$i<=$#$list;$i++) {
		$list->[$i]=$list->[$i].$post;
	}
}

=item B<to_hash($)>

This converts a list to a hash receiving a list reference and constructing
a hash which has a key value of undef on every list entry and no other values.

=cut

sub to_hash($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	my(%hash);
	for(my($i)=0;$i<=$#$list;$i++) {
		$hash{$list->[$i]}=defined;
	}
	return(\%hash);
}

=item B<chop($)>

This chops up a list, meaning activates the chop function on every element.
This receives a list reference to do the work on.

=cut

sub chop($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	for(my($i)=0;$i<=$#$list;$i++) {
		chop($list->[$i]);
	}
}

=item B<add_prefix($$)>

This adds a prefix to every element of a list.
The input is a list reference and the prefix to be added.

=cut

sub add_prefix($$) {
	my($list,$pref)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($pref,"ANY");
	for(my($i)=0;$i<=$#$list;$i++) {
		$list->[$i]=$pref.$list->[$i];
	}
}

=item B<add_suffix($$)>

This adds a suffix to every element of a list.
The input is a list reference and the suffix to be added.

=cut

sub add_suffix($$) {
	my($list,$suff)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($suff,"ANY");
	for(my($i)=0;$i<=$#$list;$i++) {
		$list->[$i]=$list->[$i].$suff;
	}
}

=item B<add_hash_style($$)>

This adds an element to the list assuming that the list is a hash in
disguise. i.e. it does not add the element if the element is already in
the list.

=cut

sub add_hash_style($$) {
	my($list,$elem)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	if(!has_elem($list,$elem)) {
		push(@$list,$elem);
	}
}

=item B<has_elem($$)>

This routine returns a boolean value based on whether the list it got has
a certain element.

=cut

sub has_elem($$) {
	my($list,$elem)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	my($resu)=0;
	for(my($i)=0;$i<=$#$list;$i++) {
		if($list->[$i] eq $elem) {
			$resu=1;
		}
	}
	return($resu);
}

=item B<add_star($$)>

This adds an element to the beginging of a list.

=cut

sub add_star($$) {
	my($list,$elem)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	for(my($i)=$#$list+1;$i>=0;$i--) {
		$list->[$i]=$list->[$i-1];
	}
	$list->[0]=$elem;
}

=item B<add_endx($$)>

This adds an element to the end of a list.

=cut

sub add_endx($$) {
	my($list,$elem)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($elem,"ANY");
	push(@$list,$elem);
}

=item B<filter_prefix($$)>

This gets a list reference as input and produces a list of all the entires
which have a certain prefix in them.
Should we also have the same routine that actually does the manipulation on
the list itself ? it would be faster...

=cut

sub filter_prefix($$) {
	my($list,$reld)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($reld,"ANY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		if(substr($curr,0,length($reld)) eq $reld) {
			push(@inte,$curr);
		}
	}
	return(\@inte);
}

=item B<filter_suffix($$)>

This gets a list reference as input and produces a list of all the entires
which have a certain suffix in them.
Should we also have the same routine that actually does the manipulation on
the list itself ? it would be faster...

=cut

sub filter_suffix($$) {
	my($list,$reld)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($reld,"ANY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		if(substr($curr,length($curr)-length($reld),length($reld)) eq $reld) {
			push(@inte,$curr);
		}
	}
	return(\@inte);
}

=item B<filter_exists($)>

This gets a list reference of file names and generates a list of all the
entries in the original list which were actuall files that exist
Should we also have the same routine that actually does the manipulation on
the list itself ? it would be faster...

=cut

sub filter_exists($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		if(-e $curr) {
			push(@inte,$curr);
		}
	}
	return(\@inte);
}

=item B<filter_notexists($)>

This does the exact opposite of the previous routine.
Should we also have the same routine that actually does the manipulation on
the list itself ? it would be faster...

=cut

sub filter_notexists($) {
	my($list)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		if(!(-e $curr)) {
			push(@inte,$curr);
		}
	}
	return(\@inte);
}

=item B<filter_which($$$)>

=cut

sub filter_which($$$) {
	my($list,$chnp,$basp)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($chnp,"ANY");
	Meta::Utils::Arg::check_arg($basp,"ANY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		my($chnt)=$chnp."/".$curr;
		if(-e $chnt) {
			push(@inte,$chnt);
		} else {
			my($bast)=$basp."/".$curr;
			if(-e $bast) {
				push(@inte,$bast);
			} else {
				Meta::Utils::System::die("cannot find file in change or baseline [".$curr."]");
			}
		}
	}
	return(\@inte);
}

=item B<filter_file_regexp($$)>

This routine gets a list reference and a regular expression.
The routine will return a list reference to a list contraining all the
items in the original list that when taken as file names contain a match
for the regular expression. The routine utilises the check_sing_regexp
routine to actuall check the regular expression match.

=cut

sub filter_file_regexp($$) {
	my($list,$rege)=@_;
	Meta::Utils::Arg::check_arg($list,"ARRAY");
	Meta::Utils::Arg::check_arg($rege,"ANY");
	my(@inte);
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr)=$list->[$i];
		if(check_sing_regexp($curr,$rege)) {
			push(@inte,$curr);
		}
	}
	return(\@inte);
}

=item B<read($)>

This reads a list from a file by storing each line in a list entry.

=cut

sub read($) {
	my($file)=@_;
	Meta::Utils::Arg::check_arg($file,"ANY");
	my(@list);
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		push(@list,$line);
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return(\@list);
}

=item B<equa($$)>

This method will get two lists by reference and will return true off the two
lists are the same.

=cut

sub equa($$) {
	my($lst1,$lst2)=@_;
	if(0) {
		Meta::Utils::Output::print("list 1 is\n");
		&print(Meta::Utils::Output::get_file(),$lst1);
		Meta::Utils::Output::print("list 2 is\n");
		&print(Meta::Utils::Output::get_file(),$lst2);
	}
	my($siz1)=$#$lst1+1;
	my($siz2)=$#$lst2+1;
	if($siz1!=$siz2) {
		return(0);
	}
	my($size)=$siz1;# arbitrary
	for(my($i)=0;$i<=$size;$i++) {
		if($lst1->[$i] ne $lst2->[$i]) {
			return(0);
		}
	}
	return(1);
}

=item B<is_prefix($$)>

This method will get two lists by references and will return true iff the first is a prefix of the second.

=cut

sub is_prefix($$) {
	my($lst1,$lst2)=@_;
	my($siz1)=$#$lst1;
	my($siz2)=$#$lst2;
#	Meta::Utils::Output::print("siz1 is [".$siz1."]\n");
#	Meta::Utils::Output::print("siz2 is [".$siz2."]\n");
	if($siz1>$siz2) {
		return(0);
	}
	for(my($i)=0;$i<=$siz1;$i++) {
		if($lst1->[$i] ne $lst2->[$i]) {
#			Meta::Utils::Output::print("one is [".$lst1->[$i]."]\n");
#			Meta::Utils::Output::print("two is [".$lst2->[$i]."]\n");
			return(0);
		}
	}
	return(1);
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
7	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
8	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
9	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
10	Wed Jan 10 18:31:05 2001	MV	more perl code quality
11	Thu Jan 11 19:25:00 2001	MV	more quality testing
12	Thu Jan 11 22:31:19 2001	MV	more perl code quality
13	Fri Jan 12 09:25:33 2001	MV	more perl quality
14	Thu Jan 18 15:59:13 2001	MV	correct die usage
15	Sat Jan 27 19:56:28 2001	MV	perl quality change
16	Sun Jan 28 02:34:56 2001	MV	perl code quality
17	Sun Jan 28 13:51:26 2001	MV	more perl quality
18	Tue Jan 30 03:03:17 2001	MV	more perl quality
19	Sat Feb  3 23:41:08 2001	MV	perl documentation
20	Mon Feb  5 03:21:02 2001	MV	more perl quality
21	Tue Feb  6 01:04:52 2001	MV	perl qulity code
22	Tue Feb  6 07:02:13 2001	MV	more perl code quality
23	Tue Feb  6 08:47:46 2001	MV	more perl quality
24	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-do prefix and postfix routines. the add_prefix and add_postfix routines are not good enough since they work on the list at hand. This is the most efficient way, but sometimes I dont want no one to change the current list...

=cut
