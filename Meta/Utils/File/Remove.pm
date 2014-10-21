#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Remove;

use strict qw(vars refs subs);
use File::Find qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.26";
@ISA=qw();

#sub rm_nodie($);
#sub rm($);
#sub rm_demo_verb($$$);
#sub rm_rmdir($);
#sub rmdir($);
#sub rmdir_demo_verb($$$$);
#sub rmall();
#sub rmrecursive($);
#sub rmhash_demo_verb($$$);
#sub rmlist_demo_verb($$$);
#sub rmmult_demo_verb($$);

#__DATA__

sub rm_nodie($) {
	my($file)=@_;
	return(CORE::unlink($file));
}

sub rm($) {
	my($file)=@_;
	my($resu)=rm_nodie($file);
	if($resu!=1) {
		Meta::Utils::System::die("unable to remove [".$file."]");
	}
}

sub rm_demo_verb($$$) {
	my($file,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("removing file [".$file."]\n");
	}
	if($demo) {
		return(1);
	} else {
		return(&rm($file));
	}
}

sub rm_rmdir($) {
	my($file)=@_;
	rm($file);
	my($dire)=dirname($file);
	if(dir_empty($dire)) {
		&rmdir($dire);
	}
}

sub rmdir($) {
	my($dire)=@_;
	my($resu)=CORE::rmdir($dire);
	if(!$resu) {
		Meta::Utils::System::die("unable to remove directory [".$dire."]");
	}
}

sub rmdir_demo_verb($$$$) {
	my($dire,$prin,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("removing dir [".$prin."]\n");
	}
	if($demo) {
		return(1);
	} else {
		return(&rmdir($dire));
	}
}

sub rmall() {
	my($unkn)=$File::Find::name;
	if(-d $unkn) {
		&rmdir($unkn);
	} else {
		&rm($unkn);
	}
}

sub rmrecursive($) {
	my($dir)=@_;
	File::Find::finddepth(\&rmall,$dir);
}

sub rmhash_demo_verb($$$) {
	my($hash,$demo,$verb)=@_;
	my($resu)=1;
	while(my($keyx,$valx)=each(%$hash)) {
		my($tmpr)=rm_demo_verb($keyx,$demo,$verb);
		$resu=$resu && $tmpr;
	}
	return($resu);
}

sub rmlist_demo_verb($$$) {
	my($list,$demo,$verb)=@_;
	for(my($i)=0;$i<=$#$list;$i++) {
		rm_demo_verb($list->[$i],$demo,$verb);
	}
}

sub rmmult_demo_verb($$) {
	my($demo,$verb)=@_;
	my($line);
	my($resu)=1;
	while($line=<> || 0) {
		chop($line);
		$resu=$resu && Meta::Utils::File::Remove::rm_demo_verb($line,$demo,$verb);
	}
	return($resu);
}

1;

__END__

=head1 NAME

Meta::Utils::File::Remove - package that eases removal of files and directories.

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

	MANIFEST: Remove.pm
	PROJECT: meta
	VERSION: 0.26

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Remove qw();
	Meta::Utils::File::Remove::rm($filename);
	Meta::Utils::File::Remove::rmdir($dirname);

=head1 DESCRIPTION

This module eases the use of rm. Instead of checking for errors all of the
time just let this module remove a file or directory for you (it has all
the options including a recursive one...). If something happens wrong
it dies on you but hey - thats the price you got to pay...

=head1 FUNCTIONS

	rm_nodie($)
	rm($)
	rm_demo_verb($$$)
	rm_rmdir($)
	rmdir($)
	rmdir_demo_verb($$$$)
	rmall()
	rmrecusrive($)
	rmhash_demo_verb($$$)
	rmlist_demo_verb($$$)
	rmmult_demo_verb($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<rm_nodie($)>

This function removes a single file and does not do anything if it does not
exist. This function returns whether it managed to do it or not...

=item B<rm($)>

This function removes a single file and dies if it cannot do so.
It does not return a value.

=item B<rm_demo_verb($$$)>

This function removes a file only if the demo is false and also emits a
message if the verbose flag is true

=item B<rm_rmdir($)>

This function removes a file and then removes the directory in which it is
located if it remains empty.
Actually this function should continues going higher....:) up the directory
tree.

=item B<rmdir($)>

This function removes a directory and dies if it cannot do so.
This function does not return a value.

=item B<rmdir_demo_verb($$$$)>

This function removes a directory only if the demo flag is false.
The function also emits a message about the directories being removed
if the verbose flag is true.

=item B<rmall()>

This function assumes that you dont know if what you're looking to remove
is a file or a directory and removes whichever this is...
It dies if it cannot perform.

=item B<rmrecusive($)>

This function removes a directory in a recursive fashion.
It uses the File::Find function to achieve this (unlinking dirs is not
good...:)
It also uses the rmall function to achieve this (nice trick...).

=item B<rmhash_demo_verb($$$)>

This routine removes a whole hash. As expected, demo and verbose arguments
are also allowed.

=item B<rmlist_demo_verb($$$)>

This routine removes a whole list. As expected, demo and verbose arguments
are also allowed.

=item B<rmmult_demo_verb($$)>

This function receives the regular demo and verbose variables and treats the
standard input as a source for lines, each representing a file to be removed.
The function removes all the files refered as such.
The function returns whether all the removals were successful or not.

=back

=head1 BUGS

None

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
	0.07 MV make lilypond work
	0.08 MV correct die usage
	0.09 MV lilypond stuff
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV perl packaging
	0.20 MV fix database problems
	0.21 MV md5 project
	0.22 MV database
	0.23 MV perl module versions in files
	0.24 MV movies and small fixes
	0.25 MV thumbnail user interface
	0.26 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-rm_rmdir should climb higher and keep removing dirs (its not doing that right now...).

-add a die parameter to the rm($) function and propagate it up.

-add an option to the rmmult_demo_verb function to remove files from any file source (not just stdin...).

-stop the demo verb propagation and start using a parameter module.
