#!/bin/echo This is a perl module and should not be run

package Meta::Db::Constraint;

use strict qw(vars refs subs);
use Meta::Ds::Ohash qw();
use Meta::Ds::Connected qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Meta::Ds::Ohash Meta::Ds::Connected);

#sub BEGIN();
#sub getsql_create($$$);
#sub getsql_comma($$$);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_description",
		-java=>"_type",
	);
}

sub getsql_create($$$) {
	my($self,$stats,$info)=@_;
	if($self->get_type() eq "unique") {
		my($table)=$self->get_container()->get_container()->getsql_name($info);
		my($stat)=Meta::Sql::Stat->new();
		$stat->set_text("ALTER TABLE ".$table."ADD UNIQUE ".$self->getsql_comma($info));
		$stats->push($stat);
	}
	if($self->get_type() eq "fulltext") {
		my($table)=$self->get_container()->get_container()->getsql_name($info);
		#fulltext supported only on MySQL
		if($info->is_mysql()) {
			my($stat)=Meta::Sql::Stat->new();
			$stat->set_text("ALTER TABLE ".$table."ADD FULLTEXT ".$self->getsql_comma($info));
			$stats->push($stat);
		}
	}
	if($self->get_type() eq "primary") {
		my($table)=$self->get_container()->get_container()->getsql_name($info);
		my($stat)=Meta::Sql::Stat->new();
		$stat->set_text("ALTER TABLE ".$table."ADD PRIMARY KEY ".$self->getsql_comma($info));
		$stats->push($stat);
	}
}

sub getsql_comma($$) {
	my($self,$info)=@_;
	my(@arra);
	for(my($i)=0;$i<$self->size();$i++) {
		my($curr)=$self->elem($i);
		push(@arra,$curr);
	}
	return("(".join(",",@arra).")");
}

1;

__END__

=head1 NAME

Meta::Db::Constraint - a single multi-field constraint object.

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

	MANIFEST: Constraint.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Constraint qw();
	my($object)=Meta::Db::Constraint->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class represents a single, multi-field, constraint on an RDBMS.
This could be a UNIQUE or FULLTEXT constraint currently.

=head1 FUNCTIONS

	BEGIN()
	getsql_create($$$)
	getsql_comma($$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method creates accesor methods for the following attributes:
name - name of this constraint.
description - description of this constraint.

=item B<getsql_create($$$)>

This method will create a set of SQL statements to create this type
of constraint within the RDMBS. Note that not all RDBMS systems
support all constraint types.

=item B<getsql_comma($$)>

This method will return an SQL snipplet which has all the fields
involved with commas in between.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV dbman package creation
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
