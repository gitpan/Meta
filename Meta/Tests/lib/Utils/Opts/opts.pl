#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Ds::Enum qw();
use Meta::Ds::Set qw();
use Meta::Utils::Output qw();

my($bool,$inte,$stri,$floa,$dire,$file,$dbtype);
my($enum)=Meta::Ds::Enum->new();
$enum->insert("mysql");
$enum->insert("oracle");
$enum->insert("postgres");
$enum->insert("informix");
my($set)=Meta::Ds::Set->new();
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("bool","just a bool",1,\$bool);
$opts->def_inte("inte","just an int",7,\$inte);
$opts->def_stri("stri","just a string","mark",\$stri);
$opts->def_floa("floa","just a float",3.14,\$floa);
$opts->def_dire("dire","just a directory",".",\$dire);
$opts->def_file("file","just a file","/etc/passwd",\$file);
$opts->def_enum("dbtype","what database type do you want ?","mysql",\$dbtype,$enum);
$opts->def_setx("flist","list of files","one,two",\$set,$enum);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

Meta::Utils::Output::print("bool is [".$bool."]\n");
Meta::Utils::Output::print("inte is [".$inte."]\n");
Meta::Utils::Output::print("stri is [".$stri."]\n");
Meta::Utils::Output::print("floa is [".$floa."]\n");
Meta::Utils::Output::print("dire is [".$dire."]\n");
Meta::Utils::Output::print("file is [".$file."]\n");
Meta::Utils::Output::print("dbtype is [".$dbtype."]\n");
Meta::Utils::Output::print("list is [");
$set->print(Meta::Utils::Output::get_file());
Meta::Utils::Output::print("]\n");

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

opts.pl - testing program for the Meta::Utils::Opts::Opts.pm module.

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

	MANIFEST: opts.pl
	PROJECT: meta
	VERSION: 0.18

=head1 SYNOPSIS

	opts.pl

=head1 DESCRIPTION

This is a testing software and a demonstration of how to use the
Meta::Utils::Opts::Opts.pm library for command line option parsing.
See that libraries documentation for more details.

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

=item B<bool> (type: bool, default: 1)

just a bool

=item B<inte> (type: inte, default: 7)

just an int

=item B<stri> (type: stri, default: mark)

just a string

=item B<floa> (type: floa, default: 3.14)

just a float

=item B<dire> (type: dire, default: .)

just a directory

=item B<file> (type: file, default: /etc/passwd)

just a file

=item B<dbtype> (type: enum, default: mysql)

what database type do you want ?

options [mysql,oracle,postgres,informix]

=item B<flist> (type: setx, default: one,two)

list of files

options [mysql,oracle,postgres,informix]

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

	0.00 MV put ALL tests back and light the tree
	0.01 MV silense all tests
	0.02 MV more perl code quality
	0.03 MV perl code quality
	0.04 MV more perl quality
	0.05 MV more perl quality
	0.06 MV revision change
	0.07 MV languages.pl test online
	0.08 MV perl packaging
	0.09 MV license issues
	0.10 MV md5 project
	0.11 MV database
	0.12 MV perl module versions in files
	0.13 MV thumbnail user interface
	0.14 MV more thumbnail issues
	0.15 MV website construction
	0.16 MV improve the movie db xml
	0.17 MV web site automation
	0.18 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Ds::Enum(3), Meta::Ds::Set(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
