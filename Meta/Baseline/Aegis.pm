#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Baseline::Aegis - library to encapsulate aegis interface in perl scripts.

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

MANIFEST: Aegis.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Baseline::Aegis qw();>
C<my($change)=Meta::Baseline::Aegis::change();>

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

=head1 EXPORTS

C<aesub($)>
C<aesub_file($)>
C<search_path()>
C<baseline()>
C<project()>
C<change()>
C<version()>
C<architecture()>
C<state()>
C<developer()>
C<developer_list()>
C<reviewer_list()>
C<integrator_list()>
C<administrator_list()>
C<development_directory()>
C<integration_directory()>
C<history()>
C<deve()>
C<inte()>
C<work_dir()>
C<which_nodie($)>
C<which($)>
C<which_f($)>
C<search_path_list()>
C<search_path_hash()>
C<developer_list_list()>
C<developer_list_hash()>
C<reviewer_list_list()>
C<reviewer_list_hash()>
C<integrator_list_list()>
C<integrator_list_hash()>
C<administrator_list_list()>
C<administrator_list_hash()>
C<change_files_hash($$$$$$)>
C<project_files_hash($$$)>
C<source_files_hash($$$$$$)>
C<base_files_hash($$)>
C<missing_files_hash()>
C<extra_files_hash($)>
C<total_files_hash($$)>
C<change_files_list($$$$$$)>
C<project_files_list($$$)>
C<source_files_list($$$$$$)>
C<base_files_list($$)>
C<missing_files_list()>
C<extra_files_list($)>
C<total_files_list($$)>
C<no_missing_files($)>
C<checkout_hash($)>

=cut

package Meta::Baseline::Aegis;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::List qw();
use Meta::Utils::Hash qw();
use Meta::Utils::File::Collect qw();
use Meta::Utils::File::File qw();
use Meta::Utils::System qw();
use Meta::Utils::Parse::Text qw();
use Meta::Utils::File::Path qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub aesub($);
#sub aesub_file($);

#sub search_path();
#sub baseline();
#sub project();
#sub change();
#sub version();
#sub architecture();
#sub state();
#sub developer();
#sub developer_list();
#sub reviewer_list();
#sub integrator_list();
#sub administrator_list();

#sub development_directory();
#sub integration_directory();
#sub history();

#sub deve();
#sub inte();

#sub work_dir();

#sub which_nodie($);
#sub which($);
#sub which_f($);

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

#sub checkout_hash($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<aesub($)>

This routine will substitute a string for you from aegis and give you the
string after substitution.
This is done using the aesub aegis routine.

=cut

sub aesub($) {
	my($stri)=@_;
	my($resu)=Meta::Utils::System::system_out_val("aesub",["'$stri'"]);
	chop($resu);
	return($resu);
}

=item B<aesub_file($)>

This method will get a file name and will run aesub on the content of the
file and return the content after substitution. This method uses the aesub
method.

=cut

sub aesub_file($) {
	my($file)=@_;
	my($text)=Meta::Utils::File::File::load($file);
	my($resu)=&aesub($text);
	return($resu);
}

=item B<search_path()>

This routine returns a list that is the search list for the current
This routine produces a string which is the correct search list as
far as aegis is concerned for source files in the current change or
branch. This could be fed into cook as the search_path, converted to
compiler include or link directives etc...

=cut

sub search_path() {
	return(&aesub("\$Search_Path"));
}

=item B<baseline()>

This routine gives you the baseline dir for your project.
Another implementation (thorough aegis) is the one used.
It could be implemented by the environment but that would be a bad
solution as it is not stable and depends on correct configuration of
the environment.

=cut

sub baseline() {
	return(&aesub("\$Baseline"));
}

=item B<project()>

This routine returns the current project name.

=cut

sub project() {
	return(&aesub("\$Project"));
}

=item B<change()>

This routine returns the current change name.

=cut

sub change() {
	return(&aesub("\$Change"));
}

=item B<version()>

This routine returns the current version name.

=cut

sub version() {
	return(&aesub("\$Version"));
}

=item B<architecture()>

This routine returns the current architecture name.

=cut

sub architecture() {
	return(&aesub("\$Architecture"));
}

=item B<state()>

This routine returns the current state name.

=cut

sub state() {
	return(&aesub("\$STate"));
}

=item B<developer()>

This routine returns the current developer name.

=cut

sub developer() {
	return(&aesub("\$Developer"));
}

=item B<developer_list()>

This routine returns the current developer list.
This is implemented as aesub.

=cut

sub developer_list() {
	return(&aesub("\$DEVeloper_List"));
}

=item B<reviewer_list()>

This routine returns the current reviewer list.
This is implemented as aesub.

=cut

sub reviewer_list() {
	return(&aesub("\$Reviewer_List"));
}

=item B<integrator_list()>

This routine returns the current integrator list.
This is implemented as aesub.

=cut

sub integrator_list() {
	return(&aesub("\$Integrator_List"));
}

=item B<administrator_list()>

This routine returns the current administrator list.
This is implemented as aesub.

=cut

sub administrator_list() {
	return(&aesub("\$Administrator_List"));
}

=item B<development_directory()>

This routine gives you the development directory for the current change.
This is only valid if the change is in the development stage.
This is implemented as aesub.

=cut

sub development_directory() {
	return(&aesub("\$Development_Directory"));
}

=item B<integration_directory()>

This routine gives you the integration directory for the current change.
This is only valid if the change is in the integration stage.
This is implemented as aesub.

=cut

sub integration_directory() {
	return(&aesub("\$Integration_Directory"));
}

=item B<history()>

This method will return the history directory for this project.

=cut

sub history() {
	return(baseline()."/../history");
}

=item B<deve()>

Returns whether the change is in a development state.
This checks if the current changes state is "being_developed".

=cut

sub deve() {
	if(state() eq "being_developed") {
		return(1);
	} else {
		return(0);
	}
}

=item B<inte()>

Returns whether the change is in an integration state.
This checks if the current changes state is "being_integrated".

=cut

sub inte() {
	if(state() eq "being_integrated") {
		return(1);
	} else {
		return(0);
	}
}

=item B<work_dir()>

Returns what I defined to be the work dir. This is the development directory
if the change is begin developed and the integration directory if the change
is being integrated.

=cut

sub work_dir() {
	if(deve()) {
		return(development_directory());
	}
	if(inte()) {
		return(integration_directory());
	}
	Meta::Utils::System::die("strange state");
}

=item B<which_nodie($)>

This routine does the same as the which routine and does not die if the file
is not found (just returns undef...).

=cut

sub which_nodie($) {
	my($file)=@_;
	return(Meta::Utils::File::Path::resolve_nodie(search_path(),$file,":"));
}

=item B<which($)>

This tells you where a source is in the search_path.
The file could be in the development directory and up the branches up to the
baseline.
If the routine doenst find the file it dies.
It uses the "which_nodie" routine to do it's thing.

=cut

sub which($) {
	my($file)=@_;
	return(Meta::Utils::File::Path::resolve(search_path(),$file,":"));
}

=item B<which_f($)>

This routine tells you the absolute name of a file in the project but allows
for the file to begin with a "/" (meaning allows it to be absolute already).
In that case, it just returns the file name.

=cut

sub which_f($) {
	my($file)=@_;
	if(substr($file,0,1) eq "/") {
		return($file);
	} else {
		return(which($file));
	}
}

=item B<search_path_list()>

This routine returns the search_path for perl purposes. I.e. - in a list where
every element is an element of the path.

=cut

sub search_path_list() {
	my(@arra)=split(':',search_path());
	return(\@arra);
}

=item B<search_path_hash()>

This routine does exactly as "search_path_list" but returns the results in
a hash. This uses "search_path_list" to get a list and converts it into a hash.

=cut

sub search_path_hash() {
	my($list)=developer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

=item B<developer_list_list()>

This routine returns the list of developers in a perl list reference.

=cut

sub developer_list_list() {
	my(@arra)=split(' ',developer_list());
	return(\@arra);
}

=item B<developer_list_hash()>

This routine returns the list of developers in a perl hash reference.

=cut

sub developer_list_hash() {
	my($list)=developer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

=item B<reviewer_list_list()>

This routine returns the list of reviewers in a perl list reference.

=cut

sub reviewer_list_list() {
	my(@arra)=split(' ',reviewer_list());
	return(\@arra);
}

=item B<reviewer_list_hash()>

This routine returns the list of reviewers in a perl hash reference.

=cut

sub reviewer_list_hash() {
	my($list)=reviewer_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

=item B<integrator_list_list()>

This routine returns the list of integrators in a perl list reference.

=cut

sub integrator_list_list() {
	my(@arra)=split(' ',integrator_list());
	return(\@arra);
}

=item B<integrator_list_hash()>

This routine returns the list of integrators in a perl hash reference.

=cut

sub integrator_list_hash() {
	my($list)=integrator_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

=item B<administrator_list_list()>

This routine returns the list of administrators in a perl list reference.

=cut

sub administrator_list_list() {
	my(@arra)=split(' ',administrator_list());
	return(\@arra);
}

=item B<administrator_list_hash()>

This routine returns the list of administrators in a perl hash reference.

=cut

sub administrator_list_hash() {
	my($list)=administrator_list_list();
	my($hash)=Meta::Utils::List::to_hash($list);
	return($hash);
}

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

=cut

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

=item B<project_files_hash($$$)>

List all the files in the current baseline project.

=cut

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

=cut

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

=item B<base_files_hash($$)>

This gives out all the files left in the baseline.

=cut

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

=item B<missing_files_hash()>

This routine gives out all the missing files for the current change.
It does so by using change_files 1 1 1 1 and filtering out
all the files which exist using Meta::Utils::Hash::filter_exist().

=cut

sub missing_files_hash() {
	my($hash)=change_files_hash(1,1,1,1,1,1);
	$hash=Meta::Utils::Hash::filter_notexists($hash);
	return($hash);
}

=item B<extra_files_hash($)>

This returns a hash with all the extra files (files which are not change
files) which are lying around in the directory.
The algorithm: collect all the files in the working directory and subtract
all the files which are in the change.

=cut

sub extra_files_hash($) {
	my($abso)=@_;
	my($full)=Meta::Utils::File::Collect::hash(work_dir(),$abso);
	my($hash)=change_files_hash(1,1,1,1,1,$abso);
	Meta::Utils::Hash::remove_hash($full,$hash,$abso);
	return($full);
}

=item B<total_files_hash($$)>

This gives you all the files from the changes point of view (source+target).

=cut

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

=item B<change_files_list($$$$$$)>

This function is the same as change_files_hash but returns a list.

=cut

sub change_files_list($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(change_files_hash($newx,$modi,$dele,$srcx,$test,$abso)));
}

=item B<project_files_list($$$)>

This function is the same as project_files_hash but returns a list.

=cut

sub project_files_list($$$) {
	my($srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(project_files_hash($srcx,$test,$abso)));
}

=item B<source_files_list($$$$$$)>

This function is the same as source_files_hash but returns a list.

=cut

sub source_files_list($$$$$$) {
	my($newx,$modi,$dele,$srcx,$test,$abso)=@_;
	return(Meta::Utils::Hash::to_list(source_files_hash($newx,$modi,$dele,$srcx,$test,$abso)));
}

=item B<base_files_list($$)>

This function is the same as base_files_hash but returns a list.

=cut

sub base_files_list($$) {
	my($dele,$abso)=@_;
	return(Meta::Utils::Hash::to_list(base_files_hash($dele,$abso)));
}

=item B<missing_files_list()>

This routine gives out all the missing files for the current change.
It does so by using change_files 1 1 1 1 and filtering out
all the files which exist using Meta::Utils::List::filter_exist().

=cut

sub missing_files_list() {
	return(Meta::Utils::Hash::to_list(missing_files_hash()));
}

=item B<extra_files_list($)>

This method is the same as extra_files_hash expect it returns a list.

=cut

sub extra_files_list($) {
	my($abso)=@_;
	return(Meta::Utils::Hash::to_list(extra_files_hash($abso)));
}

=item B<total_files_list($$)>

This method is the same as total_files_hash expect it returns a list.

=cut

sub total_files_list($$) {
	my($dele,$abso)=@_;
	return(Meta::Utils::Hash::to_list(total_files_hash($dele,$abso)));
}

=item B<no_missing_files($)>

This routine returns a boolean according to whether there are or aren't any
missing files.

=cut

sub no_missing_files($) {
	my($verb)=@_;
	my($list)=missing_files_list();
	if($verb) {
		Meta::Utils::List::print(Meta::Utils::Output::get_file(),$list);
	}
	return(Meta::Utils::List::empty($list));
}

=item B<checkout_hash($)>

This will receive a hash reference and will check out all the files in
the hash.

=cut

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

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-do some caching on the aegis information which we get using aesub (so we wont run aesub all the time...:)

-could we interface the aegis library directly so we wouldnt talk to aegis through executables ? (this is true for the aesub executable and the aegis executable so far...).

-add an interface to aefind here.

-add the aegis backup code here.

=cut
