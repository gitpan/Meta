#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Lang::Perl qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Ds::Enum qw();

my($enum)=Meta::Ds::Enum->new();
$enum->insert("change");
$enum->insert("project");
$enum->insert("source");

my($type);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_enum("type","what source files to take ?","change",\$type,$enum);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($list);
if($type eq "change") {
	$list=Meta::Baseline::Aegis::change_files_list(1,1,1,1,1,0);
}
if($type eq "project") {
	$list=Meta::Baseline::Aegis::project_files_list(1,1,0);
}
if($type eq "source") {
	$list=Meta::Baseline::Aegis::source_files_list(1,1,0,1,1,0);
}
for(my($i)=0;$i<=$#$list;$i++) {
	my($modu)=$list->[$i];
	if(Meta::Baseline::Lang::Perl->source_file($modu)) {
		Meta::Utils::Output::print("checking [".$modu."]...\n");
		my($srcx)=Meta::Baseline::Aegis::which($modu);
		my($path)=Meta::Baseline::Aegis::search_path();
		my($resu)=Meta::Baseline::Lang::Perl::check($modu,$srcx,$path);
		if($resu) {
			Meta::Utils::Output::print("ok\n");
		} else {
			Meta::Utils::Output::print("fail\n");
		}
	}
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

perl_check.pl - check all perl source files in the baseline.

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

	MANIFEST: perl_check.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	perl_check.pl [options]

=head1 DESCRIPTION

This script will quesry the source management system about which
sources are perl sources and will runa check on all of those files.

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

=item B<history> (type: bool, default: 0)

show history and exit

=item B<type> (type: enum, default: change)

what source files to take ?

options [change,project,source]

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

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Lang::Perl(3), Meta::Ds::Enum(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
