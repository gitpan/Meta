#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Opts::Sopt - Object to store a definition for a command line option.

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

MANIFEST: Sopt.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Opts::Sopt qw();>
C<my($sopt)=Meta::Utils::Opts::Sopt->new();>
C<$sopt->set_name("name");>

=head1 DESCRIPTION

This object is used by the Opts object to store information about a single command line argument.

=head1 EXPORTS

C<new($)>
C<get_name($)>
C<set_name($$)>
C<get_desc($)>
C<set_desc($$)>
C<get_type($)>
C<set_type($$)>
C<get_defs($)>
C<set_defs($$)>
C<get_poin($)>
C<set_poin($$)>
C<get_valu($)>
C<set_valu($$)>
C<get_enum($)>
C<set_enum($$)>
C<verify($$)>
C<print($$)>

=cut

package Meta::Utils::Opts::Sopt;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::File::File qw();
use Meta::Utils::File::Dir qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub get_name($);
#sub set_name($$);
#sub get_desc($);
#sub set_desc($$);
#sub get_type($);
#sub set_type($$);
#sub get_defs($);
#sub set_defs($$);
#sub get_poin($);
#sub set_poin($$);
#sub get_valu($);
#sub set_valu($$);
#sub get_enum($);
#sub set_enum($$);
#sub verify($$);
#sub print($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new Sopt object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{NAME}=defined;
	$self->{DESC}=defined;
	$self->{TYPE}=defined;
	$self->{DEFA}=defined;
	$self->{POIN}=defined;
	$self->{VALU}=defined;
	$self->{ENUM}=defined;
	return($self);
}

=item B<get_name($)>

=cut

sub get_name($) {
	my($self)=@_;
	return($self->{NAME});
}

=item B<set_name($$)>

This will set the name for the current object.

=cut

sub set_name($$) {
	my($self,$name)=@_;
	$self->{NAME}=$name;
}

=item B<get_desc($)>

This returns the description for the current object.

=cut

sub get_desc($) {
	my($self)=@_;
	return($self->{DESC});
}

=item B<set_desc($$)>

This will set the description for the current object.

=cut

sub set_desc($$) {
	my($self,$desc)=@_;
	$self->{DESC}=$desc;
}

=item B<get_type($)>

This method returns the type of the current object.

=cut

sub get_type($) {
	my($self)=@_;
	return($self->{TYPE});
}

=item B<set_type($$)>

This method will set the type of the current object.

=cut

sub set_type($$) {
	my($self,$type)=@_;
	$self->{TYPE}=$type;
}

=item B<get_defa($)>

This method will returns the default value of the current object.

=cut

sub get_defa($) {
	my($self)=@_;
	return($self->{DEFA});
}

=item B<set_defa($$)>

This method will set the default value of the current object.

=cut

sub set_defa($$) {
	my($self,$defa)=@_;
	$self->{DEFA}=$defa;
}

=item B<get_poin($)>

This method will return the pointer of the current object.

=cut

sub get_poin($) {
	my($self)=@_;
	return($self->{POIN});
}

=item B<set_opti($$)>

This method will set the pointer of the current object.

=cut

sub set_poin($$) {
	my($self,$poin)=@_;
	$self->{POIN}=$poin;
}

=item B<get_valu($)>

This method will retrieve the current value of the current object.

=cut

sub get_valu($) {
	my($self)=@_;
	return($self->{VALU});
}

=item B<set_valu($$)>

This method will set the current value of the current object.

=cut

sub set_valu($$) {
	my($self,$valx)=@_;
	$self->{VALU}=$valx;
}

=item B<get_enum($)>

This method will retrieve the current enum of the current object.

=cut

sub get_enum($) {
	my($self)=@_;
	return($self->{ENUM});
}

=item B<set_enum($$)>

This method will set the current enum of the current object.

=cut

sub set_enum($$) {
	my($self,$valx)=@_;
	$self->{ENUM}=$valx;
}

=item B<verify($$)>

This will run sanity checks on the value inside.

=cut

sub verify($$) {
	my($self,$erro)=@_;
	my($type)=$self->get_type();
	if($type eq "new_file") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::File::exist($valu);
		if($scod) {
			$$erro="file [".$valu."] exists";
			return(0);
		} else {
			return(1);
		}
	}
	if($type eq "file") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::File::exist($valu);
		if(!$scod) {
			$$erro="file [".$valu."] does not exist";
			return(0);
		} else {
			return(1);
		}
	}
	if($type eq "dire") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Dir::exist($valu);
		if(!$scod) {
			$$erro="directory [".$valu."] does not exist";
			return(0);
		} else {
			return(1);
		}
	}
	if($type eq "enum") {
		my($valu)=$self->get_valu();
		my($enum)=$self->get_enum();
		my($scod)=$enum->has($valu);
		if(!$scod) {
			$$erro="value [".$valu."] is not part of the enum";
			return(0);
		} else {
			return(1);
		}
	}
	return(1);
}

=item B<print($$)>

This prints out the current Sopt object.

=cut

sub print($$) {
	my($self,$file)=@_;
	print $file "sopt info name=[".$self->get_name()."]\n";
	print $file "sopt info desc=[".$self->get_desc()."]\n";
	print $file "sopt info type=[".$self->get_type()."]\n";
	print $file "sopt info defa=[".$self->get_defa()."]\n";
	print $file "sopt info poin=[".$self->get_poin()."]\n";
	print $file "sopt info valu=[".$self->get_valu()."]\n";
	print $file "sopt info enum=[".$self->get_enum()."]\n";
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
2	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
3	Tue Jan  9 22:40:39 2001	MV	add enumerated types to options
4	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
5	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
6	Sun Jan 28 02:34:56 2001	MV	perl code quality
7	Sun Jan 28 13:51:26 2001	MV	more perl quality
8	Tue Jan 30 03:03:17 2001	MV	more perl quality
9	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
10	Sat Feb  3 23:41:08 2001	MV	perl documentation
11	Mon Feb  5 03:21:02 2001	MV	more perl quality
12	Tue Feb  6 01:04:52 2001	MV	perl qulity code
13	Tue Feb  6 07:02:13 2001	MV	more perl code quality
14	Tue Feb  6 22:19:51 2001	MV	revision change
14	Thu Feb  8 00:23:21 2001	MV	betern general cook schemes
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add set type.

-add limited range intergers.

-add regular expression match limited strings.

-add a write_file type which is a file that could be written (as opposed to
	a file which doesnt exist in new_file).

-add clean character strings types (only nice characters...).

=cut
