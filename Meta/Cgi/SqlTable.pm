#!/bin/echo This is a perl module and should not be run

package Meta::Cgi::SqlTable;

use strict qw(vars refs subs);
use CGI qw();
use SQL::Statement qw();

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw(CGI);

#sub get_columns($$);
#sub sql_table($$$$$);
#sub core_code($$$$$$);
#sub TEST($);

#__DATA__

sub get_columns($$) {
	my($self,$stat)=@_;
	my($stmt)=SQL::Statement->new($stat);
	my(@columns)=$stmt->columns();
	my(@col_res);
	for(my($i)=0;$i<=$#columns;$i++) {
		my($curr)=$columns[$i];
		my($table)=$curr->table();
		my($name)=$curr->name();
		# the reason of lc in the next line is that SQL::Statement is not
		# consistant in upper case and lower case handling of table and field
		# name (this needs to be reported to the author).
		my($full)=CORE::lc($table.".".$name);
		push(@col_res,$full);
	}
	return(\@col_res);
}

sub sql_table($$$$$) {
	my($self,$stat,$def,$dbi,$rows)=@_;
	my($columns)=$self->get_columns($stat);
	return($self->core_code($stat,$def,$dbi,$rows,$columns));
}

sub core_code($$$$$$) {
	my($self,$stat,$def,$dbi,$rows,$columns)=@_;
	my($pretty)=1;
	my($res);
	$res.=$self->comment("Generated by Meta::Cgi::SqlTable");
	$res.=$self->start_table();
	$res.=$self->caption($stat);
	$res.="<tr>";
	for(my($i)=0;$i<=$#$columns;$i++) {
		my($curr)=$columns->[$i];
		$res.=$self->th($curr);
	}
	$res.="</tr>";
	my($ar)=$dbi->execute_arrayref($stat." LIMIT ".$rows);
	for(my($i)=0;$i<=$#$ar;$i++) {
		$res.="<tr>";
		my($arr)=$ar->[$i];
		#Meta::Utils::Output::print("arr is [".$arr."]\n");
		for(my($j)=0;$j<=$#$arr;$j++) {
			my($curr)=$arr->[$j];
			$res.=$self->td($curr);
		}
		$res.="</tr>";
		if($pretty) {
			$res.="\n";
		}
	}
	$res.=$self->end_table();
	return($res);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Cgi::SqlTable - show the results of an SQL query.

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

	MANIFEST: SqlTable.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Cgi::SqlTable qw();
	my($object)=Meta::Cgi::SqlTable->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Give this class:
1. An SQL statement.
2. A description of a database that it's supposed to work on.
3. A DBI handle.
4. How many rows of results you want displayed and other hints.

And it will display a CGI UI which enabled you to browse through
the results.

The object will:
1. Analyze the statement using SQL::Statement to find out which fields it returns.
2. Build a table with hints about the columns.
3. Build buttons to move forward, backward in the results and select how many
results to see at once.

=head1 FUNCTIONS

	get_columns($$)
	sql_table($$$$$)
	core_code($$$$$$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<get_columns($$)>

This function analyzes an SQL statement using SQL::Statement and returns the columns
that the statement returns.

=item B<sql_table($$$$$)>

This method does all the work. Give it hell.
Arguments are:
0. Meta::Cgi::SqlTable object.
1. SQL statement to be used.
2. definition object of the database.
3. dbi handle.
4. number of rows to display.

=item B<core_code($$$$$$)>

This method actually does the work and gets the columns too.

=item B<TEST($)>

This is a testing suite for the Meta::Cgi::SqlTable module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

=back

=head1 SUPER CLASSES

CGI(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV download scripts
	0.01 MV weblog issues
	0.02 MV md5 issues

=head1 SEE ALSO

CGI(3), SQL::Statement(3), strict(3)

=head1 TODO

-add support for the SORTED BY (combo box which allows the user to select according to which field to sort).

-add limit for nubmer of rows.

-add forward and back buttons.

-add options to change the limit by the user.

-add cascading style sheet support.

-add tool tips about the headers of the table.

-add options to gather results according to groups (for example letters) if there is too much results.
