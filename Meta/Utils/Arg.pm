#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Arg;

use strict qw(vars refs subs);
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub check_arg_num($$);
#sub check_arg($$);

#__DATA__

sub check_arg_num($$) {
	my($arra,$numx)=@_;
	my($size)=$#$arra+1;
	if($size!=$numx) {
		Meta::Utils::System::die("number of arguments is wrong [".$size."] and not [".$numx."]");
	}
}

sub check_arg($$) {
	my($varx,$type)=@_;
	if(!defined($varx)) {
		Meta::Utils::System::die("undefined variable");
	}
	if(defined($type)) {
		if($type eq "ANY") {
			return(1);
		}
		if($type eq "SCALAR") {
			my($ref)=CORE::ref($varx);
			if($ref eq "") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of SCALAR is [".$ref."]");
			}
		}
		if($type eq "SCALARref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "SCALAR") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of SCALARref is [".$ref."]");
			}
		}
		if($type eq "ARRAYref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "ARRAY") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of ARRAYref is [".$ref."]");
			}
		}
		if($type eq "HASHref") {
			my($ref)=CORE::ref($varx);
			if($ref eq "HASH") {
				return(1);
			} else {
				Meta::Utils::System::die("what kind of HASHref is [".$ref."]");
			}
		}
		if(UNIVERSAL::isa($varx,$type)) {
			return(1);
		} else {
			Meta::Utils::System::die("variable [".$varx."] is not of type [".$type."]");
		}
	} else {
		Meta::Utils::System::die("why is type undef ?");
		return(0);
	}
#	my($resu)=ref($varx);
#	if(defined($resu)) {
#		if($resu ne $type) {
#			Meta::Utils::System::die("variable is not of type [".$varx."] but of type [".$resu."]");
#		}
#	} else {
#		Meta::Utils::System::die("ref didn't return defined value");
#	}
}

1;

__END__

=head1 NAME

Meta::Utils::Arg - module to help you checking argument types to methods/functions.

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

	MANIFEST: Arg.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Arg qw();
	Meta::Utils::Arg::check_arg_num(\@_,3);

=head1 DESCRIPTION

This is a general utility module for either miscelleneous commands which are hard to calssify or for routines which are just starting to form a module and have not yet been given a module and moved there.

=head1 FUNCTIONS

	bnot($)
	minus($$)
	get_temp_dir()
	get_temp_dire()
	get_temp_file()
	check_arg_num($$)
	check_arg($$)
	replace_suffix($$)
	remove_suffix($)
	is_prefix($$)
	is_suffix($$)
	cuid()
	cgid()
	get_home_dir()
	get_user_home_dir($)
	pwd()
	remove_comments($)
	chdir($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<check_arg_num($$)>

This method will check that the number of arguments is the correct one.

=item B<check_arg($$)>

This checks that the type of argument given to it has the type give to it
using the ref routine (very useful for when receiving lists,hashes etc..).

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV PDMT/SWIG support
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-implement the get_temp_dir routine better... (is there a way of officialy getting such a directory ?).

-is there a better way to implement the get_temp_dire routine ?

-move the get_home_dir and the other function built to some library.

-maybe there is a better way to get my home directory than from the environment ?

-The is suffix routine and is prefix routines should be fixed for cases where the string they match has special (regexp type) characters in it. Watch the example in cook_touch.

-more routines should be moved to their own modules...

-reimplement the home directory of the current user just like any others.

-fix the cgid routine... (isnt there a better way to do it ?!?...)
