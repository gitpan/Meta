#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Lang::Perl::Deps - module to help you handle perl dependency information.

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

MANIFEST: Deps.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Lang::Perl::Deps qw();>
C<my($object)=Meta::Lang::Perl::Deps->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module will help you extract, manipulate and print perl dependency
from actual perl source files.

=head1 EXPORTS

C<is_internal($)>
C<add_graph($)>
C<c2deps($)>
C<module_to_search_file($)>
C<module_to_file($)>
C<file_to_module($)>
C<module_to_deps($)>
C<extfile_to_module($)>
C<deps_to_module($)>
C<add_deps($$$$$)>
C<add_deps_rec($$$$$$)>

=cut

package Meta::Lang::Perl::Deps;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Development::Deps qw();
use Meta::Utils::Utils qw();
use Meta::Baseline::Aegis qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub is_internal($);
#sub add_graph($);
#sub c2deps($);
#sub module_to_search_file($);
#sub module_to_file($);
#sub file_to_module($);
#sub module_to_deps($);
#sub extfile_to_module($);
#sub deps_to_module($);
#sub add_deps($$$$$);
#sub add_deps_rec($$$$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<is_internal($)>

This method receives a module name from the DEPENDENCY files
and tells you if it is internal or not (by checking if it
is absolute or not).

=cut

sub is_internal($) {
	my($modu)=@_;
	if($modu=~/^\//) {
		return(0);
	} else {
		return(1);
	}
}

=item B<add_graph($$)>

This method will add the dependency information in a single perl
file (script or module) to a graph dependency object you give it.

=cut

sub add_graph($$) {
	my($buil,$grap)=@_;
	my($modu)=$buil->get_modu();
	my($srcx)=$buil->get_srcx();
	my($show_internal)=1;
	my($show_external)=1;
	my($path)=join(":",@INC);
	$grap->node_insert($modu);
	open(FILE,$srcx) || Meta::Utils::System::die("unable to open file [".$srcx."]");
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		if($line=~/^use .* qw\(.*\);$/) {
			my($cmod)=($line=~/^use (.*) qw\(.*\);$/);
			if($cmod=~/^Meta/) {#this is an internal file
				if($show_internal) {
					my($file)=module_to_file($cmod);
					$grap->node_insert($file);
					$grap->edge_insert($modu,$file);
				}
			} else {#this is an external file
				if($show_external) {
					my($search_file)=module_to_search_file($cmod);
					my($file)=Meta::Utils::File::Path::resolve($path,$search_file,":");
					$grap->node_insert($file);
					$grap->edge_insert($modu,$file);
				}
			}
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$srcx."]");
}

=item B<c2deps($)>

This method will extract a dependency graph from a perl source file.

=cut

sub c2deps($) {
	my($buil)=@_;
	my($grap)=Meta::Development::Deps->new();
	&add_graph($buil,$grap);
	return($grap);
}

=item B<module_to_search_file($)>
 
This will translate a module name to a module file to search for (without
the perl/lib prefix...

=cut

sub module_to_search_file($) {
	my($modu)=@_;
	$modu=~s/::/\//g;
	$modu.=".pm";
	return($modu);
}

=item B<module_to_file($)>
 
This will translate a module name to a baseline relative file name.

=cut

sub module_to_file($) {
	my($modu)=@_;
	$modu=~s/::/\//g;
	$modu="perl/lib/".$modu.".pm";
	return($modu);
}

=item B<file_to_module($)>

Convert a filename for a module to its perl notation (with ::).

=cut

sub file_to_module($) {
	my($file)=@_;
	$file=~s/\//::/g;
	my($resu)=($file=~/(.*)\.pm$/);
	return($resu);
}

=item B<module_to_deps($)>

This method receives a module name and returns the deps file that
holds the dependency information for it.

=cut

sub module_to_deps($) {
	my($modu)=@_;
	return("deps/".Meta::Utils::Utils::replace_suffix($modu,".deps"));
}

=item B<extfile_to_module($)>

Convert an expternal perl module filename perl module notation.

=cut

sub extfile_to_module($) {
	my($file)=@_;
	my($path)=join(':',@INC);
	my($remove)=Meta::Utils::File::Path::remove_path($path,':',$file);
	return(&file_to_module($remove));
}

=item B<deps_to_module($)>

This method does the reverse of module_to_deps. 

=cut

sub deps_to_module($) {
	my($deps)=@_;
	my($module)=($deps=~/deps\/(.*)\.deps$/);
	if($module eq "") {
		Meta::Utils::System::die("module is nothing from deps [".$deps."]");
	}
	my($suff);
	if($module=~/^perl\/bin/) {
		$suff=".pl";
	}
	if($module=~/^perl\/lib/) {
		$suff=".pm";
	}
	return($module.$suff);
}

=item B<deps_file_to_module($)>

This method recevies a deps file, and returns the module which it represents.

=cut

sub deps_file_to_module($) {
	my($file)=@_;
}

=item B<add_deps($$$$$)>

This method reads a dep file and adds it's information to a graph.

=cut

sub add_deps($$$$$) {
	my($grap,$modu,$inte,$exte,$path)=@_;
	$grap->node_insert($modu);
	my($fdep)=&module_to_deps($modu);
	my($deps)=Meta::Utils::File::Path::resolve($path,$fdep,":");
	open(FILE,$deps) || Meta::Utils::System::die("unable to open file [".$deps."]");
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
		if($line=~/^\/\*/) {#skip comment lines
			next;
		}
		if($line=~/^cascade .*=$/) {#read name of module and make sure it's the one we got
			my($node)=($line=~/^cascade (.*)=$/);
			if($node ne $modu) {
				Meta::Utils::System::die("node [".$node."] ne modu [".$modu."]");
			}
			next;
		}
		if($line eq ";") {#skip the end line
			next;
		}
		#otherwise - its an edge-find out if we want to add it
		my($addx);
		if(&is_internal($line)) {
			$addx=$inte;
		} else {
			$addx=$exte;
		}
		if($addx) {#this is the actual addition
			$grap->node_insert($line);
			$grap->edge_insert($modu,$line);
		}
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$deps."]");
}

=item B<add_deps_rec($$$$$$)>

This module will create a dep graph to describe the module
and all the modules that it depends on.

=cut

sub add_deps_rec($$$$$) {
	my($grap,$modu,$inte,$exte,$visi)=@_;
	$visi->{$modu}=defined;
	#Meta::Utils::Output::print("visiting [".$modu."]\n");
	my($path)=Meta::Baseline::Aegis::search_path();
	&add_deps($grap,$modu,$inte,$exte,$path);
	my($edge)=$grap->edge_ou($modu);
	for(my($i)=0;$i<$edge->size();$i++) {
		my($curr)=$edge->elem($i);
		#Meta::Utils::Output::print("curr is [".$curr."]\n");
		if(&is_internal($curr)) {
			if(!(exists($visi->{$curr}))) {
				add_deps_rec($grap,$curr,$inte,$exte,$visi);
			}
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

None.

=head1 SEE ALSO

Nothing.

=head1 TODO

-in the c2deps method check that the source configuration management tool knows about the files
	were adding.

=cut
