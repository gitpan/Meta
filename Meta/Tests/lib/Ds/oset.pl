#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Ds::Oset qw();
use Meta::Utils::Output qw();
use Meta::Ds::String qw();
use Meta::Utils::String qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($setx)=Meta::Ds::Oset->new();
my($string_mark)=Meta::Ds::String->new_stri("mark");
my($string_velt)=Meta::Ds::String->new_stri("velt");
my($string_abra)=Meta::Ds::String->new_stri("abra");
$setx->insert($string_mark);
$setx->insert($string_velt);
$setx->insert($string_abra);
$setx->sort(\&Meta::Ds::String::cmp);
$setx->print(Meta::Utils::Output::get_file());

my($setx)=Meta::Ds::Oset->new();
$setx->insert("mark");
$setx->insert("velt");
$setx->insert("abra");
$setx->sort(\&Meta::Utils::String::compare);
for(my($i)=0;$i<$setx->size();$i++) {
	my($curr)=$setx->elem($i);
	Meta::Utils::Output::print($curr."\n");
}

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

oset.pl - testing program for the Meta::Ds::Oset.pm module.

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

	MANIFEST: oset.pl
	PROJECT: meta
	VERSION: 0.13

=head1 SYNOPSIS

	oset.pl

=head1 DESCRIPTION

This is a testing program for the Meta::Ds::Oset.pm module.
currently it just constructs a Oset object and prints it out.

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

	0.00 MV get basic Simul up and running
	0.01 MV revision change
	0.02 MV languages.pl test online
	0.03 MV perl packaging
	0.04 MV license issues
	0.05 MV md5 project
	0.06 MV database
	0.07 MV perl module versions in files
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues
	0.10 MV website construction
	0.11 MV improve the movie db xml
	0.12 MV web site automation
	0.13 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Ds::Oset(3), Meta::Ds::String(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::String(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
