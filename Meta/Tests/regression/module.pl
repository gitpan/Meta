#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Development::TestInfo qw();

use Meta::Geo::Pos2d qw();
use Meta::Geo::Pos3d qw();
use Meta::Math::MinMax qw();
use Meta::Ds::Enumerated qw();
use Meta::Tool::Gcc qw();
use Meta::Archive::MyTar qw();
use Meta::Tool::Groff qw();
use Meta::Utils::Progname qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($test_config)="xmlx/configs/test.xml";
my($context)=Meta::Development::TestInfo->new();
$context->read_deve($test_config);

my($scod)=1;
my($code)=Meta::Geo::Pos2d::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Geo::Pos3d::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Math::MinMax::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Ds::Enumerated::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Tool::Gcc::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Archive::MyTar::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Tool::Groff::TEST($context);
if(!$code) {
	$scod=0;
}
my($code)=Meta::Utils::Progname::TEST($context);
if(!$code) {
	$scod=0;
}

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit($scod);

__END__

=head1 NAME

module.pl - run module tests.

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

	MANIFEST: module.pl
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	module.pl [options]

=head1 DESCRIPTION

This module will run all module internal tests.
The basic idea behind my testing is that each module has it's
own tests. This keeps the tests close to the code they are testing
which makes a lot of sense since when the API's change the code to
change is right there and the file which is checked out is also
the test that needs to be retun!

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

	0.00 MV import tests
	0.01 MV dbman package creation
	0.02 MV more thumbnail issues
	0.03 MV website construction
	0.04 MV improve the movie db xml
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Archive::MyTar(3), Meta::Baseline::Test(3), Meta::Development::TestInfo(3), Meta::Ds::Enumerated(3), Meta::Geo::Pos2d(3), Meta::Geo::Pos3d(3), Meta::Math::MinMax(3), Meta::Tool::Gcc(3), Meta::Tool::Groff(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Progname(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-allow to run all TEST methods for all modules.
	(with error or without error for each TEST method which is missing).

-allow to run all TEST for modules which are checked out.

-allow to run all TEST for modules which are checked out or are using modules which are checked out.
