#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Opts::Sopt;

use strict qw(vars refs subs);
use Meta::Utils::File::File qw();
use Meta::Utils::File::Dir qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub new($);
#sub get_name($);
#sub set_name($$);
#sub get_description($);
#sub set_description($$);
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

sub get_name($) {
	my($self)=@_;
	return($self->{NAME});
}

sub set_name($$) {
	my($self,$name)=@_;
	$self->{NAME}=$name;
}

sub get_description($) {
	my($self)=@_;
	return($self->{DESC});
}

sub set_description($$) {
	my($self,$desc)=@_;
	$self->{DESC}=$desc;
}

sub get_type($) {
	my($self)=@_;
	return($self->{TYPE});
}

sub set_type($$) {
	my($self,$type)=@_;
	$self->{TYPE}=$type;
}

sub get_defa($) {
	my($self)=@_;
	return($self->{DEFA});
}

sub set_defa($$) {
	my($self,$defa)=@_;
	$self->{DEFA}=$defa;
}

sub get_poin($) {
	my($self)=@_;
	return($self->{POIN});
}

sub set_poin($$) {
	my($self,$poin)=@_;
	$self->{POIN}=$poin;
}

sub get_valu($) {
	my($self)=@_;
	return($self->{VALU});
}

sub set_valu($$) {
	my($self,$valx)=@_;
	$self->{VALU}=$valx;
}

sub get_enum($) {
	my($self)=@_;
	return($self->{ENUM});
}

sub set_enum($$) {
	my($self,$valx)=@_;
	$self->{ENUM}=$valx;
}

sub verify($$) {
	my($self,$erro)=@_;
	my($type)=$self->get_type();
	if($type eq "dire") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Dir::exist($valu);
		if(!$scod) {
			$$erro="directory [".$valu."] does not exist";
		}
		return($scod);
	}
	if($type eq "newd") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Dir::exist($valu);
		if($scod) {
			$$erro="directory [".$valu."] exists";
		}
		return(!$scod);
	}
	if($type eq "devd") {
		return(1);
	}
	if($type eq "file") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::File::exist($valu);
		if(!$scod) {
			$$erro="file [".$valu."] does not exist";
		}
		return($scod);
	}
	if($type eq "newf") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::File::exist($valu);
		if($scod) {
			$$erro="file [".$valu."] exists";
		}
		return(!$scod);
	}
	if($type eq "devf") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Baseline::Aegis::exists($valu);
		if(!$scod) {
			$$erro="file [".$valu."] does not exist as a development file";
		}
		return($scod);
	}
	if($type eq "enum") {
		my($valu)=$self->get_valu();
		my($enum)=$self->get_enum();
		my($scod)=$enum->has($valu);
		if(!$scod) {
			$$erro="value [".$valu."] is not part of the enum";
		}
		return($scod);
	}
	return(1);
}

sub print($$) {
	my($self,$file)=@_;
	print $file "sopt info name=[".$self->get_name()."]\n";
	print $file "sopt info desc=[".$self->get_description()."]\n";
	print $file "sopt info type=[".$self->get_type()."]\n";
	print $file "sopt info defa=[".$self->get_defa()."]\n";
	print $file "sopt info poin=[".$self->get_poin()."]\n";
	print $file "sopt info valu=[".$self->get_valu()."]\n";
	print $file "sopt info enum=[".$self->get_enum()."]\n";
}

1;

__END__

=head1 NAME

Meta::Utils::Opts::Sopt - Object to store a definition for a command line option.

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

	MANIFEST: Sopt.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Opts::Sopt qw();
	my($sopt)=Meta::Utils::Opts::Sopt->new();
	$sopt->set_name("name");

=head1 DESCRIPTION

This object is used by the Opts object to store information about a single command line argument.

=head1 FUNCTIONS

	new($)
	get_name($)
	set_name($$)
	get_description($)
	set_description($$)
	get_type($)
	set_type($$)
	get_defs($)
	set_defs($$)
	get_poin($)
	set_poin($$)
	get_valu($)
	set_valu($$)
	get_enum($)
	set_enum($$)
	verify($$)
	print($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new Sopt object.

=item B<get_name($)>

This will retrieve the name of the current object.

=item B<set_name($$)>

This will set the name for the current object.

=item B<get_description($)>

This returns the description for the current object.

=item B<set_description($$)>

This will set the description for the current object.

=item B<get_type($)>

This method returns the type of the current object.

=item B<set_type($$)>

This method will set the type of the current object.

=item B<get_defa($)>

This method will returns the default value of the current object.

=item B<set_defa($$)>

This method will set the default value of the current object.

=item B<get_poin($)>

This method will return the pointer of the current object.

=item B<set_opti($$)>

This method will set the pointer of the current object.

=item B<get_valu($)>

This method will retrieve the current value of the current object.

=item B<set_valu($$)>

This method will set the current value of the current object.

=item B<get_enum($)>

This method will retrieve the current enum of the current object.

=item B<set_enum($$)>

This method will set the current enum of the current object.

=item B<verify($$)>

This will run sanity checks on the value inside.

=item B<print($$)>

This prints out the current Sopt object.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV make Meta::Utils::Opts object oriented
	0.01 MV fix todo items look in pod documentation
	0.02 MV add enumerated types to options
	0.03 MV more on tests/more checks to perl
	0.04 MV change new methods to have prototypes
	0.05 MV perl code quality
	0.06 MV more perl quality
	0.07 MV more perl quality
	0.08 MV get basic Simul up and running
	0.09 MV perl documentation
	0.10 MV more perl quality
	0.11 MV perl qulity code
	0.12 MV more perl code quality
	0.13 MV revision change
	0.14 MV better general cook schemes
	0.15 MV languages.pl test online
	0.16 MV Pdmt stuff
	0.17 MV perl packaging
	0.18 MV PDMT
	0.19 MV tree type organization in databases
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-add set type.

-add limited range intergers.

-add regular expression match limited strings.

-add a write_file type which is a file that could be written (as opposed to
	a file which doesnt exist in new_file).

-add clean character strings types (only nice characters...).
