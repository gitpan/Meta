#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Aegis qw();
use XML::Writer qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($writer)=XML::Writer->new(DATA_MODE=>1,DATA_INDENT=>8);
$writer->startTag("modules");
my($list)=Meta::Baseline::Aegis::source_files_list(1,1,0,1,0,0);
for(my($i)=0;$i<=$#$list;$i++) {
	my($curr)=$list->[$i];
	if($curr=~/\.pm$/) {
		$writer->startTag("module");
		$writer->dataElement("source",$curr);
		$writer->endTag("module");
	}
}
$writer->endTag("modules");

Meta::Utils::System::exit(1);

__END__

=head1 NAME

perl_pkglist.pl - get an XML list of all perl packages.

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

	MANIFEST: perl_pkglist.pl
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	perl_pkglist.pl [options]

=head1 DESCRIPTION

Put your programs description here.

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

no free arguments are allowed

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

Meta::Baseline::Aegis(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), XML::Writer(3), strict(3)

=head1 TODO

-add option to only get a list of packages to span all needed packages (graph algorithm).

-add option to filter through a regexp.
