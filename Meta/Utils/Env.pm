#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Env;

use strict qw(vars refs subs);
use Meta::Utils::Hash qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.27";
@ISA=qw();

#sub get_nodie($);
#sub get($);
#sub has($);
#sub check_in($);
#sub check_out($);
#sub remove($);
#sub remove_nodie($);
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

sub get_nodie($) {
	my($keyx)=@_;
	if(exists($ENV{$keyx})) {
		return($ENV{$keyx});
	} else {
		return(undef);
	}
}

sub get($) {
	my($keyx)=@_;
	my($resu)=get_nodie($keyx);
	if(defined($resu)) {
		return($resu);
	} else {
		Meta::Utils::System::die("unable to find [".$keyx."] in environment");
	}
}

sub has($) {
	my($keyx)=@_;
	return(exists($ENV{$keyx}));
}

sub check_in($) {
	my($keyx)=@_;
	if(!has($keyx)) {
		Meta::Utils::System::die("cant find [".$keyx."] in the environment");
	}
}

sub check_out($) {
	my($keyx)=@_;
	if(has($keyx)) {
		Meta::Utils::System::die("cant find [".$keyx."] in the environment");
	}
}

sub remove($) {
	my($keyx)=@_;
	check_in($keyx);
	&remove_nodie($keyx);
}

sub remove_nodie($) {
	my($keyx)=@_;
	delete $ENV{$keyx};
}

sub set($$) {
	my($keyx,$valx)=@_;
	$ENV{$keyx}=$valx;
}

sub set_in($$) {
	my($keyx,$valx)=@_;
	check_in($keyx);
	set($keyx,$valx);
}

sub set_out($$) {
	my($keyx,$valx)=@_;
	check_out($keyx);
	set($keyx,$valx);
}

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

sub save($) {
	my($file)=@_;
	Meta::Utils::Hash::save(\%ENV,$file);
}

sub load($) {
	my($file)=@_;
	Meta::Utils::Hash::load(\%ENV,$file);
}

sub bash($) {
	my($file)=@_;
	my(%hash);
	Meta::Utils::Hash::load(\%hash,$file);
	while(my($keyx,$valx)=each(%hash)) {
		Meta::Utils::Output::print("export \$".$keyx."=\"".$valx."\"\n");
	}
}

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

__END__

=head1 NAME

Meta::Utils::Env - utilities to let you access the environment variables.

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

	MANIFEST: Env.pm
	PROJECT: meta
	VERSION: 0.27

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Env qw();
	my($home)=Meta::Utils::Env::get("HOME");

=head1 DESCRIPTION

This is a library to let you get,set query,save and load environment
variables.
It has a few advanced services also - like giving you pieces of bash code
to run from your environment and autoset environment variables etc...
You may rightly ask - "why should you have such a library ? Perl already
has a global hash variable called ENV which IS the environment". True, true,
but the access to it is not object oriented and is arcane to people who are
used to working in a clean object orient environment. Why should they learn
about the ENV variable ? the $? variable ? are you kidding ? these are old
style stuff. For every subject there need be a namespace which descirbes
the subject accordingly and all the routines that have to do with that
subject will be under that name-space. This approach is much more extendible,
uniform, modern and lends itself to building larger software systems since
you do not mess up your namespace by default but rather use a library on a
need to basis.

=head1 FUNCTIONS

	get_nodie($)
	get($)
	has($)
	check_in($)
	check_out($)
	remove($)
	remove_nodie($)
	set($$)
	set_in($$)
	set_out($$)
	add($$$)
	pmini($$)
	save($)
	load($)
	bash($)
	bash_cat($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_nodie($)>

This gives you an element of the environment.
If the element does not exist this routine does not die but rather returns
the "undef" value.
The implementation just gets the value from the "ENV" hash table (perl builtin).

=item B<get($)>

This gives you an element of the environment and dies if it cannot find
it in the environment. This uses the get_nodie routine.

=item B<has($)>

This routine returns a boolean variable according to whether a variable
is in the environment or not.
The implementation just consults the ENV hash table.

=item B<check_in($)>

This routine receives an environment variables name and dies if it isnt
in the environment.

=item B<check_out($)>

This dies if the environment variable is already in the environment.

=item B<remove($)>

This will remove an environment variable (this is different from setting
it to "").

=item B<remove_nodie($)>

This will remove an environment variable and will not die if the variable
is not there.

=item B<set($$)>

This sets an element in the environment.
The implementation just adds the variable and its value to the ENV hash.

=item B<set_in($$)>

This does a set but dies if the envrionment values in question did not
already exist in the environment.

=item B<set_out($$)>

This does a set but dies if the environment key in question was already in
the environment.

=item B<add($$$)>

This will add to a current env var as if it was a path.
It receives a separator, a variable name and a value to add.

=item B<pmini($$)>

This returns a minimal path.

=item B<save($)>

This routine saves all environment variables into a file. The idea is to
be able to save and load the entire environment so as to keep an exact
copy of the working conditions for a certain process or to clear the
environment to supply a sterile environment to run some process and then
restore it back. You may find other uses.

=item B<load($)>

This routine loads the entire environment from a disk. See the save routine
for more details.

=item B<bash($)>

This routine gives you a bash script to set variables accroding to a hash
table saved on disk.

=item B<bash_cat($)>

This takes a hash by refrence.
This assumes the keys in the hash are names of environment paths.
This assumes the values of the keys are values to be added at the head of
the paths.
This produces a bash script to do it.

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
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV more perl code quality
	0.08 MV correct die usage
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV more perl quality
	0.12 MV perl documentation
	0.13 MV more perl quality
	0.14 MV perl qulity code
	0.15 MV more perl code quality
	0.16 MV more perl quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV history change
	0.20 MV perl packaging
	0.21 MV some chess work
	0.22 MV md5 project
	0.23 MV database
	0.24 MV perl module versions in files
	0.25 MV movies and small fixes
	0.26 MV thumbnail user interface
	0.27 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add some more bash routines, improve them names, and maybe get them the hell out of here.

-get the pmini routine out of here and use the path module instead.
