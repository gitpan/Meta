#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Aegis qw();
use BerkeleyDB qw();

my($file);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("file","which berkeley db file ?","bdbx/addressbook.db",\$file);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

$file=Meta::Baseline::Aegis::which($file);
Meta::Utils::Output::print("file is [".$file."]\n");
#my($db)=BerkeleyDB::Hash->new(-Filename=>$file);
#the flags in the next statement are somehow necessary...
#how do I open the DB for read only ?!?
#my($db)=BerkeleyDB::Hash->new(-Filename=>$file,-Flags=>BerkeleyDB::DB_CREATE());
#my($db)=BerkeleyDB::Hash->new(-Filename=>$file,-Flags=>0);
#my($db)=BerkeleyDB::Hash->new(-Filename=>$file,-Mode=>0444);
my($db)=BerkeleyDB::Hash->new(-Filename=>$file,-Flags=>BerkeleyDB::DB_RDONLY());
#my($db)=BerkeleyDB::Hash->new(-Filename=>$file,-Flags=>BerkeleyDB::DB_CREATE());
if(!$db) {
	Meta::Utils::System::die("no db with error [".$BerkeleyDB::Error."]");
}
my($k,$v)=("","");
my($cursor)=$db->db_cursor();
while($cursor->c_get($k,$v,BerkeleyDB::DB_NEXT())==0)
{
	Meta::Utils::Output::print($k." -> ".$v."\n");
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

evolution_from.pl - convert evolution contact databases to xml.

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

	MANIFEST: evolution_from.pl
	PROJECT: meta
	VERSION: 0.04

=head1 SYNOPSIS

	evolution_from.pl [options]

=head1 DESCRIPTION

This program will convert evolution .db (berkeley db) contact files to XML
format according to my DTD.

Features currently supported: none.

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

=item B<file> (type: devf, default: bdbx/addressbook.db)

which berkeley db file ?

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

	0.00 MV improve the movie db xml
	0.01 MV web site development
	0.02 MV web site automation
	0.03 MV SEE ALSO section fix
	0.04 MV move tests to modules

=head1 SEE ALSO

BerkeleyDB(3), Meta::Baseline::Aegis(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.