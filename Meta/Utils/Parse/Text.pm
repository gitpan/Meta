#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Parse::Text - library to help you parse text files.

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

MANIFEST: Text.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Parse::Text qw();>
C<my($prase)=Meta::Utils::Parse::Text->new();>

=head1 DESCRIPTION

This module helps you in parsing text files.
You construct a parser, give it a text file and loop until its over each
time getting the current line from it...
You can also init the parser from a process and so get the process output
in a pipe without having to temporarily store it. This enables you to get the
output of a process much cleaner.

=head1 EXPORTS

C<new($)>
C<init_file($$)>
C<init_proc($$)>
C<get_over($)>
C<get_line($)>
C<next($)>
C<fini($)>

=cut

package Meta::Utils::Parse::Text;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use IO::File qw();
use IO::Pipe qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub init_file($$);
#sub init_proc($$);
#sub get_over($);
#sub get_line($);
#sub next($);
#sub fini($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This function constrcuts a new parser object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{TYPE}=defined;
	$self->{FILE}=defined;
	$self->{OVER}=defined;
	$self->{LINE}=defined;
	$self->{NUMB}=defined;
	$self->{FNAM}=defined;
	$self->{PROC}=defined;
	return($self);
}

=item B<init_file($$)>

This function initializes the parser.
This function receives:
0. A parser object to work with.
1. A file name to work with.

=cut

sub init_file($$) {
	my($self,$fnam)=@_;
	my($file)=IO::File->new($fnam);
	if(!defined($file)) {
		Meta::Utils::System::die("unable to open file [".$fnam."]");
	}
	$self->{TYPE}="file";
	$self->{FNAM}=$fnam;
	$self->{FILE}=$file;
	my($line);
	if($line=<$file> || 0) {
		$self->{OVER}=0;
	} else {
		$self->{OVER}=1;
	}
	chop($line);
	$self->{LINE}=$line;
	$self->{NUMB}=0;
}

=item B<init_proc($$)>

This function initializes the parser from a process instead of a file.

=cut

sub init_proc($$) {
	my($self,$proc)=@_;
	my($file)=IO::Pipe->new();
	if(!defined($file)) {
		Meta::Utils::System::die("unable to create object");
	}
	$file->reader(@$proc);
	$self->{TYPE}="proc";
	$self->{PROC}=$proc;
	$self->{FILE}=$file;
	my($line);
	if($line=<$file> || 0) {
		$self->{OVER}=0;
	} else {
		$self->{OVER}=1;
	}
	chop($line);
	$self->{LINE}=$line;
	$self->{NUMB}=0;
}

=item B<get_over($)>

This function returns whether the current parser is over or not.
This function receives:
0. A parser object to work with.

=cut

sub get_over($) {
	my($self)=@_;
	return($self->{OVER});
}

=item B<get_line($)>

This function returns the current line from the parser.
This function receives:
0. A parser object to work with.

=cut

sub get_line($) {
	my($self)=@_;
	return($self->{LINE});
}

=item B<get_numb($)>

This function return the current line number from the parser.
This function receives:
0. A parser object to work with.

=cut

sub get_numb($) {
	my($self)=@_;
	return($self->{NUMB});
}

=item B<next($)>

This moves the parser to the next line.
This function receives:
0. A parser object to work with.

=cut

sub next($) {
	my($self)=@_;
	my($file)=$self->{FILE};
	my($line);
	if($line=<$file> || 0) {
		$self->{OVER}=0;
	} else {
		$self->{OVER}=1;
	}
	chop($line);
	$self->{LINE}=$line;
	$self->{NUMB}++;
}

=item B<fini($)>

This methos wraps up the object closing any opened files, processes etc..
This function receives:
0. A parser object to work with.

=cut

sub fini($) {
	my($self)=@_;
	my($type)=$self->{TYPE};
	if($type eq "file") {
		if(!$self->{FILE}->close()) {
			Meta::Utils::System::die("unable to close file [".$self->{FNAM}."]");
		}
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
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
5	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
6	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
7	Thu Jan 11 09:43:58 2001	MV	fix all tests change
8	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
8	Thu Jan 18 15:59:13 2001	MV	correct die usage
9	Sun Jan 28 02:34:56 2001	MV	perl code quality
10	Sun Jan 28 13:51:26 2001	MV	more perl quality
11	Mon Jan 29 20:54:18 2001	MV	chess and code quality
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

Nothing.

=cut
