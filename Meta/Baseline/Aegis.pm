#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Aegis;

use strict qw(vars refs subs);
use Meta::Utils::List qw();
use Meta::Utils::Hash qw();
use Meta::Utils::File::Collect qw();
use Meta::Utils::File::File qw();
use Meta::Utils::System qw();
use Meta::Utils::Parse::Text qw();
use Meta::Utils::File::Path qw();
use Meta::Utils::Output qw();
use Meta::Utils::File::Patho qw();

our($VERSION,@ISA);
$VERSION="0.48";
@ISA=qw();

#sub aesub($);
#sub aesub_file($);

#sub search_path();
#sub baseline();
#sub project();
#sub change();
#sub change_description();
#sub version();
#sub architecture();
#sub copyright_years();
#sub state();
#sub developer();
#sub developer_list();
#sub reviewer_list();
#sub integrator_list();
#sub administrator_list();

#sub development_directory();
#sub integration_directory();
#sub history_directory();

#sub deve();
#sub inte();

#sub work_dir();

#sub which_nodie($);
#sub which($);
#sub which_f($);
#sub which_dir($);

#sub search_path_object();

#sub search_path_list();
#sub search_path_hash();
#sub developer_list_list();
#sub developer_list_hash();
#sub reviewer_list_list();
#sub reviewer_list_hash();
#sub integrator_list_list();
#sub integrator_list_hash();
#sub administrator_list_list();
#sub administrator_list_hash();

#sub change_files_hash($$$$$$);
#sub project_files_hash($$$);
#sub source_files_hash($$$$$$);
#sub base_files_hash($$);
#sub missing_files_hash();
#sub extra_files_hash($);
#sub total_files_hash($$);

#sub change_files_list($$$$$$);
#sub project_files_list($$$);
#sub source_files_list($$$$$$);
#sub base_files_list($$);
#sub missing_files_list();
#sub extra_files_list($);
#sub total_files_list($$);

#sub no_missing_files($);

#sub checkout_file($);
#sub checkout_hash($);

#sub in_change($);
#sub have_aegis();

#sub TEST($);

#__DATA__

sub aesub($) {
	my($stri)=@_;
	my($resu)=Meta::Utils::System::system_out_val("/local/tools/bin/aesub",["'$stri'"]);
	chop($resu);
	return($resu);
}

sub aesub_file($) {
	my($file)=@_;
	my($text)=Meta::Utils::File::File::load($file);
	my($resu)=&aesub($text);
	return($resu);
}

sub search_path() {
	return(&aesub("\$Search_Path"));
}

sub baseline() {
	return(&aesub("\$Baseline"));
}

sub project() {
	return(&aesub("\$Project"));
}

sub change() {
	return(&aesub("\$Change"));
}

sub change_description() {
	return(&aesub("\${Change description}"));
}

sub version() {
	return(&aesub("\$Version"));
}

sub architecture() {
	return(&aesub("\$Architecture"));
}

sub copyright_years() {
	return(&aesub("\$Copyright_Years"));
}

sub state() {
	return(&aesub("\$STate"));
}

sub developer() {
	return(&aesub("\$Developer"));
}

sub developer_list() {
	return(&aesub("\$DEVeloper_List"));
}

sub reviewer_list() {
	return(&aesub("\$Reviewer_List"));
}

sub integrator_list() {
	return(&aesub("\$Integrator_List"));
}

sub administrator_list() {
	return(&aesub("\$Administrator_List"));
}

sub development_directory() {
	return(&aesub("\$Development_Directory"));
}

sub integration_directory() {
	return(&aesub("\$Integration_Directory"));
}

sub history_directory() {
	return(&aesub("\$History_Directory"));
}

sub deve() {
	if(state() eq "being_developed") {
		return(1);
	} else {
		return(0);
	}
}

sub inte() {
	if(state() eq "being_integrated") {
		return(1);
	} else {
		return(0);
	}
}

sub work_dir() {
	if(deve()) {
		return(development_directory());
	}
	if(inte()) {
		return(integration_directory());
	}
	Meta::Utils::System::die("strange state");
}

sub exists($) {
	my($file)=@_;
	return(Meta::Utils::File::Path::exists(&search_path(),$file,":"));
}

sub direxists($) {
	my($dire)=@_;
	return(Meta::Utils::File::Path::exists_dir(&search_path(),$dire,":"));
}

sub which_nodie($) {
	my($file)=@_;
	return(Meta::Utils::File::Path::resolve_nodie(&search_path(),$file,":"));
}

sub which($) {
	my($file)=@_;
	return(Meta::Utils::File::Path::resolve(&search_path(),$file,":"));
}

sub which_f($) {
	my($file)=@_;
	if(substr($file,0,1) eq "/") {
		return($file);
	} else {
		return(which($file));
	}
}

sub which_dir($) {
	my($dire)=@_;
	return(Meta::Utils::File::Path::resolve_dir(&search_path(),$dire,":"));
}

sub search_path_object() {
	my($object)=Meta::Utils::File::Patho->new_data(search_path(),":");
	return($object);
}

sub search_path_list() {
	my(@arra)=split(':',search_path());
	return(\@arra);
}

sub search_path_hash() {
	my($list)=developer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

sub developer_list_list() {
	my(@arra)=split(' ',developer_list());
	return(\@arra);
}

sub developer_list_hash() {
	my($list)=developer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

sub reviewer_list_list() {
	my(@arra)=split(' ',reviewer_list());
	return(\@arra);
}

sub reviewer_list_hash() {
	my($list)=reviewer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

sub integrator_list_list() {
	my(@arra)=split(' ',integrator_list());
	return(\@arra);
}

sub integrator_list_hash() {
	my($list)=integrator_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

sub administrator_list_list() {
	my(@arra)=split(' ',administrator_list());
	return(\@arra);
}

sub administrator_list_hash() {
	my($list)=administrator_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

sub change_files_hash($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	my($resu)=which("aegi/repo/chan_files.rpt");
	my($pars)=Meta::Utils::Parse::Text->new();
	my(@args)=("aegis","-Report","-TERse","-File",$resu);
	$pars->init_proc(\@args);
	my($pref);
	if($abso) {
		$pref=work_dir()."/";
	}
	my(%hash);
	while(!$pars->get_over()) {
		my($line)=$pars->get_line();
		my(@fiel)=split(' ',$line);
		if($#fiel!=2) {
			die("what kind of line is [".$line."]");
		}
		my($usag)=$fiel[0];
		my($type)=$fiel[1];
		my($file)=$fiel[2];
		my($doit_usag);
		if($usag eq "source" && $srcx) {
			$doit_usag=1;
		} else {
			if($usag eq "test" && $test) {
				$doit_usag=1;
			} else {
				$doit_usag=0;
			}
		}
		my($doit_type);
		if($type eq "create" && $newx) {
			$doit_type=1;
		} else {
			if($type eq "modify" && $modi) {
				$doit_type=1;
			} else {
				if($type eq "remove" && $dele) {
					$doit_type=1;
				} else {
					$doit_type=0;
				}
			}
		}
		if($doit_usag && $doit_type) {
			if($abso) {
				$file=$pref.$file;
			}
			$hash{$file}=defined;
		}
		$pars->next();
	}
	$pars->fini();
	return(\%hash);
}

sub project_files_hash($$$) {
	my($srcx,$test,$abso)=@_;
	my($resu)=which("aegi/repo/proj_files.rpt");
	my($pars)=Meta::Utils::Parse::Text->new();
	my(@args)=("aegis","-Report","-TERse","-File",$resu);
	$pars->init_proc(\@args);
	my($pref);
	if($abso) {
		$pref=baseline()."/";
	}
	my(%hash);
	while(!$pars->get_over()) {
		my($line)=$pars->get_line();
		my(@fiel)=split(' ',$line);
		if($#fiel!=1) {
			Meta::Utils::System::die("what kind of line is [".$line."]");
		}
		my($doit);
		my($usag)=$fiel[0];
		my($file)=$fiel[1];
		if($usag eq "source" && $srcx) {
			$doit=1;
		} else {
			if($usag eq "test" && $test) {
				$doit=1;
			} else {
				$doit=0;
			}
		}
		if($doit) {
			if($abso) {
				$file=$pref.$file;
			}
			$hash{$file}=defined;
		}
		$pars->next();
	}
	$pars->fini();
	return(\%hash);
}

sub source_files_hash($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	my($basehash)=project_files_hash($srcx,$test,0);
	my($modihash)=change_files_hash(0,1,1,$srcx,$test,0);
	Meta::Utils::Hash::remove_hash($basehash,$modihash,1);
	my($chanhash)=change_files_hash($newx,$modi,$dele,$srcx,$test,0);
	if($abso) {
		$basehash=Meta::Utils::Hash::add_key_prefix($basehash,baseline()."/");
		$chanhash=Meta::Utils::Hash::add_key_prefix($chanhash,development_directory()."/");
	}
	Meta::Utils::Hash::add_hash($basehash,$chanhash);
	return($basehash);
}

sub base_files_hash($$) {
	my($dele,$abso)=@_;
	my($basehash)=project_files_hash(1,1,0);
	my($modihash)=change_files_hash(0,1,!$dele,1,1,0);
	Meta::Utils::Hash::remove_hash($basehash,$modihash,1);
	if($abso) {
		$basehash=Meta::Utils::Hash::add_key_prefix($basehash,baseline()."/");
	}
	return($basehash);
}

sub missing_files_hash() {
	my($hash)=change_files_hash(1,1,1,1,1,1);
	$hash=Meta::Utils::Hash::filter_notexists($hash);
	return($hash);
}

sub extra_files_hash($) {
	my($abso)=@_;
	my($full)=Meta::Utils::File::Collect::hash(work_dir(),$abso);
	my($hash)=change_files_hash(1,1,1,1,1,$abso);
	Meta::Utils::Hash::remove_hash($full,$hash,$abso);
	return($full);
}

sub total_files_hash($$) {
	my($dele,$abso)=@_;
	my($resuhash);
	if(deve()) {
		my($basehash)=Meta::Utils::File::Collect::hash(baseline(),0);
#		Meta::Utils::Output::print("base size is [".Meta::Utils::Hash::size($basehash)."]\n");
#	Meta::Utils::Output::print("modi size is [".Meta::Utils::Hash::size($modihash)."]\n");
#		Meta::Utils::Output::print("base size is [".Meta::Utils::Hash::size($basehash)."]\n");
		my($modihash)=change_files_hash(0,1,!$dele,1,1,0);
		Meta::Utils::Hash::remove_hash($basehash,$modihash,1);
		my($chanhash)=Meta::Utils::File::Collect::hash(work_dir(),0);
		my($delehash)=change_files_hash(0,0,!$dele,1,1,0);
		Meta::Utils::Hash::remove_hash($chanhash,$delehash,1);
		if($abso) {
			$basehash=Meta::Utils::Hash::add_key_prefix($basehash,baseline()."/");
			$chanhash=Meta::Utils::Hash::add_key_prefix($chanhash,development_directory()."/");
		}
		Meta::Utils::Hash::add_hash($basehash,$chanhash);
		$resuhash=$basehash;
	} else {
		$resuhash=Meta::Utils::File::Collect::hash(work_dir(),$abso);
	}
	return($resuhash);
}

sub change_files_list($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(change_files_hash($newx,$modi,$dele,$srcx,$test,$abso)));
}

sub project_files_list($$$) {
	my($srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(project_files_hash($srcx,$test,$abso)));
}

sub source_files_list($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(source_files_hash($newx,$modi,$dele,$srcx,$test,$abso)));
}

sub base_files_list($$) {
	my($dele,$abso)=@_;
	return(Meta::Utils::Hash::to_list(base_files_hash($dele,$abso)));
}

sub missing_files_list() {
	return(Meta::Utils::Hash::to_list(missing_files_hash()));
}

sub extra_files_list($) {
	my($abso)=@_;
	return(Meta::Utils::Hash::to_list(extra_files_hash($abso)));
}

sub total_files_list($$) {
	my($dele,$abso)=@_;
	return(Meta::Utils::Hash::to_list(total_files_hash($dele,$abso)));
}

sub no_missing_files($) {
	my($verb)=@_;
	my($list)=missing_files_list();
	if($verb) {
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),$list);
	}
	return(Meta::Utils::List::empty($list));
}

sub checkout_file($) {
	my($file)=@_;
	return(Meta::Utils::System::system_nodie("aegis",["-Copy_File",$file]));
}

sub checkout_hash($) {
	my($hash)=@_;
	my(@list)=keys(%$hash);
	my($size)=$#list+1;
	my($code);
	if($size>0) {
		$code=Meta::Utils::System::system_nodie("aegis",["-Copy_File",@list]);
	} else {
		$code=1;
	}
	return($code);
#	my($resu)=1;
#	while(my($keyx,$valx)=each(%$hash)) {
#		my($code)=Meta::Utils::System::system_nodie("aegis",["-Copy_File",$keyx]);
#		if(!$code) {
#			Meta::Utils::System::die("failed to checkout [".$keyx."]");
#			$resu=0;
#		}
#	}
#	return($resu);
}

sub in_change($) {
	my($file)=@_;
	my($hash)=&change_files_hash(1,1,0,1,1,0);
	if(exists($hash->{$file})) {
		return(1);
	} else {
		return(0);
	}
}

sub have_aegis() {
	my($patho)=Meta::Utils::File::Patho->new_path();
	return($patho->exists("aegis"));
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Baseline::Aegis - library to encapsulate aegis interface in perl scripts.

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

	MANIFEST: Aegis.pm
	PROJECT: meta
	VERSION: 0.48

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Aegis qw();
	my($change)=Meta::Baseline::Aegis::change();

=head1 DESCRIPTION

This is a perl library to serve as an interface to Aegis.
It provides a lot of helpful routines for all the scripts to make them
shorter and more understandable. It also encapsulates the way we talk
to aegis - you should only speak to aegis through this library and never
address aegis alone since the interface to aegis may change and we may
want to do some of the stuff (like getting the current change directory)
in a more efficient manner (like storing it in an environment variable).

The services here are divided into several categories:
0. variable substituion.
1. history services.
2. file lists.
3. performing operations (checkout etc...).

=head1 FUNCTIONS

	aesub($)
	aesub_file($)
	search_path()
	baseline()
	project()
	change()
	change_description()
	version()
	architecture()
	copyright_years()
	state()
	developer()
	developer_list()
	reviewer_list()
	integrator_list()
	administrator_list()
	development_directory()
	integration_directory()
	history_directory()
	deve()
	inte()
	work_dir()
	which_nodie($)
	which($)
	which_f($)
	which_dir($)
	search_path_object()
	search_path_list()
	search_path_hash()
	developer_list_list()
	developer_list_hash()
	reviewer_list_list()
	reviewer_list_hash()
	integrator_list_list()
	integrator_list_hash()
	administrator_list_list()
	administrator_list_hash()
	change_files_hash($$$$$$)
	project_files_hash($$$)
	source_files_hash($$$$$$)
	base_files_hash($$)
	missing_files_hash()
	extra_files_hash($)
	total_files_hash($$)
	change_files_list($$$$$$)
	project_files_list($$$)
	source_files_list($$$$$$)
	base_files_list($$)
	missing_files_list()
	extra_files_list($)
	total_files_list($$)
	no_missing_files($)
	checkout_file($)
	checkout_hash($)
	in_change($)
	have_aegis()
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<aesub($)>

This routine will substitute a string for you from aegis and give you the
string after substitution.
This is done using the aesub aegis routine.

=item B<aesub_file($)>

This method will get a file name and will run aesub on the content of the
file and return the content after substitution. This method uses the aesub
method.

=item B<search_path()>

This routine returns a list that is the search list for the current
This routine produces a string which is the correct search list as
far as aegis is concerned for source files in the current change or
branch. This could be fed into cook as the search_path, converted to
compiler include or link directives etc...

=item B<baseline()>

This routine gives you the baseline dir for your project.
Another implementation (thorough aegis) is the one used.
It could be implemented by the environment but that would be a bad
solution as it is not stable and depends on correct configuration of
the environment.

=item B<project()>

This routine returns the current project name.

=item B<change()>

This routine returns the current change name.

=item B<change_description()>

This routine returns the current change description.

=item B<version()>

This routine returns the current version name.

=item B<architecture()>

This routine returns the current architecture name.

=item B<copyright_years()>

This routine returns the copyright years attribute.

=item B<state()>

This routine returns the current state name.

=item B<developer()>

This routine returns the current developer name.

=item B<developer_list()>

This routine returns the current developer list.
This is implemented as aesub.

=item B<reviewer_list()>

This routine returns the current reviewer list.
This is implemented as aesub.

=item B<integrator_list()>

This routine returns the current integrator list.
This is implemented as aesub.

=item B<administrator_list()>

This routine returns the current administrator list.
This is implemented as aesub.

=item B<development_directory()>

This routine gives you the development directory for the current change.
This is only valid if the change is in the development stage.
This is implemented as aesub.

=item B<integration_directory()>

This routine gives you the integration directory for the current change.
This is only valid if the change is in the integration stage.
This is implemented as aesub.

=item B<history_directory()>

This routine gives you the history directory for the current project.
This is always valid. This is implemented as a call to aesub.

=item B<deve()>

Returns whether the change is in a development state.
This checks if the current changes state is "being_developed".

=item B<inte()>

Returns whether the change is in an integration state.
This checks if the current changes state is "being_integrated".

=item B<work_dir()>

Returns what I defined to be the work dir. This is the development directory
if the change is begin developed and the integration directory if the change
is being integrated.

=item B<exists($)>

This method returns true iff the file given exists in development.

=item B<direxists($)>

This method returns true iff the directory given to it exists in development.

=item B<which_nodie($)>

This routine does the same as the which routine and does not die if the file
is not found (just returns undef...).

=item B<which($)>

This tells you where a source is in the search_path.
The file could be in the development directory and up the branches up to the
baseline.
If the routine doenst find the file it dies.
It uses the "which_nodie" routine to do it's thing.

=item B<which_f($)>

This routine tells you the absolute name of a file in the project but allows
for the file to begin with a "/" (meaning allows it to be absolute already).
In that case, it just returns the file name.

=item B<which_dir($)>

This routine will give you the absolute path to a development directory.

=item B<search_path_object()>

This method will give you the Aegis search path as a search_path object.
See the Meta::Utils::File::Patho object documentation about using this
object.

=item B<search_path_list()>

This routine returns the search_path for perl purposes. I.e. - in a list where
every element is an element of the path.

=item B<search_path_hash()>

This routine does exactly as "search_path_list" but returns the results in
a hash. This uses "search_path_list" to get a list and converts it into a hash.

=item B<developer_list_list()>

This routine returns the list of developers in a perl list reference.

=item B<developer_list_hash()>

This routine returns the list of developers in a perl hash reference.

=item B<reviewer_list_list()>

This routine returns the list of reviewers in a perl list reference.

=item B<reviewer_list_hash()>

This routine returns the list of reviewers in a perl hash reference.

=item B<integrator_list_list()>

This routine returns the list of integrators in a perl list reference.

=item B<integrator_list_hash()>

This routine returns the list of integrators in a perl hash reference.

=item B<administrator_list_list()>

This routine returns the list of administrators in a perl list reference.

=item B<administrator_list_hash()>

This routine returns the list of administrators in a perl hash reference.

=item B<change_files_hash($$$$$$)>

This script gives out all the files in the current change with
no extra aegis information.
The idea is to use this in other scripts.
The best way to implement this is using aegis report and write
a special report to do this work.
another is using ael cf (aegis -List Change_Files).
yet another is aer Change_Files (this is the version that is implemented).
An even better way is if we could get a client C interface to aegis
from peter miller and hook to it directly from perl (or maybe a perl
interface ? could peter miller be this good ?).
The data for this routine are:
0. newx - do you want new files included ?
1. modi - do you want modified files included ?
2. dele - do you want deleted files included ?
3. srcx - do you want source files included ?
4. test - do you want test files included ?
5. abso - do you want absolute file names or relative in the output ?

=item B<project_files_hash($$$)>

List all the files in the current baseline project.

=item B<source_files_hash($$$$$$)>

List all the files viewed from the changes point of view
This is very useful for grepping etc...
There are two parameters: whether deleted files are wanted or not
and wheter absolute file names are wanted as a result.
There is a trick here - if absolute names are reuiqred (for example-as
collected by cook...:) then the aegis is consulted for the files which are
in the current change and a switcharoo on the prefix is performed...
This is because if we call our own routines with the absolute flag turned on
we wont be able to subtract the moved files from the baseline ones (they
will have different names...).
Aegis has such a report so maybe I should add an implementation which
uses it and then check out which performs better.

=item B<base_files_hash($$)>

This gives out all the files left in the baseline.

=item B<missing_files_hash()>

This routine gives out all the missing files for the current change.
It does so by using change_files 1 1 1 1 and filtering out
all the files which exist using Meta::Utils::Hash::filter_exist().

=item B<extra_files_hash($)>

This returns a hash with all the extra files (files which are not change
files) which are lying around in the directory.
The algorithm: collect all the files in the working directory and subtract
all the files which are in the change.

=item B<total_files_hash($$)>

This gives you all the files from the changes point of view (source+target).

=item B<change_files_list($$$$$$)>

This function is the same as change_files_hash but returns a list.

=item B<project_files_list($$$)>

This function is the same as project_files_hash but returns a list.

=item B<source_files_list($$$$$$)>

This function is the same as source_files_hash but returns a list.

=item B<base_files_list($$)>

This function is the same as base_files_hash but returns a list.

=item B<missing_files_list()>

This routine gives out all the missing files for the current change.
It does so by using change_files 1 1 1 1 and filtering out
all the files which exist using Meta::Utils::List::filter_exist().

=item B<extra_files_list($)>

This method is the same as extra_files_hash expect it returns a list.

=item B<total_files_list($$)>

This method is the same as total_files_hash expect it returns a list.

=item B<no_missing_files($)>

This routine returns a boolean according to whether there are or aren't any
missing files.

=item B<checkout_file($)>

This method will check out a single file.

=item B<checkout_hash($)>

This will receive a hash reference and will check out all the files in
the hash.

=item B<in_change($)>

This function recevies a file name and returns true iff the file is part
of the current change.

=item B<have_aegis()>

This function returns whether the current environment is an Aegis environment
or not. Currently it only checks whether aegis is in the path. This is bad.

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

	0.00 MV initial code brought in
	0.01 MV c++ and perl code quality checks
	0.02 MV make quality checks on perl code
	0.03 MV more perl checks
	0.04 MV make Meta::Utils::Opts object oriented
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV make all tests real tests
	0.08 MV more on tests/more checks to perl
	0.09 MV fix all tests change
	0.10 MV more on tests
	0.11 MV more perl quality
	0.12 MV make lilypond work
	0.13 MV correct die usage
	0.14 MV perl quality change
	0.15 MV perl code quality
	0.16 MV more perl quality
	0.17 MV chess and code quality
	0.18 MV more perl quality
	0.19 MV perl documentation
	0.20 MV more perl quality
	0.21 MV perl qulity code
	0.22 MV more perl code quality
	0.23 MV more perl quality
	0.24 MV revision change
	0.25 MV revision in files
	0.26 MV revision for perl files and better sanity checks
	0.27 MV languages.pl test online
	0.28 MV history change
	0.29 MV web site and docbook style sheets
	0.30 MV spelling and papers
	0.31 MV perl packaging
	0.32 MV more perl packaging
	0.33 MV perl packaging again
	0.34 MV PDMT
	0.35 MV tree type organization in databases
	0.36 MV md5 project
	0.37 MV database
	0.38 MV perl module versions in files
	0.39 MV movies and small fixes
	0.40 MV graph visualization
	0.41 MV md5 progress
	0.42 MV thumbnail user interface
	0.43 MV more thumbnail issues
	0.44 MV paper writing
	0.45 MV website construction
	0.46 MV web site automation
	0.47 MV SEE ALSO section fix
	0.48 MV web site development

=head1 SEE ALSO

Meta::Utils::File::Collect(3), Meta::Utils::File::File(3), Meta::Utils::File::Path(3), Meta::Utils::File::Patho(3), Meta::Utils::Hash(3), Meta::Utils::List(3), Meta::Utils::Output(3), Meta::Utils::Parse::Text(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-do some caching on the aegis information which we get using aesub (so we wont run aesub all the time...:)

-could we interface the aegis library directly so we wouldnt talk to aegis through executables ? (this is true for the aesub executable and the aegis executable so far...).

-add an interface to aefind here.

-add the aegis backup code here.
