#!/bin/echo This is a perl module and should not be run

package Meta::Distrib::Machines;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();
use Meta::Distrib::Machine qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw(Meta::Ds::Array);

#sub new($);
#sub read($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Array->new();
	bless($self,$clas);
	return($self);
}

sub read($$) {
	my($self,$file)=@_;
	open(FILE,$file) || Meta::Utils::System::die("unable to open file [".$file."]");
	my($line);
	while($line=<FILE> || 0) {
		chop($line);
#		Meta::Utils::Output::print("in here with line [".$line."]\n");
		my(@fiel)=split("\t",$line);
		if($#fiel!=6) {
			Meta::Utils::System::die("wrong number of fields in line [".$line."]".$#fiel);
		}
		my($name)=$fiel[0];
		my($user)=$fiel[5];
		my($pass)=$fiel[6];
		my($obje)=Meta::Distrib::Machine->new();
		$obje->set_name($name);
		$obje->set_user($user);
		$obje->set_password($pass);
		$self->push($obje);
	}
	close(FILE) || Meta::Utils::System::die("unable to close file [".$file."]");
}

1;

__END__

=head1 NAME

Meta::Distrib::Machines - Object to store a definition of a list of machines to distribute to.

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

	MANIFEST: Machines.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Distrib::Machines qw();
	my($machiners)=Meta::Distrib::Machines->new();
	$machines->read("machine_list.txt");

=head1 DESCRIPTION

This is an object to store a list of machiens.

=head1 FUNCTIONS

	new($)
	read($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a machine list definitions.

=item B<read($$)>

This will read a file distribution list.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV bring databases on line
	0.02 MV make quality checks on perl code
	0.03 MV more perl checks
	0.04 MV make Meta::Utils::Opts object oriented
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV more on tests/more checks to perl
	0.08 MV change new methods to have prototypes
	0.09 MV correct die usage
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV perl packaging
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
