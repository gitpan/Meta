#!/bin/echo This is a perl module and should not be run

package Meta::Db::Connection;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.29";
@ISA=qw();

#sub BEGIN();
#sub print($$);
#sub is_postgres($);
#sub is_mysql($);
#sub get_dsn($$);
#sub get_dsn_nodb($);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new("new");
	Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_type",
		-java=>"_host",
		-java=>"_port",
		-java=>"_user",
		-java=>"_password",
	);
}

sub print($$) {
	my($self,$file)=@_;
	print $file "name=[".$self->get_name()."]\n";
	print $file "type=[".$self->get_type()."]\n";
	print $file "host=[".$self->get_host()."]\n";
	print $file "port=[".$self->get_port()."]\n";
	print $file "user=[".$self->get_user()."]\n";
	print $file "pass=[".$self->get_password()."]\n";
}

sub is_postgres($) {
	my($self)=@_;
	return($self->get_type() eq "Pg");
}

sub is_mysql($) {
	my($self)=@_;
	return($self->get_type() eq "mysql");
}

sub get_dsn($$) {
	my($self,$name)=@_;
	my($dsnx);
	if($self->is_postgres()) {
		$dsnx="dbi:".$self->get_type().":dbname=".$name.";host=".$self->get_host();
	}
	if($self->is_mysql()) {
		$dsnx="dbi:".$self->get_type().":host=".$self->get_host().":database=".$name;
	}
	return($dsnx);
}

sub get_dsn_nodb($) {
	my($self)=@_;
	my($dsnx)="dbi:".$self->get_type().":host=".$self->get_host();
	return($dsnx);
}

1;

__END__

=head1 NAME

Meta::Db::Connection - Object to store a definition of a connection to a database.

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

	MANIFEST: Connection.pm
	PROJECT: meta
	VERSION: 0.29

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Connection qw();
	my($connection)=Meta::Db::Connection->new();
	$connection->set_host("www.gnu.org");

=head1 DESCRIPTION

This object will store everything you need to know in order to get a
connection to the database.

=head1 FUNCTIONS

	BEGIN()
	print($$)
	is_postgres($)
	is_mysql($)
	get_dsn($$)
	get_dsn_nodb($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

Instantiates basic accessors.
Here they are: "name","type","host","port","user","pass","drop",
"crea","drok","must","must","over","edir","flat".

=item B<print($$)>

This will print the current field for you.

=item B<is_postgres($)>

This method will return TRUE iff the connection object is a PosgreSQL database.

=item B<is_mysql($)>

This method will return TRUE iff the connection object is a MySQL database.

=item B<get_dsn($$)>

This method will return a DSN according to perl DBI/DBD to connect to a database.
Unfortunately - connections to different Dbs have different DSNs.

=item B<get_dsn_nodb($)>

This method will return a DSN according to perl DBI/DBD with no db (just host connection).

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV bring databases on line
	0.01 MV get the databases to work
	0.02 MV convert all database descriptions to XML
	0.03 MV make quality checks on perl code
	0.04 MV more perl checks
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV more on tests/more checks to perl
	0.08 MV change new methods to have prototypes
	0.09 MV perl code quality
	0.10 MV more perl quality
	0.11 MV chess and code quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV perl packaging
	0.20 MV PDMT
	0.21 MV some chess work
	0.22 MV more movies
	0.23 MV md5 project
	0.24 MV database
	0.25 MV perl module versions in files
	0.26 MV movies and small fixes
	0.27 MV thumbnail project basics
	0.28 MV thumbnail user interface
	0.29 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-support more database in get_dsn.

-limit type of databases in set_type.

-have a method that will print this object in XML.
