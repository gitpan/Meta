#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();
use Meta::Pdmt::Graph qw();
use Meta::Pdmt::FileNode qw();

my($verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",1,\$verb);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($graph)=Meta::Pdmt::Graph->new();
if($verb) {
	Meta::Utils::Output::print("reading sources from SCCS\n");
}
my($list)=Meta::Baseline::Aegis::source_files_list(1,1,0,1,1,0);
for(my($i)=0;$i<=$#$list;$i++) {
	my($curr)=$list->[$i];
	my($node)=Meta::Pdmt::FileNode->new();
	$node->set_name($curr);
	$node->set_path($curr);
	$node->set_rule(\&print);
	$graph->add_vertex($node);
#	if($curr=~/*\.temp$/) {
#		my($suffix)=get_suffix($curr);
#		my($dire)=suffix_to_directory($suffix);
#		my($new)=$dire."/".remove_suffix($curr).".".$
#	}
}
Meta::Utils::Output::print("graph has [".$graph->vertices_num()."] nodes\n");
Meta::Utils::Output::print("graph has [".$graph->edges_num()."] edges\n");
#$graph->build();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

pdmt.pl - run the Pdmt system.

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

	MANIFEST: pdmt.pl
	PROJECT: meta
	VERSION: 0.11

=head1 SYNOPSIS

	pdmt.pl [options]

=head1 DESCRIPTION

This program runs a Pdmt server.
This program will:
0. read sources from your source control management system.
1. build the graph.
2. stat the files involved and get a grip on reality.
3. optionally run a build to build targets that you specify.
4. optionally run a server to listen to incoming messages
	which could be:
	0. hey - I just edited this file.
	1. could you please build this target "foo".
	2. could you please build all targets.
	3. I just removed file "foo" from the source management system.
	4. can you tell me if it's ok to remove file "foo" from source
		management ?
	5. could you please show me the damn graph so I could debug it ?
	6. could you please dump the graph to XML format so I could analyze
		it using something...
	7. could you please kill yourself ? 

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<description> (type: bool, default: 0)

show description and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<verbose> (type: bool, default: 1)

noisy or quiet ?

=back

no free arguments are allowed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging again
	0.01 MV license issues
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix
	0.11 MV move tests to modules

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Pdmt::FileNode(3), Meta::Pdmt::Graph(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
