#!/bin/echo This is a perl module and should not be run

package Meta::Sql::Stat;

use strict qw(vars refs subs);
use Meta::Ds::String qw();
use SQL::Statement qw();

our($VERSION,@ISA);
$VERSION="0.16";
@ISA=qw(Meta::Ds::String);

#sub execute($$);
#sub check($);

#__DATA__

sub execute($$) {
	my($stat,$dbi)=@_;
	$dbi->execute_single($stat);
}

sub check($) {
	my($self)=@_;
	my($text)=$self->get_text();
	my($stmt)=eval {
		SQL::Statement->new($text);
	};
	if($@) {
		return(0);
	} else {
		return(1);
	}
}

sub is_reconnect($) {
	my($self)=@_;
	my($text)=$self->get_text();
	if($text=~/^RECONNECT /) {
		return(1);
	} else {
		return(0);
	}
}

sub is_sql($) {
	my($self)=@_;
	return(!($self->is_reconnect()));
}

sub get_reconnect_name($) {
	my($self)=@_;
	my($text)=$self->get_text();
	my(@fields)=split(" ",$text);
	return($fields[1]);
}

1;

__END__

=head1 NAME

Meta::Sql::Stat - an object which encapsulates a single SQL statement.

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

	MANIFEST: Stat.pm
	PROJECT: meta
	VERSION: 0.16

=head1 SYNOPSIS

	package foo;
	use Meta::Sql::Stat qw();
	my($object)=Meta::Sql::Stat->new();
	my($result)=$object->set_text("INSERT INTO GAME ...");

=head1 DESCRIPTION

This class is a single SQL statement. It has methods like validation and
execution on a specified DBI connection and writing it down to a file.

=head1 FUNCTIONS

	execute($$)
	check($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<execute($$)>

This method will execute the Stat object received.
The method receives a Dbi object to work with.

=item B<check($)>

This will check the statement.
This method currently does nothing.

=item B<is_reconnect($)>

This method will return whether this statements purpose is reconnecting to another database name.

=item B<is_sql($)>

This is the inverse meaning of "is_reconnect".

=item B<get_reconnect_name($)>

This method retrieves the name of the database to reconnect to.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl documentation
	0.01 MV get graph stuff going
	0.02 MV more perl quality
	0.03 MV perl qulity code
	0.04 MV more perl code quality
	0.05 MV revision change
	0.06 MV languages.pl test online
	0.07 MV db stuff
	0.08 MV perl packaging
	0.09 MV PDMT
	0.10 MV fix database problems
	0.11 MV md5 project
	0.12 MV database
	0.13 MV perl module versions in files
	0.14 MV movies and small fixes
	0.15 MV thumbnail user interface
	0.16 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-implement the check method using SQL::Statement.
