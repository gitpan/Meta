#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Text::Lines - library to do operations on sets of lines.

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

MANIFEST: Lines.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Text::Lines qw();>
C<my($obje)=Meta::Utils::Text::Lines->new();>
C<$obje->set_text("mark\ndoron\n","\n");>
C<$obje->remove_line("doron");>
C<my($new_text)=$obje->get_text();>

=head1 DESCRIPTION

This is a library to help you do things with lines of text coming from a file.
Currently it supports splitting the text and removing lines and returning
the text that results.

=head1 EXPORTS

C<new($)>
C<set_text($$$)>
C<remove_line($$)>
C<remove_line_re($$)>
C<remove_line_nre($$)>
C<get_text($)>
C<get_text_fixed($)>

=cut

package Meta::Utils::Text::Lines;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub set_text($$$);
#sub remove_line($$);
#sub remove_line_re($$);
#sub remove_line_nre($$);
#sub get_text($);
#sub get_text_fixed($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Lines object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{DELI}=defined;
	$self->{LIST}=defined;
	$self->{ATEN}=defined;
	return($self);
}

=item B<set_text($$$)>

This will set the text that the object will work on.

=cut

sub set_text($$$) {
	my($self,$text,$deli)=@_;
	$self->{DELI}=$deli;
	my(@lines)=split($deli,$text);
	$self->{LIST}=\@lines;
}

=item B<remove_line($$)>

This will remove a line that you know the text of.

=cut

sub remove_line($$) {
	my($self,$line)=@_;
	my($list)=$self->{LIST};
	my($size)=$#$list;
	for(my($i)=0;$i<=$size;$i++) {
		my($curr)=$list->[$i];
		if($curr eq $line) {
			$list->[$i]=undef;#remove the line
		}
	}
}

=item B<remove_line_re($$)>

This will remove all lines matching a certain regexp.

=cut

sub remove_line_re($$) {
	my($self,$re)=@_;
	my($list)=$self->{LIST};
	my($size)=$#$list;
	for(my($i)=0;$i<=$size;$i++) {
		my($curr)=$list->[$i];
		if($curr=~/$re/) {
			$list->[$i]=undef;#remove the line
		}
	}
}

=item B<remove_line_nre($$)>

This will remove all lines not matching a certain regexp.

=cut

sub remove_line_nre($$) {
	my($self,$re)=@_;
	my($list)=$self->{LIST};
	my($size)=$#$list;
	for(my($i)=0;$i<=$size;$i++) {
		my($curr)=$list->[$i];
#		Meta::Utils::Output::print("curr is [".$curr."]\n");
#		Meta::Utils::Output::print("re is [".$re."]\n");
		if($curr!~/$re/) {
#			Meta::Utils::Output::print("in match\n");
			$list->[$i]=undef;#remove the line
		}
	}
}

=item B<get_text($)>

This will retrieve the text currently stored in the object.

=cut

sub get_text($) {
	my($self)=@_;
	my($list)=$self->{LIST};
	my($size)=$#$list;
	my(@arra);
	for(my($i)=0;$i<=$size;$i++) {
		my($curr)=$list->[$i];
		if(defined($curr)) {
			push(@arra,$curr);
		}
	}
	my($resu)=join($self->{DELI},@arra);
	return($resu);
}

=item B<get_text_fixed($)>

This method is the same as get_text except it adds the delimiter at the end
if it is not there.

=cut

sub get_text_fixed($) {
	my($self)=@_;
	my($text)=$self->get_text();
	my($deli)=$self->{DELI};
	if($text ne "") {
		if(substr($text,-1) ne $deli) {
			$text.=$deli;
		}
	}
	return($text);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Tue Jan  9 17:00:22 2001	MV	fix up perl checks
2	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
2	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
3	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
4	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
5	Sun Jan 28 02:34:56 2001	MV	perl code quality
6	Sun Jan 28 13:51:26 2001	MV	more perl quality
7	Tue Jan 30 03:03:17 2001	MV	more perl quality
8	Wed Jan 31 19:51:08 2001	MV	get papers in good condition
9	Sat Feb  3 23:41:08 2001	MV	perl documentation
10	Mon Feb  5 03:21:02 2001	MV	more perl quality
11	Tue Feb  6 01:04:52 2001	MV	perl qulity code
12	Tue Feb  6 07:02:13 2001	MV	more perl code quality
13	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
