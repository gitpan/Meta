#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Opts::Sopt;

use strict qw(vars refs subs);
use Meta::Utils::File::File qw();
use Meta::Utils::File::Dir qw();
use Meta::Baseline::Aegis qw();
use Meta::Class::MethodMaker qw();
use Meta::Utils::File::Path qw();
use LWP::Simple qw();
use Meta::Utils::Output qw();
use Meta::Development::Module qw();

our($VERSION,@ISA);
$VERSION="0.32";
@ISA=qw();

#sub BEGIN();
#sub setup_value($$);
#sub verify($$);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_description",
		-java=>"_type",
		-java=>"_defa",
		-java=>"_poin",
		-java=>"_valu",
		-java=>"_enum",
	);
	Meta::Class::MethodMaker->print([
		"name",
		"description",
		"type",
		"defa",
		"poin",
		"valu",
		"enum",
	]);
}

sub setup_value($$) {
	my($self,$valu)=@_;
	if($self->get_type() eq "setx") {
		my($poin)=$self->get_poin();
		$$poin->clear();
		my(@list)=split(',',$valu);
		for(my($i)=0;$i<=$#list;$i++) {
	#		Meta::Utils::Output::print("poin is [".$poin."]\n");
			$$poin->insert($list[$i]);
		}
		return;
	}
	if($self->get_type() eq "urls") {
		$self->set_valu(LWP::Simple::get($valu));
		return;
	}
	if($self->get_type() eq "modu") {
		my($modu)=Meta::Development::Module->new();
		$modu->set_name($valu);
		$self->set_valu($modu);
		return;
	}
	$self->set_valu($valu);
}

sub verify($$) {
	my($self,$erro)=@_;
	my($type)=$self->get_type();
#	Meta::Utils::Output::print("in verify with type [".$type."]\n");
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
		my($valu)=$self->get_valu();
		my($scod)=Meta::Baseline::Aegis::direxists($valu);
		if(!$scod) {
			$$erro="directory [".$valu."] does not exist as a development directory";
		}
		return($scod);
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
	if($type eq "urls") {
		#check that the value is of valid URL form.
		#check that URL can be fetched.
		return(1);
	}
	if($type eq "modu") {
		#check that the value is a valid path to a dev module
		return(1);
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
	if($type eq "setx") {
		my($valu)=$self->get_valu();
		my($setx)=$self->get_enum();
		#Meta::Utils::Output::print("in setx [".$valu."]\n");
		my($scod)=1;
		my(@list)=split(',',$valu);
		for(my($i)=0;$i<=$#list;$i++) {
			my($curr)=$list[$i];
			#Meta::Utils::Output::print("checking [".$curr."]\n");
			if($setx->hasnt($curr)) {
				$scod=0;
				$$erro="value [".$curr."] is not in set";
			}
		}
		return($scod);
	}
	if($type eq "path") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Path::check($valu,':');
		if(!$scod) {
			$$erro="value [".$valu."] is not a valid path";
		}
		return($scod);
	}
	if($type eq "flst") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Path::check_flst($valu,':');
		if(!$scod) {
			$$erro="value [".$valu."] is not a valid file list";
		}
		return($scod);
	}
	if($type eq "dlst") {
		my($valu)=$self->get_valu();
		my($scod)=Meta::Utils::File::Path::check($valu,':');
		if(!$scod) {
			$$erro="value [".$valu."] is not a valid directory list";
		}
		return($scod);
	}
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
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
	VERSION: 0.32

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Opts::Sopt qw();
	my($sopt)=Meta::Utils::Opts::Sopt->new();
	$sopt->set_name("name");

=head1 DESCRIPTION

This object is used by the Opts object to store information about a single command line argument.

=head1 FUNCTIONS

	new($)
	setup_value($$)
	verify($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

Setup routine which creates constructor, print method and accessor methods for the following
attributes:
1. name  - name of the parameter.
2. description - short description of the parameter.
3. type - type of the parameter.
4. defa - default value of the parameter.
5. poin - pointer for the parameter storage area.
6. valu - value of the parameter.
7. enum - enumerated set from which to select an enumerated parameter.
8. set - set from which to select a set parameter.

=item B<setup_value($$)>

This method sets the current value for the current parameter. The reason that you can just use
the set_valu accessor is that some values (like sets) are not really strings and need some
processing.

=item B<verify($$)>

This will run sanity checks on the value inside.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.26 MV paper writing
	0.27 MV website construction
	0.28 MV web site automation
	0.29 MV SEE ALSO section fix
	0.30 MV move tests to modules
	0.31 MV download scripts
	0.32 MV web site development

=head1 SEE ALSO

LWP::Simple(3), Meta::Baseline::Aegis(3), Meta::Class::MethodMaker(3), Meta::Development::Module(3), Meta::Utils::File::Dir(3), Meta::Utils::File::File(3), Meta::Utils::File::Path(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

-add set type.

-add limited range intergers.

-add regular expression match limited strings.

-add a write_file type which is a file that could be written (as opposed to
	a file which doesnt exist in new_file).

-add clean character strings types (only nice characters...).

-add checks for integers, floating points etc...

-add dictorionary word type and check.

-add enumerated our() variable which stores all the types that we support and check it.
