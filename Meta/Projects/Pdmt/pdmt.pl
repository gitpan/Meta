#!/usr/bin/env perl

=head1 NAME

pdmt.pl - run the Pdmt system.

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

MANIFEST: pdmt.pl
PROJECT: meta

=head1 SYNOPSIS

C<pdmt.pl [options]>

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

None.

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

None.

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Aegis qw();
use Meta::Pdmt::Graph qw();
use Meta::Utils::Output qw();
use Meta::Utils::Utils qw();
use Meta::Baseline::Lang::Sgml qw();

my($verb);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_desc("run the Pdmt system");
$opts->set_auth("mark");
$opts->set_lice("GPL");
$opts->def_bool("verbose","noisy or quiet ?",1,\$verb);
$opts->set_standard();
$opts->set_free_allo(0);
$opts->anal(\@ARGV);

my($grap)=Meta::Pdmt::Graph->new();
if($verb) {
	Meta::Utils::Output::print("reading sources from SCCS\n");
}
my($list)=Meta::Baseline::Aegis::source_files_list(1,1,0,1,1,0);
$grap->node_insert("all","tag");
for(my($i)=0;$i<=$#$list;$i++) {
	my($curr)=$list->[$i];
	if($curr=~/\.docb/) {
		if($verb) {
			Meta::Utils::Output::print("doing [".$curr."]\n");
		}
		$grap->node_insert($curr,"file");
		my($psxx)=Meta::Utils::Utils::replace_suffix($curr,"ps");
		$grap->node_insert($psxx,"file");
		$grap->edge_insert($psxx,$curr,\&Meta::Baseline::Lang::Sgml::c2psxx);
		$grap->edge_insert("all",$psxx,"stam");
	}
}
Meta::Utils::Output::print("graph has [".$grap->node_size()."] nodes\n");
Meta::Utils::Output::print("graph has [".$grap->edge_size()."] edges\n");
$grap->build(["all"]);

Meta::Utils::System::sexo(1);
