#!/bin/echo This is a perl module and should not be run

package Meta::Db::Connections;

use strict qw(vars refs subs);
use Meta::Ds::Ohash qw();
use Meta::Xml::Parsers::Connections qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.33";
@ISA=qw(Meta::Ds::Ohash);

#sub new($);
#sub get_default($);
#sub set_default($$);
#sub get_def_con($);
#sub new_file($$);
#sub new_deve($$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Ohash->new();
	$self->{DEFAULT}=defined;
	bless($self,$clas);
	return($self);
}

sub get_default($) {
	my($self)=@_;
	return($self->{DEFAULT});
}

sub set_default($$) {
	my($self,$valx)=@_;
	$self->{DEFAULT}=$valx;
}

sub get_def_con($) {
	my($self)=@_;
	return($self->get($self->get_default()));
}

sub new_file($$) {
	my($clas,$file)=@_;
	my($parser)=Meta::Xml::Parsers::Connections->new();
	$parser->parsefile($file);
	return($parser->get_result());
}

sub new_deve($$) {
	my($clas,$deve)=@_;
	return(&new_file($clas,Meta::Baseline::Aegis::which($deve)));
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Db::Connections - Object to store a definition of mutiple connection to a database.

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

	MANIFEST: Connections.pm
	PROJECT: meta
	VERSION: 0.33

=head1 SYNOPSIS

	package foo;
	use Meta::Db::Connections qw();
	my($connections)=Meta::Db::Connections->new();
	my($num_connections)=$connections->get_size();

=head1 DESCRIPTION

This is an array of many connections to the database.

=head1 FUNCTIONS

	new($)
	get_default($)
	set_default($$)
	get_def_con($)
	new_file($$)
	new_deve($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This will create a new connections object for you.

=item B<get_default($)>

This method will retrieve the name of the default connection for you.

=item B<set_default($$)>

This method will set the name of the default connection for you.

=item B<get_def_con($)>

This method will retrive the default connection object for you.

=item B<new_file($$)>

This method receives:
0. A class name.
1. A file from which to read.
This method returns:
0. A Connections object constructed from the file.
How it does it:
The method uses the Meta::Xml::Parsers::Connections expat parser to do
its thing.
Remarks:
This method is static.

=item B<new_deve($$)>

This method receives:
0. A class name.
1. A development related file name.
This method returns:
0. A Connections object constructed from the file.
How it does it:
This method uses the new_file method of the same package.
Remarks:
This method is static.

=item B<TEST($)>

Test suite for this object.

=back

=head1 SUPER CLASSES

Meta::Ds::Ohash(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.08 MV put ALL tests back and light the tree
	0.09 MV change new methods to have prototypes
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV advance the contacts project
	0.20 MV xml data sets
	0.21 MV perl packaging
	0.22 MV XSLT, website etc
	0.23 MV PDMT
	0.24 MV some chess work
	0.25 MV md5 project
	0.26 MV database
	0.27 MV perl module versions in files
	0.28 MV movies and small fixes
	0.29 MV thumbnail user interface
	0.30 MV more thumbnail issues
	0.31 MV website construction
	0.32 MV web site automation
	0.33 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Ds::Ohash(3), Meta::Xml::Parsers::Connections(3), strict(3)

=head1 TODO

Nothing.
