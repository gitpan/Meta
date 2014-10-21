#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Db::Ops qw();
use Meta::Db::Connections qw();
use Meta::Db::Dbi qw();

my($connections_file,$con_name,$name);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->def_devf("connections_file","what connections XML file to use ?","xmlx/connections/connections.xml",\$connections_file);
$opts->def_stri("con_name","what connection name ?",undef,\$con_name);
$opts->def_stri("name","what database name ?",undef,\$name);
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($connections)=Meta::Db::Connections->new_deve($connections_file);
my($connection)=$connections->get_con_null($con_name);

my($dbi)=Meta::Db::Dbi->new();
$dbi->connect_name($connection,$name);

Meta::Db::Ops::clean_sa($dbi);

$dbi->disconnect();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

db_clean_sa.pl - clean a database (standalone).

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

	MANIFEST: db_clean_sa.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	db_clean_sa.pl [options]

=head1 DESCRIPTION

This script will clean a database (empty it from it's data).
All you need to supply is the connection data and the name
of the database (no need for the database definition).

This script works by querying the database for the set of it's
tables and then issueing a "DELETE FROM %table%" statements for
each table.

Use this script with care as it will remove all data from the
database you give it.

=head1 OPTIONS

=over 4

=item B<connections_file> (type: devf, default: xmlx/connections/connections.xml)

what connections XML file to use ?

=item B<con_name> (type: stri, default: )

what connection name ?

=item B<name> (type: stri, default: )

what database name ?

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

	0.00 MV md5 project
	0.01 MV database
	0.02 MV perl module versions in files
	0.03 MV thumbnail user interface
	0.04 MV more thumbnail issues
	0.05 MV website construction
	0.06 MV improve the movie db xml
	0.07 MV web site automation
	0.08 MV SEE ALSO section fix
	0.09 MV move tests to modules
	0.10 MV download scripts

=head1 SEE ALSO

Meta::Db::Connections(3), Meta::Db::Dbi(3), Meta::Db::Ops(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
