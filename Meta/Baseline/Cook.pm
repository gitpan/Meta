#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Baseline::Cook - library to give out cook related information to perl scripts.

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

MANIFEST: Cook.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Baseline::Cook qw();>
C<my($cook)=Meta::Baseline::Cook->new();>
C<$cook->exec_build([params]);>

=head1 DESCRIPTION

This library is intended to supply all demanders (i.e. Peter Miller's cook,
other scripts or any other inquirer) any information regarding cook related
parameters in the project. In addition this library knows how to do cook
related stuff (write and read dependencies in cook format...).

=head1 EXPORTS

C<new($)>
C<search_list($)>
C<inte($)>
C<deve($)>
C<temp_dir($)>
C<touch($$$$$)>
C<touch_now($$$$)>
C<exec_development_build($$$$)>
C<exec_build($$$)>
C<print_deps_handle($$)>
C<print_deps($$)>
C<read_deps($$$)>
C<read_deps_full($)>

=cut

package Meta::Baseline::Cook;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Time qw();
use Meta::Utils::Options qw();
use Meta::Utils::File::Touch qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::Purge qw();
use File::Basename qw();
use DB_File qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Utils qw();
use Meta::Development::Deps qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);

#sub search_list($);
#sub inte($);
#sub deve($);

#sub temp_dir($);

#sub touch($$$$$);
#sub touch_now($$$$);

#sub exec_development_build($$$$);
#sub exec_build($$$);

#sub print_deps_handle($$);
#sub print_deps($$);

#sub read_deps($$$);
#sub read_deps_full($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new cook object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	my($opts)=Meta::Utils::Options->new();
	my($cook_opts)=Meta::Baseline::Aegis::which("data/baseline/cook/opts.txt");
	$opts->read($cook_opts);
	$self->{OPTS}=$opts;
	return($self);
}

=item B<search_list($)>

This returns the search_list variable in cook format (space separated...).

=cut

sub search_list($) {
	my($self)=@_;
	my($list)=Meta::Baseline::Aegis::search_path_list();
	return(join(" ",@$list));
}

=item B<inte($)>

This returns 0 or 1 accroding to whether this is an integration state.

=cut

sub inte($) {
	my($self)=@_;
	return(Meta::Baseline::Aegis::inte());
}

=item B<deve($)>

This returns 0 or 1 accroding to whether this is a development state.

=cut

sub deve($) {
	my($self)=@_;
	return(Meta::Baseline::Aegis::deve());
}

=item B<temp_dir($)>

This will return a temp directory to hold cook junk files.
(lists, temporary files, etc...).

=cut

sub temp_dir($) {
	my($self)=@_;
	return($self->{OPTS}->get("base_cook_temp"));
}


=item B<touch($$$$$)>

This routine receives file to touch,epoch date and a verbose variable.
It check if the the directory in which the file resides has a ".cook.fp"
file in it. If so, it checks if the file name is in the ".cook.fp" file.
If so, it chages the file's date (in epoch seconds) to the epoch date received
from whatever was in there.
In either case it uses the regular mechanism and touches the file using the
epoch received.
The overall effect is that cook will be aware that the file has indeed changed.

=cut

sub touch($$$$$) {
	my($self,$file,$time,$demo,$verb)=@_;
	if($verb) {
		Meta::Utils::Output::print("doing file [".$file."]\n");
	}
	my($name,$path,$suff)=File::Basename::fileparse($file);
	$name=~s/(\W)/\\$1/g;
	my($fp)=$path.".cook.fp";
	my($stat)="bad stat";
	if(-e $fp) {
		my(@arra);
		tie(@arra,"DB_File",$fp,DB_File::O_RDWR,0666,$DB_File::DB_RECNO) or Meta::Utils::System::die("cannot tie [".$file."]");
		my($foun)=0;
		for(my($i)=0;($i<=$#arra) && (!$foun);$i++) {
			my($line)=$arra[$i];
			if($line=~"\"$name\"") {
				$arra[$i]="\"$name\"={ $time";
				$foun=1;
			}
		}
		if($foun) {
			$stat=".cook.fp changed";
		} else {
			$stat=".cook.fp didnt contain file";
		}
		untie(@arra) || Meta::Utils::System::die("cannot untie [".$file."]");
	} else {
		$stat=".cook.fp not found";
	}
	if($verb) {
		Meta::Utils::Output::print("result: [".$stat."]\n");
	}
	return(Meta::Utils::File::Touch::date($file,$time,$demo,$verb));
}

=item B<touch_now($$$$)>

This routine receives a file, a demo flag and a verbose flag.
The routine finds the current time using Meta::Utils::Time::now_epoch
and then calls touch from this module to change the cook time to the
current time.

=cut

sub touch_now($$$$) {
	my($self,$file,$demo,$verb)=@_;
	my($time)=Meta::Utils::Time::now_epoch();
	return($self->touch($file,$time,$demo,$verb));
}

=item B<exec_development_build($$$$)>

This routine executes a development build.
It receives a list of arguments as the partial build targets and executes
cook. The routine returns the status from cook on exit.

=cut

sub exec_development_build($$$$) {
	my($self,$demo,$verb,$arra)=@_;

	if($demo) {
		return(1);
	}

	my($ctim)=Meta::Utils::Time::now_string();

	my($base_list)=$self->temp_dir()."/".$ctim.".list";
	my($base_book)=Meta::Baseline::Aegis::which("cook/main.cook");

	my($base_cook_search_path)=Meta::Baseline::Aegis::search_path();
	my($base_cook_baseline)=Meta::Baseline::Aegis::baseline();
	my($base_cook_project)=Meta::Baseline::Aegis::project();
	my($base_cook_change)=Meta::Baseline::Aegis::change();
	my($base_cook_version)=Meta::Baseline::Aegis::version();
	my($base_cook_architecture)=Meta::Baseline::Aegis::architecture();
	my($base_cook_state)=Meta::Baseline::Aegis::state();
	my($base_cook_developer)=Meta::Baseline::Aegis::developer();
	my($base_cook_developer_list)=Meta::Baseline::Aegis::developer_list();
	my($base_cook_reviewer_list)=Meta::Baseline::Aegis::reviewer_list();
	my($base_cook_integrator_list)=Meta::Baseline::Aegis::integrator_list();
	my($base_cook_administrator_list)=Meta::Baseline::Aegis::administrator_list();

	my($base_cook_search_list)=$self->search_list();
	my($base_cook_inte)=$self->inte();
	my($base_cook_deve)=$self->deve();

	my(@args)=
	(
		"-Book",$base_book,

		"base_cook_search_path=$base_cook_search_path",
		"base_cook_baseline=$base_cook_baseline",
		"base_cook_project=$base_cook_project",
		"base_cook_change=$base_cook_change",
		"base_cook_version=$base_cook_state",
		"base_cook_architecture=$base_cook_architecture",
		"base_cook_state=$base_cook_state",
		"base_cook_developer=$base_cook_developer",
		"base_cook_developer_list=$base_cook_developer_list",
		"base_cook_reviewer_list=$base_cook_reviewer_list",
		"base_cook_integrator_list=$base_cook_integrator_list",
		"base_cook_administrator_list=$base_cook_administrator_list",

		"base_cook_search_list=$base_cook_search_list",
		"base_cook_inte=$base_cook_inte",
		"base_cook_deve=$base_cook_deve",
	);

	my($opts)=$self->{OPTS};
	my($size)=$opts->size();
	for(my($i)=0;$i<$size;$i++) {
		my($keyx)=$opts->keyx($i);
		my($valx)=$opts->valx($i);
		push(@args,$keyx."=".$valx);
	}

	my($base_cook_list)=$opts->get("base_cook_list");
	if($base_cook_list) {
		push(@args,"-List",$base_list);
	} else {
		push(@args,"-No_List");
	}

	my($base_cook_webx)=$opts->get("base_cook_webx");
	if($base_cook_webx) {
		push(@args,"-Web");
	} else {
		#there is no such flag (-No_Web)
		#it's enough that we don't put "-Web"
		#push(@args,"-No_Web");
	}

	push(@args,@$arra);
	if($verb) {
		Meta::Utils::Output::print("activating cook with [".join(',',@args)."]\n");
	}
	my($scod);
	if(!$demo) {
		$scod=Meta::Utils::System::system_nodie("cook",\@args);
	} else {
		$scod=1;
	}
	return($scod);
}

=item B<exec_build($$$)>

This command executes an integration build.
This is the reason why the command does not receive any arguments since
partial builds in integration time are not allowed.
This just calls exec_development_build with no partial targets.
This returns the correct state output.
This routine receives a demo flag of whether to run as demo or not.

=cut

sub exec_build($$$) {
	my($self,$demo,$verb)=@_;
	my(@arra);
	my($scod)=$self->exec_development_build($demo,$verb,\@arra);
	if($scod) {
		if(!$demo) {
			my($dire)=Meta::Baseline::Aegis::integration_directory();
			$scod=Meta::Utils::File::Purge::purge($dire,0,0,undef);
		}
	}
	return($scod);
}

=item B<print_deps_handle($$)>

This method gets a dependency object and prints it out in cook style.
A dependency object is just a graph so what it needed here is the following:
pass over every node (in whatever order) and for each node find edges to other
nodes and emit the "cascase" type statements for cook. If the node does not
have any adjacents - no need to emit anything!!! right ?

=cut

sub print_deps_handle($$) {
	my($deps,$file)=@_;
	#put a nice emblem to begin the file
	Meta::Baseline::Utils::cook_emblem_print($file);
	# iterate over the nodes
	for(my($i)=0;$i<$deps->node_size();$i++) {
		my($node)=$deps->nodes()->elem($i);
		my($out_edges)=$deps->edge_ou($node);
		# only if there are dependencies
		if($out_edges->size()>0) {
			print $file "cascade ".$node."=\n";
			for(my($j)=0;$j<$out_edges->size();$j++) {
				my($edge)=$out_edges->elem($j);
				print $file $edge."\n";
			}
			print $file ";\n";
		}
	}
	return(1);
}

=item B<print_deps($$)>

This method is exactly as print_deps_handle except it also opens and closes
a file.

=cut

sub print_deps($$) {
	my($deps,$targ)=@_;
	open(FILE,"> ".$targ) || Meta::Utils::System::die("unable to open file [".$targ."]");
	&print_deps_handle($deps,*FILE);
	close(FILE) || Meta::Utils::System::die("unable to close file [".$targ."]");
	return(1);
}

=item B<read_deps($$$)>

This method receives a baseline related file name and assumes that its a cook
dependency file written by the above print_deps methods. It adds the dependency
information it finds in the file to the graph it gets also as input. It also
receives a parameters telling it whether to be recursive or not.

=cut

sub read_deps($$$) {
	my($deps,$file,$recu)=@_;
	#Meta::Utils::Output::print("file is [".$file."]\n");
	my($f_name,$f_path,$f_suff)=File::Basename::fileparse($file,'\..*');
	my($exte)="deps/".$f_path.$f_name.".deps";
	#Meta::Utils::Output::print("trying [".$exte."]\n");
	my($full)=Meta::Baseline::Aegis::which_nodie($exte);
	if(defined($full)) {
		my(@list);
		open(FILE,$full) || Meta::Utils::System::die("unable to open file [".$full."]");
		# read the first comment line.
		my($line);
		$line=<FILE>;
		# if we have dep information
		if($line=<FILE> || 0) {
			chop($line);
			my($new)=($line=~/^cascade (.*)=$/);
			#Meta::Utils::Output::print("inserting node [".$new."]\n");
			$deps->node_insert($new);
			while($line=<FILE> || 0) {
				chop($line);
				if($line ne ";") {
					if(!$deps->node_has($line)) {
						push(@list,$line);
					}
					$deps->node_insert($line);
					#Meta::Utils::Output::print("inserting node [".$line."]\n");
					$deps->edge_insert($new,$line);
					#Meta::Utils::Output::print("inserting edge [".$new.",".$line."]\n");
				}
			}
		}
		close(FILE) || Meta::Utils::System::die("unable to close file [".$full."]");
		if($recu) {
			for(my($i)=0;$i<=$#list;$i++) {
				read_deps($deps,$list[$i],$recu);
			}
		}
	} else {
		$deps->node_insert($file);
	}
}

=item B<read_deps_full($)>

This method is just convenience wrapper around the read_deps method. It generates
the graph that will be used to hold the dependency information. It also returns
that graph at the end.

=cut

sub read_deps_full($) {
	my($file)=@_;
	my($graph)=Meta::Development::Deps->new();
	read_deps($graph,$file,1);
	return($graph);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
3	Fri Jan  5 09:09:46 2001	MV	adding an XML viewer/editor to work with the baseline
4	Fri Jan  5 09:26:25 2001	MV	code sanity
5	Sat Jan  6 02:40:51 2001	MV	Another change
6	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
7	Sat Jan  6 17:14:09 2001	MV	more perl checks
8	Sun Jan  7 18:17:29 2001	MV	make Meta::Utils::Opts object oriented
9	Sun Jan  7 20:46:54 2001	MV	more harsh checks on perl code
10	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
11	Tue Jan  9 18:20:08 2001	MV	differentiate between deps and udep in perl
12	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
13	Tue Jan  9 20:08:10 2001	MV	handle C++ dependencies better
14	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
15	Wed Jan 10 18:31:05 2001	MV	more perl code quality
15	Thu Jan 11 12:42:37 2001	MV	put ALL tests back and light the tree
16	Fri Jan 12 11:36:41 2001	MV	fix up the cook module
17	Fri Jan 12 15:53:19 2001	MV	change new methods to have prototypes
18	Fri Jan 12 18:25:02 2001	MV	cook.pm to automatically pass options down to the cook level
19	Thu Jan 18 15:59:13 2001	MV	correct die usage
20	Sat Jan 27 19:56:28 2001	MV	perl quality change
21	Sun Jan 28 02:34:56 2001	MV	perl code quality
22	Sun Jan 28 13:51:26 2001	MV	more perl quality
23	Mon Jan 29 20:54:18 2001	MV	chess and code quality
23	Tue Jan 30 03:03:17 2001	MV	more perl quality
24	Sat Feb  3 23:41:08 2001	MV	perl documentation
25	Mon Feb  5 03:21:02 2001	MV	more perl quality
26	Tue Feb  6 01:04:52 2001	MV	perl qulity code
27	Tue Feb  6 07:02:13 2001	MV	more perl code quality
28	Tue Feb  6 08:47:46 2001	MV	more perl quality
29	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-unite all the init routines into init and make that code run on usage (in the BEGIN block of the module...).

-In the init routine: Get names of architectures. Get names of machines. Get names of languages supported.

-split the unix_path routine to fixpath and fixline where the difference is that the first matches a single match at the begining and the later matches many matches anywhere.

-remove the unix_path routine from this module once we fix the amd maps.

-add more functionality here like auto script making for auto mounting on the NT machines, distinguishing between Watcom and Visual C++ etc... (machines that give out services that is...).

-maybe when we give a list of machines to cook we should double the name of the current host or something to refelect the fact that he's faster ? check with peter... Maybe we should double the name of the host on which the change resides locally ?

-make is_plat not do that ugly "|| $plat eq "scr"" stuff.

=cut
