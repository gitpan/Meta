#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Perl::Perl;

use strict qw(vars refs subs);
use Meta::Utils::Utils qw();
use Meta::Utils::System qw();
use ExtUtils::MakeMaker qw();
use ExtUtils::MM_Unix qw();
use Meta::Utils::File::Remove qw();

our($VERSION,@ISA);
$VERSION="0.12";
@ISA=qw();

#sub is_perl($);
#sub is_lib($);
#sub is_bin($);
#sub is_test($);
#sub get_prefix_lib();
#sub get_prefix_bin();
#sub remove_prefix_lib($);
#sub remove_prefix_bin($);
#sub remove_prefix($);
#sub get_version_mm($);
#sub get_version_mm_unix($);
#sub get_version($);
#sub load_module($);
#sub get_isa($);
#sub run($);
#sub profile($);
#sub man($);
#sub man_file($);
#sub man_deve($);
#sub module_to_file($);
#sub module_to_search_file($);
#sub file_to_module($);
#sub module_to_link($);
#sub get_pods($);
#sub get_name($);

#__DATA__

sub is_perl($) {
	my($file)=@_;
	return(is_lib($file) || is_bin($file));
}

sub is_lib($) {
	my($file)=@_;
	return($file=~/\.pm$/);
}

sub is_bin($) {
	my($file)=@_;
	return($file=~/\.pl$/);
}

sub is_test($) {
	my($file)=@_;
	return($file=~/perl\/bin\/Meta\/Tests\//);
}

sub get_prefix_lib() {
	return("perl/lib/");
}

sub get_prefix_bin() {
	return("perl/bin/");
}

sub remove_prefix_lib($) {
	my($modu)=@_;
	return(Meta::Utils::Utils::minus($modu,&get_prefix_lib()));
}

sub remove_prefix_bin($) {
	my($modu)=@_;
	return(Meta::Utils::Utils::minus($modu,&get_prefix_bin()));
}

sub remove_prefix($) {
	my($modu)=@_;
	if(&is_lib($modu)) {
		return(&remove_prefix_lib($modu));
	}
	if(&is_bin($modu)) {
		return(&remove_prefix_bin($modu));
	}
	Meta::Utils::System::die("what the hell is [".$modu."]");
}

sub get_version_mm($) {
	my($file)=@_;
	#we build an object every time. Yes. It's wasteful.
	my($mm)=ExtUtils::MakeMaker->new();
	my($version)=$mm->parse_version($file);
	#this commented method doesnt work since parse_version isnt
	#realy a method of ExtUtils::MakeMaker.
	#my($version)=ExtUtils::MakeMaker->parse_version($file);
	if(!defined($version)) {
		return(0);
		#Meta::Utils::System::die("what version is [".$file."]");
	} else {
		#Meta::Utils::Output::print("got version [".$version."] for module [".$file."]\n");
	}
	return($version);
}

sub get_version_mm_unix($) {
	my($file)=@_;
	my($version)=ExtUtils::MM_Unix->parse_version($file);
	if(!defined($version)) {
		return(0);
		#Meta::Utils::System::die("what version is [".$file."]");
	} else {
		#Meta::Utils::Output::print("got version [".$version."] for module [".$file."]\n");
	}
	return($version);
}

sub get_version($) {
	my($file)=@_;
	my($modu)=file_to_module($file);
	no strict 'refs';
	load_module($modu);
	my($versionref)=*{$modu."::VERSION"}{SCALAR};
	my($version)=$$versionref;
	#use strict 'refs';
	return($version);
}

sub load_module($) {
	my($module)=@_;
	eval "require $module";
	if($@) {
		Meta::Utils::System::die("unable to load module [".$module."]");
	}
}

sub get_isa($) {
	my($file)=@_;
	my($modu)=file_to_module($file);
	load_module($modu);
	no strict 'refs';
	#my($isa)=*{$modu."::ISA"}{ARRAY};
	my($isa)=*{$modu."::ISA"};
	#use strict 'refs';
	return($isa);
}

sub run($) {
	my($modu)=@_;
	return(Meta::Utils::System::system_nodie("perl",[$modu]));
}

sub profile($) {
	my($modu)=@_;
	Meta::Utils::System::system_nodie("perl",["-d:DProf",$modu]);
	Meta::Utils::System::system_nodie("dprofpp",[]);
	Meta::Utils::File::Remove::rm("tmon.out");
}

sub man($) {
	my($modu)=@_;
	return(Meta::Utils::System::system_nodie("perldoc",[$modu]));
}

sub man_file($) {
	my($file)=@_;
	return(Meta::Utils::System::system_nodie("perldoc",["-F",$file]));
}

sub man_deve($) {
	my($deve)=@_;
	my($file)=Meta::Baseline::Aegis::which($deve);
	return(Meta::Utils::System::system_nodie("perldoc",["-F",$file]));
}

sub module_to_file($) {
	my($modu)=@_;
	$modu=~s/::/\//g;
	$modu="perl/lib/".$modu.".pm";
	return($modu);
}

sub module_to_search_file($) {
	my($modu)=@_;
	$modu=~s/::/\//g;
	$modu.=".pm";
	return($modu);
}

sub file_to_module($) {
	my($file)=@_;
	my($modu)=($file=~/^.*perl\/lib\/(.*)\.pm$/);
	$modu=~s/\//::/g;
	return($modu);
}

sub module_to_link($) {
	my($module)=@_;
	return($module."(3)");
}

sub get_pods($) {
	my($text)=@_;
	my(@lines)=split('\n',$text);
	my($size)=$#lines+1;
	my($inde)=undef;#init the variable
	my(%hash);
	for(my($i)=0;$i<$size;$i++) {
		my($curr)=$lines[$i];
		if($curr=~/^=/) {
			if($curr=~/^=head1 /) {
				($inde)=($curr=~/^=head1 (.*)$/);
			} else {
				$inde=undef;#init the variable
			}
		} else {
			if(defined($inde)) {
#				Meta::Utils::Output::print("adding [".$curr."] to [".$inde."]\n");
				if(exists($hash{$inde})) {
					$hash{$inde}.="\n".$curr;
				} else {
					$hash{$inde}=$curr;
				}
			}
		}
	}
	return(\%hash);
}

sub get_name($) {
	my($text)=@_;
	if($text!~/^\n.* - .*\.\n$/) {
		Meta::Utils::System::die("bad NAME pod found [".$text."]");
	}
	my($out)=($text=~/^\n.* - (.*)\.\n$/);
	return($out);
}

1;

__END__

=head1 NAME

Meta::Lang::Perl::Perl - tool to ease interaction with Perl.

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

	MANIFEST: Perl.pm
	PROJECT: meta
	VERSION: 0.12

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Perl::Perl qw();
	my($object)=Meta::Lang::Perl::Perl->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module eases interaction with the Perl language interpreter.

=head1 FUNCTIONS

	is_perl($)
	is_lib($)
	is_bin($)
	is_test($)
	get_prefix_lib()
	get_prefix_bin()
	remove_prefix_lib($)
	remove_prefix_bin($)
	remove_prefix($)
	get_version_mm($)
	get_version_mm_unix($)
	get_version($)
	load_module($)
	get_isa($)
	run($)
	profile($)
	man($)
	man_file($)
	man_deve($)
	module_to_file($)
	module_to_search_file($)
	file_to_module($)
	module_to_link($)
	get_pods($)
	get_name($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<is_perl($)>

This method will return true iff the file in question is a perl file
(script or library).

=item B<is_lib($)>

This method receives a file name and return true if the file
is a perl library.

=item B<is_bin($)>

This method receives a file name and return true if the file
is a perl binary.

=item B<is_test($)>

This method receives a file name and returns true if the file
is a perl test file.

=item B<get_prefix_lib()>

This returns the prefix for perl modules stored in the baseline.

=item B<get_prefix_bin()>

This returns the prefix for perl binaries stored in the baseline.

=item B<remove_prefix_lib($)>

This method removes a prefix from a baseline related module.

=item B<remove_prefix_bin($)>

This method removes a prefix from a baseline related script.

=item B<remove_prefix($)>

This method receives a perl file (script or lib) and removes its prefix.

=item B<get_version_mm($)>

This method gets a filename of a perl module and returns it's version number.
This method uses ExtUtils::MakeMaker.
The actual code that ExtUtils::MakeMaker uses in from MM_Unix.
There is a problem with this method that emits strange warning.
This method returns 0 in case the version cannot be established.

=item B<get_version_mm_unix($)>

This method gets a filename of a perl module and returns it's version number.
This method calls ExtUtils::MM_Unix directly to avoid the MakeMaker warnings.
The method does not create an ExtUtils::MM_Unix object since it's method
makes no use of the object passed. This may cause problems in the future.
This method returns 0 in case the version cannot be established.

=item B<get_version($)>

This method gets a filename of a perl module and returns it's version number.
This is my own version. Unlike the MM code which parses the modules actual
text (opens the file etc...) my code loads the module (which is at least
as long) but them proceeds to get the $VERSION variable from the package using
perl reference techniques.

=item B<load_module($)>

This method will load a module.

=item B<get_isa($)>

This will get the ISA part of the module.
The code loads the modules and uses references to achieve this.

=item B<run($)>

Routine to run the perl script it receives as input.

=item B<profile($)>

Routine to run the perl profile on the script it receives as input.

=item B<man($)>

Routine to show a manual page of a perl module (the parameter).
The parameter is passed directly to perldoc.

=item B<man_file($)>

Routine to show a manual page of a file. The perldoc is told that
the argument is a file.

=item B<man_deve($)>

This routine will show a manual page of a development module.

=item B<module_to_file($)>

This will translate a module name to a baseline relative file name.

=item B<module_to_search_file($)>

This will translate a module name to a module file to search for (without
the perl/lib prefix...

=item B<file_to_module($)>

This will translate a file name to a module name.

=item B<module_to_link($)>

This method will translate a module name to a link which
could be put in a pod section. Currently it just adds the
"(3)" suffix to the name which could be problematic if
things change too much.

=item B<get_pods($)>

This method will extract pods from a perl source and will return them as a hash.

=item B<get_name($)>

This will return the name of the executable.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more perl packaging
	0.01 MV perl packaging again
	0.02 MV more Perl packaging
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV graph visualization
	0.08 MV md5 progress
	0.09 MV thumbnail user interface
	0.10 MV import tests
	0.11 MV dbman package creation
	0.12 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-write my own get_version code (simple parsing with no eval suitable for internal modules).
