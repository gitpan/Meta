#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Env - utilities to let you access the environment variables.

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

MANIFEST: Env.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Env qw();>
C<my($home)=Meta::Utils::Env::get("HOME");>

=head1 DESCRIPTION

This is a library to let you get,set query,save and load environment
variables.
It has a few advanced services also - like giving you pieces of bash code
to run from your environment and autoset environment variables etc...

=head1 EXPORTS

C<get_nodie($)>
C<get($)>
C<has($)>
C<check_in($)>
C<check_out($)>
C<remove($)>
C<set($$)>
C<set_in($$)>
C<set_out($$)>
C<add($$$)>
C<pmini($$)>
C<save($)>
C<load($)>
C<bash($)>
C<bash_cat($)>

=cut

package Meta::Utils::Env;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Hash qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub get_nodie($);
#sub get($);
#sub has($);
#sub check_in($);
#sub check_out($);
#sub remove($);
#sub set($$);
#sub set_in($$);
#sub set_out($$);
#sub add($$$);
#sub pmini($$);

#sub save($);
#sub load($);
#sub bash($);
#sub bash_cat($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<get_nodie($)>

This gives you an element of the environment.
If the element does not exist this routine does not die but rather returns
the "undef" value.
The implementation just gets the value from the "ENV" hash table (perl builtin).

=cut

sub get_nodie($) {
	my($keyx)=@_;
	if(exists($ENV{$keyx})) {
		return($ENV{$keyx});
	} else {
		return(undef);
	}
}

=item B<get($)>

This gives you an element of the environment and dies if it cannot find
it in the environment. This uses the get_nodie routine.

=cut

sub get($) {
	my($keyx)=@_;
	my($resu)=get_nodie($keyx);
	if(defined($resu)) {
		return($resu);
	} else {
		Meta::Utils::System::die("unable to find [".$keyx."] in environment");
	}
}

=item B<has($)>

This routine returns a boolean variable according to whether a variable
is in the environment or not.
The implementation just consults the ENV hash table.

=cut

sub has($) {
	my($keyx)=@_;
	return(exists($ENV{$keyx}));
}

=item B<check_in($)>

This routine receives an environment variables name and dies if it isnt
in the environment.

=cut

sub check_in($) {
	my($keyx)=@_;
	if(!has($keyx)) {
		Meta::Utils::System::die("cant find [".$keyx."] in environment");
	}
}

=item B<check_out($)>

This dies if the environment variable is already in the environment.

=cut

sub check_out($) {
	my($keyx)=@_;
	if(has($keyx)) {
		Meta::Utils::System::die("cant find [".$keyx."] in environment");
	}
}

=item B<remove($)>

This will remove an environment variable (this is different from setting
it to "").

=cut

sub remove($) {
	my($keyx)=@_;
	delete $ENV{$keyx};
}

=item B<set($$)>

This sets an element in the environment.
The implementation just adds the variable and its value to the ENV hash.

=cut

sub set($$) {
	my($keyx,$valx)=@_;
	$ENV{$keyx}=$valx;
}

=item B<set_in($$)>

This does a set but dies if the envrionment values in question did not
already exist in the environment.

=cut

sub set_in($$) {
	my($keyx,$valx)=@_;
	check_in($keyx);
	set($keyx,$valx);
}

=item B<set_out($$)>

This does a set but dies if the environment key in question was already in
the environment.

=cut

sub set_out($$) {
	my($keyx,$valx)=@_;
	check_out($keyx);
	set($keyx,$valx);
}

=item B<add($$$)>

This will add to a current env var as if it was a path.
It receives a separator, a variable name and a value to add.

=cut

sub add($$$) {
	my($varx,$sepa,$valx)=@_;
	my($curr)=get_nodie($varx);
	my($nval);
	if(defined($curr)) {
		if($curr eq "") {
			$nval=$valx;
		} else {
			$nval=join($sepa,$valx,$curr);
		}
	} else {
		$nval=$valx;
	}
	my($mini)=pmini($nval,$sepa);
	&set($varx,$mini);
}

=item B<pmini($$)>

This returns a minimal path.

=cut

sub pmini($$) {
	my($valx,$sepa)=@_;
	my(@arra)=split($sepa,$valx);
	my(%hash);
	my(@narr);
	for(my($i)=0;$i<=$#arra;$i++) {
		my($curr)=$arra[$i];
		if(!exists($hash{$curr})) {
			push(@narr,$curr);
			$hash{$curr}=defined;
		}
	}
	my($resu)=join($sepa,@narr);
	return($resu);
}

=item B<save($)>

This routine saves all environment variables into a file. The idea is to
be able to save and load the entire environment like we want to when we start
working on the baseline and end working on the baseline or any other use
you might find.

=cut

sub save($) {
	my($file)=@_;
	Meta::Utils::Hash::save(\%ENV,$file);
}

=item B<load($)>

This routine loads the entire environment from a disk. See the save routine
for more details.

=cut

sub load($) {
	my($file)=@_;
	Meta::Utils::Hash::load(\%ENV,$file);
}

=item B<bash($)>

This routine gives you a bash script to set variables accroding to a hash
table saved on disk.

=cut

sub bash($) {
	my($file)=@_;
	my(%hash);
	Meta::Utils::Hash::load(\%hash,$file);
	while(my($keyx,$valx)=each(%hash)) {
		Meta::Utils::Output::print("export \$".$keyx."=\"".$valx."\"\n");
	}
}

=item B<bash_cat($)>

This takes a hash by refrence.
This assumes the keys in the hash are names of environment paths.
This assumes the values of the keys are values to be added at the head of
the paths.
This produces a bash script to do it.

=cut

sub bash_cat($) {
	my($hash)=@_;
	while(my($keyx,$valx)=each(%$hash)) {
		Meta::Utils::Output::print("if [ -z \"\$".$keyx."\" ]\n");
		Meta::Utils::Output::print("then\n");
		Meta::Utils::Output::print("\texport ".$keyx."=\"".$valx."\"\n");
		Meta::Utils::Output::print("else\n");
		Meta::Utils::Output::print("\texport ".$keyx."=\"".$valx.":\$".$keyx."\"\n");
		Meta::Utils::Output::print("fi\n");
	}
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
2	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
3	Sat Jan  6 17:14:09 2001	MV	more perl checks
4	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
5	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
6	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
7	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
7	Wed Jan 10 18:31:05 2001	MV	more perl code quality
8	Thu Jan 18 15:59:13 2001	MV	correct die usage
9	Sun Jan 28 02:34:56 2001	MV	perl code quality
10	Sun Jan 28 13:51:26 2001	MV	more perl quality
11	Tue Jan 30 03:03:17 2001	MV	more perl quality
12	Sat Feb  3 23:41:08 2001	MV	perl documentation
13	Mon Feb  5 03:21:02 2001	MV	more perl quality
14	Tue Feb  6 01:04:52 2001	MV	perl qulity code
15	Tue Feb  6 07:02:13 2001	MV	more perl code quality
16	Tue Feb  6 08:47:46 2001	MV	more perl quality
17	Tue Feb  6 22:19:51 2001	MV	revision change
18	Sun Feb 11 04:08:15 2001	MV	languages.pl test online
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add some more bash routines, improve them names, and maybe get them the hell out of here.

=cut
