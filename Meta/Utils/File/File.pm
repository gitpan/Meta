#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::File::File - library to do operations on files.

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

MANIFEST: File.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::File::File qw();>
C<my($file)="/etc/passwd";>
C<if(Meta::Utils::File::File::exist($file)) {>
C<	# try to break into the system>
C<} else {>
C<	# we are in windows, just remove the kernel.dll from c:\windows>
C<}>

=head1 DESCRIPTION

This is a library to help you do things with files with meaningful names.
For instance: check if a file exists, compare two files etc...

=head1 EXPORTS

C<check_mult_regexp($$$)>
C<check_sing_regexp($$$)>
C<save_nodie($$)>
C<save($$)>
C<load_nodie($$)>
C<load($)>
C<load_line($$)>
C<cmp($$)>
C<exist($)>
C<notexist($)>
C<check_exist($)>
C<check_notexist($)>
C<create_new($)>
C<subst($$$)>

=cut

package Meta::Utils::File::File;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub check_mult_regexp($$$);
#sub check_sing_regexp($$$);
#sub save_nodie($$);
#sub save($$);
#sub load_nodie($$);
#sub load($);
#sub load_line($$);
#sub cmp($$);
#sub exist($);
#sub notexist($);
#sub check_exist($);
#sub check_notexist($);
#sub create_new($);
#sub subst($$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<check_mult_regexp($$$)>

This routine does exactly the same as check_sing_regexp except it
gets a list of regular expressions and matches any of them.
This also receives a variable telling it whether to print the matched lines
or not.

=cut

sub check_mult_regexp($$$) {
	my($file,$rege,$prin)=@_;
#	check_arg($file,"");
#	check_arg($rege,"ARRAY");
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($line);
	my($result)=0;
	while($line=<FILE> || 0) {
		my($curr);
		for $curr (@$rege) {
			if($line=~/\b$curr\b/) {
				if($prin) {
					Meta::Utils::Output::print($file.":".$line);
				}
				$result=1;
			}
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return($result);
}

=item B<check_sing_regexp($$$)>

This routine checks whether a single regular expression given to it
is present in the file given to it.
This also receives a variable telling it whether to print the matched lines
or not.

=cut

sub check_sing_regexp($$$) {
	my($file,$rege,$prin)=@_;
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
#	Meta::Utils::Output::print("rege is [".$rege."]\n");
	my($line);
	my($result)=0;
	while($line=<FILE> || 0) {
#		if($line=~/$rege/o) {
#		Meta::Utils::Output::print("line is [".$line."]\n");
		if($line=~/$rege/) {
			if($prin) {
				Meta::Utils::Output::print($file.":".$line);
			}
#			Meta::Utils::Output::pinrt("in here\n");
			$result=1;
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return($result);
}

=item B<save_nodie($$)>

This does exactly the same as B<save> but does not die if something goes
wrong and instead returns a valid error bit.

=cut

sub save_nodie($$) {
	my($file,$text)=@_;
	open(FILE,"> $file") || return(0);
	print FILE $text;
	close(FILE) || return(0);
	return(1);
}

=item B<save($$)>

This routine receives a file name and text to write into it.
The routine assumes that it has permissions, and writes a new file (recreates
it) and writes the string into it, and then closes the file.
The routine dies if something goes wrong.

=cut

sub save($$) {
	my($file,$text)=@_;
	open(FILE,"> $file") || Meta::Utils::System::die("unable to open file [".$file."]");
	print FILE $text;
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

=item B<load_nodie($$)>

This routine receives a file name and a reference to a string.
The routine loads the file into the string. If the routine fails
somewhere then it return a valid error bit.

=cut

sub load_nodie($$) {
	my($file,$text)=@_;
	if(!open(FILE,$file)) {
		return(0);
	}
	binmode(FILE);
	$$text="";
	my($line);
	while($line=<FILE> || 0) {
		$$text.=$line;
	}
	if(!close(FILE)) {
		return(0);
	}
	return(1);
}

=item B<load($)>

This routine loads up a files into a single string and gives it to you.
Currently it just loads up the file line by line and catenates them into
a variable.

=cut

sub load($) {
	my($file)=@_;
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	binmode(FILE);
	my($resu);
	my($line);
	while($line=<FILE> || 0) {
		$resu.=$line;
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return($resu);
}

=item B<load_line($$)>

This routine loads a specific text line from the source file given to it.
You better make sure that the specified file has that line in it..!!!:)

=cut

sub load_line($$) {
	my($file,$numb)=@_;
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	binmode(FILE);
	my($over)=0;
	my($line);
	my($coun)=0;
	my($resu);
	while(($line=<FILE> || 0) && (!$over)) {
		if($coun==$numb) {
			$resu=$line;
			chop($resu);
			$over=1;
		} else {
			$coun++;
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return($resu);
}

=item B<cmp($$)>

This routines receives a file to compare a variable with.
It returns a boolean value which is the result of the comparison.
The implementation attemps to read length(input) characters from
the file. If it fails it return false and else it just does a eq
comparison...

=cut

sub cmp($$) {
	my($file,$comp)=@_;
	my($leng)=length($comp);
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($buff);
	my($result);
	my($res)=read(FILE,$buff,$leng);
	if(!$res) {
		$result=0;
	} else {
		if($buff ne $comp) {
			$result=0;
		} else {
			$result=1;
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
	return($result);
}

=item B<exist($)>

This routine returns whether a cetain file is a regular file

=cut

sub exist($) {
	my($file)=@_;
	return(-f $file);
}

=item B<notexist($)>

This routine returns whether a certain file not exist as a regular file

=cut

sub notexist($) {
	my($file)=@_;
	return(!exist($file));
}

=item B<check_exist($)>

This routine checks if a file given to it exists and if indeed it is a
regular file. If something fails it dies.

=cut

sub check_exist($) {
	my($file)=@_;
	if(!exist($file)) {
		Meta::Utils::System::die("file [".$file."] does not exist and it should");
	}
}

=item B<check_notexist($)>

This routine checks if a file given to it not exists.
If something fails it dies.

=cut

sub check_notexist($) {
	my($file)=@_;
	if(!notexist($file)) {
		Meta::Utils::System::die("file [".$file."] does exist and it should not");
	}
}

=item B<create_new($)>

This function receives a file name and creates that file (it supposes the
file does not exist and if it does it fails...).

=cut

sub create_new($) {
	my($file)=@_;
	check_notexist($file);
	open(FILE,"> ".$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

=item B<subst($$$)>

This function receives the following arguments:
1. File to be modifield.
2. Pattern to be searched for.
3. Pattern to be replaced with.
And modifies the file by replacing the required pattern with the target pattern.

=cut

sub subst($$$) {
	my($file,$sour,$targ)=@_;
	my($verb)=0;
	if($verb) {
		Meta::Utils::Output::print("file is [".$file."]\n");
		Meta::Utils::Output::print("sour is [".$sour."]\n");
		Meta::Utils::Output::print("targ is [".$targ."]\n");
	}
	my($text)=load($file);
	if($text=~/$sour/) {
		if($verb) {
			Meta::Utils::Output::print("text is [".$text."]\n");
		}
		$text=~s/$sour/$targ/g;
		if($verb) {
			Meta::Utils::Output::print("text is [".$text."]\n");
		}
		save($file,$text);
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
2	Thu Jan  4 06:30:32 2001	MV	this time really make the databases work
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
6	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
7	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
8	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
9	Thu Jan 18 15:59:13 2001	MV	correct die usage
10	Sun Jan 28 02:34:56 2001	MV	perl code quality
11	Sun Jan 28 13:51:26 2001	MV	more perl quality
12	Tue Jan 30 03:03:17 2001	MV	more perl quality
13	Sat Feb  3 23:41:08 2001	MV	perl documentation
14	Mon Feb  5 03:21:02 2001	MV	more perl quality
15	Tue Feb  6 01:04:52 2001	MV	perl qulity code
16	Tue Feb  6 07:02:13 2001	MV	more perl code quality
17	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-Can we do the file load function in a more efficient way ? (like first getting the size of the file and the gulping it down?).

-Cant the load() fundtion return a reference to the data instead of the actual data ? (the return value may be long...). (The same goes for load_line...).

-Do the create_new function more effiently (isnt there a perl function for it?).

-make the load routine prototype be the same as the load_nodie prototype. (its cleaner that way...).

=cut
