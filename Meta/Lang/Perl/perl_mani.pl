#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Development::Deps qw();
use Meta::Lang::Perl::Deps qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(1);
$opts->set_free_stri("[man1] [man2] [man3] [man4] [man5] [path] [deps...]");
$opts->set_free_mini(6);
$opts->set_free_noli(1);
$opts->analyze(\@ARGV);

my($mani_pl)=$ARGV[0];
my($mani_pm)=$ARGV[1];
my($mani_em)=$ARGV[2];
my($mani_im)=$ARGV[3];
my($mani_ch)=$ARGV[4];
my($path)=$ARGV[5];

my($grap)=Meta::Development::Deps->new();
for(my($i)=6;$i<=$#ARGV;$i++) {
	my($modu)=$ARGV[$i];
	Meta::Lang::Perl::Deps::add_deps($grap,$modu,1,1,$path);
}
open(MAPL,"> ".$mani_pl) || Meta::Utils::System::die("unable to open file [".$mani_pl."]");
open(MAPM,"> ".$mani_pm) || Meta::Utils::System::die("unable to open file [".$mani_pm."]");
open(MAEM,"> ".$mani_em) || Meta::Utils::System::die("unable to open file [".$mani_em."]");
open(MAIM,"> ".$mani_im) || Meta::Utils::System::die("unable to open file [".$mani_im."]");
open(MACH,"> ".$mani_ch) || Meta::Utils::System::die("unable to open file [".$mani_ch."]");
for(my($i)=0;$i<$grap->node_size();$i++) {
	my($curr)=$grap->nodes()->elem($i);
	if($curr=~/^perl\/bin\/Meta\/(.*)\.pl$/) {
		print MAPL $curr."\n";
	}
	if($curr=~/^(.*)\.pm$/) {
		print MAPM $curr."\n";
	}
	if($curr=~/^perl\/lib\/Meta\/(.*)\.pm$/) {
		print MAIM $curr."\n";
	}
	if($curr=~/^\/(.*)\.pm$/) {
		print MAEM $curr."\n";
	}
	print MACH $curr."\n";
}
print MACH "number of nodes: ".$grap->node_size()."\n";
print MACH "number of edges: ".$grap->edge_size()."\n";
close(MAPL) || Meta::Utils::System::die("unable to close file [".$mani_pl."]");
close(MAPM) || Meta::Utils::System::die("unable to close file [".$mani_pm."]");
close(MAEM) || Meta::Utils::System::die("unable to close file [".$mani_em."]");
close(MAIM) || Meta::Utils::System::die("unable to close file [".$mani_im."]");
close(MACH) || Meta::Utils::System::die("unable to close file [".$mani_ch."]");
Meta::Utils::System::exit(1);

__END__

=head1 NAME

perl_mani.pl - create perl manifests.

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

	MANIFEST: perl_mani.pl
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	perl_mani.pl [options]

=head1 DESCRIPTION

This program will receives lists of perl dep files and will create the
following manifests for you:
1. The .pl manifest - all .pl executables.
2. The .pm manifest - all .pm modules.
3. The epm manifest - all external .pm modules.
4. The ipm manifest - all internal .pm modules.
5. The ch manifest - stamp file for sanity checks and statistical about
	dependencies.

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

=back

minimum of [6] free arguments required
no maximum limit on number of free arguments placed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV put all tests in modules
	0.01 MV move tests to modules

=head1 SEE ALSO

Meta::Development::Deps(3), Meta::Lang::Perl::Deps(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
