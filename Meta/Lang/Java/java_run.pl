#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(1);
$opts->set_free_stri("[class]");
$opts->set_free_mini(1);
$opts->set_free_maxi(1);
$opts->analyze(\@ARGV);

my($class)=($ARGV[0]);
if($class=~/\.class$/) {
	$class=Meta::Baseline::Aegis::which($class);
	$class=~s/\//\./g;
	($class)=($class=~/^.*\.java\.lib\.(.*)\.class$/);
}
#Meta::Utils::Output::print("running [".$class."]\n");
my($scod)=Meta::Utils::System::system_nodie("java",[$class]);
Meta::Utils::System::exit($scod);

__END__

=head1 NAME

java_run.pl - run a Java program in base fashion.

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

	MANIFEST: java_run.pl
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	java_run.pl

=head1 DESCRIPTION

This is base's way of running java (.class files).
This should reflect the best virtual machine that we can get our hands
on...

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

minimum of [1] free arguments required
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
	0.02 MV md5 issues

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-get the code here into the Java.pm module.

-get the code here more clean (separate into run class file and run class
	which are different things).
