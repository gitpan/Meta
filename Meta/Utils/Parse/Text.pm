#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Parse::Text;

use strict qw(vars refs subs);
use IO::File qw();
use IO::Pipe qw();

our($VERSION,@ISA);
$VERSION="0.27";
@ISA=qw();

#sub new($);
#sub init_file($$);
#sub init_proc($$);
#sub get_over($);
#sub get_line($);
#sub next($);
#sub fini($);

#__DATA__

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

sub get_over($) {
	my($self)=@_;
	return($self->{OVER});
}

sub get_line($) {
	my($self)=@_;
	return($self->{LINE});
}

sub get_numb($) {
	my($self)=@_;
	return($self->{NUMB});
}

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

__END__

=head1 NAME

Meta::Utils::Parse::Text - library to help you parse text files.

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

	MANIFEST: Text.pm
	PROJECT: meta
	VERSION: 0.27

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Parse::Text qw();
	my($prase)=Meta::Utils::Parse::Text->new();

=head1 DESCRIPTION

This module helps you in parsing text files.
You construct a parser, give it a text file and loop until its over each
time getting the current line from it...
You can also init the parser from a process and so get the process output
in a pipe without having to temporarily store it. This enables you to get the
output of a process much cleaner.

=head1 FUNCTIONS

	new($)
	init_file($$)
	init_proc($$)
	get_over($)
	get_line($)
	next($)
	fini($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This function constrcuts a new parser object.

=item B<init_file($$)>

This function initializes the parser.
This function receives:
0. A parser object to work with.
1. A file name to work with.

=item B<init_proc($$)>

This function initializes the parser from a process instead of a file.

=item B<get_over($)>

This function returns whether the current parser is over or not.
This function receives:
0. A parser object to work with.

=item B<get_line($)>

This function returns the current line from the parser.
This function receives:
0. A parser object to work with.

=item B<get_numb($)>

This function return the current line number from the parser.
This function receives:
0. A parser object to work with.

=item B<next($)>

This moves the parser to the next line.
This function receives:
0. A parser object to work with.

=item B<fini($)>

This methos wraps up the object closing any opened files, processes etc..
This function receives:
0. A parser object to work with.

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
	0.02 MV make quality checks on perl code
	0.03 MV more perl checks
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV fix all tests change
	0.08 MV change new methods to have prototypes
	0.09 MV correct die usage
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV chess and code quality
	0.13 MV more perl quality
	0.14 MV perl documentation
	0.15 MV more perl quality
	0.16 MV perl qulity code
	0.17 MV more perl code quality
	0.18 MV revision change
	0.19 MV languages.pl test online
	0.20 MV perl packaging
	0.21 MV PDMT
	0.22 MV md5 project
	0.23 MV database
	0.24 MV perl module versions in files
	0.25 MV movies and small fixes
	0.26 MV thumbnail user interface
	0.27 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
