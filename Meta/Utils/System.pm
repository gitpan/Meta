#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::System - A module to help with running other programs.

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

MANIFEST: System.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::System qw();>
C<Meta::Utils::System::system_shell("echo Hello, World!");>

=head1 DESCRIPTION

SPECIAL STDERR FILE

This library basically provides the routines to do the following:
0. execute binaries.
1. execute shell commands (with shell interpretation).
2. execute other perl scripts (in the same interpreter as you are...).
3. smart routines to find the most efficient way to execute something.
All routines have a die/nodie version which (respectivly) die or don't
die on errors from the execution process...

=head1 EXPORTS

C<system_nodie($$)>
C<system($$)>
C<system_shell_nodie($)>
C<system_shell($)>
C<smart_shell($)>
C<system_out_nodie($$$)>
C<system_err_nodie($$$)>
C<system_err_silent_nodie($$)>
C<system_out($$)>
C<system_out_val($$)>
C<system_out_list($$)>
C<system_out_hash($$)>
C<perl_nodie($$)>
C<smart_nodie($$)>
C<osex($)>
C<sexo($)>
C<die($)>

=cut

package Meta::Utils::System;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Carp qw();
use Meta::Utils::File::File qw();
use Meta::Utils::Utils qw();
use Meta::Utils::Debug qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub system_nodie($$);
#sub system($$);
#sub system_shell_nodie($);
#sub system_shell($);
#sub smart_shell($);
#sub system_out_nodie($$$);
#sub system_err_nodie($$$);
#sub system_err_silent_nodie($$);
#sub system_out($$);
#sub system_out_val($$);
#sub system_out_list($$);
#sub system_out_hash($$);
#sub perl_nodie($$);
#sub smart_nodie($$);
#sub osex($);
#sub sexo($);
#sub die($);

my($eval);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<system_nodie($$)>

This routine is the same as the system routine and it does not die.
It returns the actual code that that process returned (look at the
"CORE::system" routines manual for details...).

=cut

sub system_nodie($$) {
	my($prog,$args)=@_;
	Meta::Utils::Arg::check_arg($prog,"SCALAR");
	Meta::Utils::Arg::check_arg($args,"ARRAYref");
#	Meta::Utils::Output::print("prog is [".$prog."]\n");
#	Meta::Utils::Output::print("args is [".CORE::join(",",@$args)."]\n");
	if(Meta::Utils::Debug::debug()) {
		Meta::Utils::Debug::msg(CORE::join(",",$prog,@$args));
	}
	my($code)=CORE::system($prog,@$args);
	$code>>=8;
	my($resu)=Meta::Utils::Utils::bnot($code);
	return($resu);
}

=item B<system($$)>

This routine does the regular system() perl call.
The idea is to expand it to include the fact that if a perl script
is run then it will not be run via a regular call but rather inside
the perl interpreter...
In any case the system which is called does not pass through a shell
since we use it with two arguments (read the documentation of CORE::system).
We also dies if the system is not successfull.

=cut

sub system($$) {
	my($comm,$list)=@_;
	my($resu)=&system_nodie($comm,$list);
	if(!$resu) {
		Meta::Utils::System::die("execution of [".$comm."] failed");
	}
	return($resu);
}

=item B<system_shell_nodie($)>

This executes a system shell but doesnt die.
It returns the exit status of the process.

=cut

sub system_shell_nodie($) {
	my($prog)=@_;
	my($code)=CORE::system($prog);
	my($resu)=Meta::Utils::Utils::bnot($code);
	return($resu);
}

=item B<system_shell($)>

This routine executes a system command given in one string.
This will use the regular system of perl and therefore will use
a shell and will be slower than the sys command (better use that...).
It will also (like sys) die if there is an error.

=cut

sub system_shell($) {
	my($prog)=@_;
	my($scod)=system_shell_nodie($prog);
	if(!$scod) {
		&die("execution of [".$prog."] failed");
	}
}

=item B<smart_shell($)>

This routine get a full shell script, splits it according to ";", and gives
each piece to smart_part_shell.

=cut

sub smart_shell($) {
	my($comm)=@_;
	return(&system_shell_nodie($comm));
}

=item B<system_out_nodie($$$)>

This routine does exactly the same as B<system_out> but does not die.
This routine return the error status according to whether the command was
successful or not.
This routine gets a string by reference to store the results in.

=cut

sub system_out_nodie($$$) {
	my($text,$prog,$args)=@_;
	my($full)=$prog." ".CORE::join(" ",@$args)." |";
	open(FILE,$full) || return(0);
	my($line);
	$$text="";
	while($line=<FILE> || 0) {
		$$text.=$line;
	}
	close(FILE) || return(0);
	return(1);
}

=item B<system_err_nodie($$$)>

This method is the same as system_out_nodie except it catched the standard
error and not the standard output.

=cut

sub system_err_nodie($$$) {
	my($text,$prog,$args)=@_;
	Meta::Utils::Arg::check_arg($prog,"SCALAR");
	Meta::Utils::Arg::check_arg($args,"ARRAYref");
#	Meta::Utils::Output::print("prog is [".$prog."]\n");
#	Meta::Utils::Output::print("args is [".CORE::join(",",@$args)."]\n");
	my($full)=$prog." ".CORE::join(" ",@$args)." 2>&1 |";
	open(FILE,$full) || return(0);
	my($line);
	$$text="";
	while($line=<FILE> || 0) {
		$$text.=$line;
	}
	close(FILE) || return(0);
	return(1);
}

=item B<system_err_silent_nodie($$)>

This method is the same as system_err_nodie except it will print out the
output if it fails.

=cut

sub system_err_silent_nodie($$) {
	my($prog,$args)=@_;
	my($text);
	my($resu)=system_err_nodie(\$text,$prog,$args);
	if(!$resu) {
		Meta::Utils::Output::print($text);
	}
	return($resu);
}

=item B<system_out($$)>

This routine runs a script with arguments and returns a reference to all
the output that the program generated (stdout).
The program should accept one argument which is the program to be run and
an array of arguments for that program.

=cut

sub system_out($$) {
	my($prog,$args)=@_;
#	Meta::Utils::Output::print("prog is [".$prog."]\n");
#	Meta::Utils::Output::print("args is [".$args."]\n");
	Meta::Utils::Arg::check_arg($prog,"SCALAR");
	Meta::Utils::Arg::check_arg($args,"ARRAYref");
	my($full)=$prog." ".CORE::join(" ",@$args)." |";
	open(FILE,$full) || &die("unable to run/open file to [".$prog."]");
	my($line);
	my($retu);
	while($line=<FILE> || 0) {
		$retu.=$line;
	}
	close(FILE) || &die("unable to close [".$prog."]");
	return(\$retu);
}

=item B<system_out_val($$)>

This routine returns the output of running a system command with the outputs
actual value and not just a reference (for use in small outputed executables).

=cut

sub system_out_val($$) {
	my($prog,$args)=@_;
	my($resu)=&system_out($prog,$args);
	return($$resu);
}

=item B<system_out_list($$)>

This gives you the output of a command as a list of the lines of the output.

=cut

sub system_out_list($$) {
	my($prog,$args)=@_;
	my($full)=$prog." ".CORE::join(" ",@$args)." |";
	open(FILE,$full) || &die("unable to run/open file to [".$prog."]");
	my(@retu);
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		push(@retu,$line);
	}
	close(FILE) || &die("unable to close [".$prog."]");
	return(\@retu);
}

=item B<system_out_hash($$)>

This gives you the output of a command as a hash of the lines of the output.

=cut

sub system_out_hash($$) {
	my($prog,$args)=@_;
	my($full)=$prog." ".CORE::join(" ",@$args)." |";
	open(FILE,$full) || &die("unable to run/open file to [".$prog."]");
	my(%retu);
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		$retu{$line}=defined;
	}
	close(FILE) || &die("unable to close [".$prog."]");
	return(\%retu);
}

=item B<perl_nodie($$)>

This routine receives a name of a perl script to execute, and a list
of arguments for it and executes it with the current perl interpreter
and returning the return value of the script and not dying if something
went wrong.
This script could be done in two basic ways:
0. way number 1 - the correct way - using the Safe module which allows
	you to control the compartment in which you're evaluating
	the code and make sure that it doesnt contaminate your name space...
	(contamination could even mean chaning your variables...).
	I didn't get that code to work and it is currently marked out...
	Read the perl manual for "Safe" if you want to know more...
1. way number 2 - the wrong way - this is currently implemented.
	Just eval the code. This is unsafe as name space contamination
	is concerned but hey - "Im just a singer in a Rock & Roll band...".
In both methods care in the routine is taken for the following:
0. setting ARGV to list the arguments so the code will think it is
	actually being executed.
1. saving stderr and stdout for any case the code does any redirection
	(and it does since it uses our own "exit" method which redirects
	stderr so "die" wont print it's funny messages on the screen...).
2. getting the correct return code. this is very ugly indeed since we take
	it for granted that the process were using uses our own "exit" routine
	to exit and that routine puts the code in the $@ variable.

=cut

sub perl_nodie($$) {
	my($prog,$args)=@_;

#	my($cmpt)=new Safe();
#	$cmpt->deny_only();
#	my($resu)=$cmpt->rdo($prog);
#	or
#	use Meta::Utils::File::File qw();
#	my($file)=Meta::Utils::File::File::load($prog);
#	my($resu)=$cmpt->reval($file);

#	my(@save)=@ARGV;
#	@ARGV=@args;
#	require $prog;
#	@ARGV=@save;

	$eval=1;
	my($file)=Meta::Utils::File::File::load($prog);

	my(@save)=@ARGV;
	@ARGV=@$args;
	open(OLDOUT,">&STDOUT") || &die("unable to dup stdout");
	open(OLDERR,">&STDERR") || &die("unable to dup stderr");
	my($resu)=eval($file);# we dont need the return from eval
	my($code)=int($@);
	my($result)=Meta::Utils::Utils::bnot($code);
	open(STDOUT,">&OLDOUT") || &die("unable to dup stdout");
	open(STDERR,">&OLDERR") || &die("unable to dup stderr");
	close(OLDOUT) || &die("unable to close oldout");
	close(OLDERR) || &die("unable to close olderr");
	@ARGV=@save;
	$eval=0;

	return($result);
}

=item B<smart_nodie($$)>

This routine is a smart execution routine. You should use this routine
to execute anything you want when you dont know what it is you want
to execute. The idea is for the routine to detect that you want to execute
perl code and not to execute perl again but rather use the "perl_" routines
in this module to run it. If what you want to run is another type
of executable then the regular "system_" routines are called.
The routine detects perl code to be run in two ways:
0. the suffix of the file to run is ".pl".
1. the program that you want to run is a perl interpreter.

=cut

sub smart_nodie($$) {
	my($prog,$args)=@_;
	if(File::Basename::basename($prog) eq "perl") {
		&die("oh oh");
		return(undef);
#		return(perl_nodie($args[0],$args[1..$#@$args]));
	} else {
		if(Meta::Utils::Utils::is_suffix($prog,".pl")) {
			return(perl_nodie($prog,$args));
		} else {
			return(system_nodie($prog,$args));
		}
	}
}

=item B<osex($)>

This routine is you way to exit the program with an error code!
The ideas here are:
0. use die and not exit so your entire code could be evaluated within
	yet another perl program and not cause the entire thing
	to exit (using "exit" is nasty - check the perl manual...).
1. block stderr from writing before the die cause we dont want eny
	message on the screen. (the parent will take care of it's own
	stderr handle and even "dup" it if need be before calling
	us to do our thing).
2. I know it's funny that there is no "die" routine that doesnt print
	anything to the screen and I've sent a mail about that to
	the perl guys (Gurushy Sarathni - the guy in charge of perl
	release 5.6...). No real answer as of yet...

=cut

sub osex($) {
	my($code)=@_;
	if($eval==1) {
		open(STDERR,"/dev/null") || &die("cannot redirect stderr to /dev/null");
		&die($code."\n");
	} else {
		CORE::exit($code);
	}
}

=item B<sexo($)>

This function is much like the osex function except it receives normal exit
values (where non zero means good). It just calls osex after reversing the
value.

=cut

sub sexo($) {
	my($scod)=@_;
	my($code)=Meta::Utils::Utils::bnot($scod);
	osex($code);
}

=item B<die($)>

This routine gets a string and dies while printing the string.

=cut

sub die($) {
	my($stri)=@_;
	Carp::confess($stri);
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
5	Sun Jan  7 20:46:54 2001	MV	more harsh checks on perl code
6	Tue Jan  9 17:00:22 2001	MV	fix up perl checks
7	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
8	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
9	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
10	Wed Jan 10 18:31:05 2001	MV	more perl code quality
11	Thu Jan 11 19:25:00 2001	MV	more quality testing
12	Thu Jan 18 18:05:39 2001	MV	lilypond stuff
12	Fri Jan 19 20:11:10 2001	MV	fix up the rule system
13	Thu Jan 25 20:55:06 2001	MV	finish Simul documentation
14	Sat Jan 27 19:56:28 2001	MV	perl quality change
15	Sun Jan 28 02:34:56 2001	MV	perl code quality
16	Sun Jan 28 13:51:26 2001	MV	more perl quality
17	Tue Jan 30 03:03:17 2001	MV	more perl quality
18	Sat Feb  3 23:41:08 2001	MV	perl documentation
19	Mon Feb  5 03:21:02 2001	MV	more perl quality
20	Tue Feb  6 01:04:52 2001	MV	perl qulity code
21	Tue Feb  6 07:02:13 2001	MV	more perl code quality
22	Tue Feb  6 22:19:51 2001	MV	revision change
23	Sun Feb 11 04:08:15 2001	MV	languages.pl test online
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-do not actually do a system call in both system and system_shell (one should call the other...).

-make the routine that die use the routines that dont die.

-drop the "system_" add to everything. do the following names: system -> dire_diex system_nodie -> dire_ndie system_shell -> shel_diex system_shell_nodie -> shel_ndie system_out -> dire_outx and add the "shel_outx" routine. maybe think about passing the die argument ?

-why doesnt the use of Safe work ? It keeps giving me these strange errors!!! make the Safe work - this is a must because otherwise the code could do bad things to us...

-the perl_nodie routine doesnt know how to scan the path for the executable that it's expected to perform. therefore it has to get absolute file names. (as a result the smart routine also has to get absolute filenames cause its using perl_nodie...). make it scan...

-add a third way of detecting that perl code is wanted to run in the "smart_" routines using the first line of the target script...

-improve the exit routine... It should be nicer...

-rearrange the routines in proper order...

-work with the "Safe" module in the perl runnign section.

-get ridd of the ugly patch where "exit" sends the code in the "$@" variable so "perl_nodie" could catch it there...

-smart_shell should be optimized greatly.

-straighten out the mess with system_out,system_out_val,system_out_nodie (have them do some code sharing for god sake...).

-do a function which runs a system command that gets its stdin from a text you send it... (this could be useful in a lot of cases...).

-do a shell function that runs a command internally (not via shell) and has a predefined output file for stdout or stderr.

=cut
