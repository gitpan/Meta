#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Perl::Perlpkgs;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();
use Meta::Xml::Parsers::Perlpkgs qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.09";
@ISA=qw(Meta::Ds::Array);

#sub new_file($);
#sub new_deve($);
#sub add_deps($$$);

#__DATA__

sub new_file($) {
	my($file)=@_;
	my($parser)=Meta::Xml::Parsers::Perlpkgs->new();
	$parser->parsefile($file);
	return($parser->get_result());
}

sub new_deve($) {
	my($file)=@_;
	return(new_file(Meta::Baseline::Aegis::which($file)));
}

sub add_deps($$$) {
	my($self,$modu,$deps)=@_;
	for(my($i)=0;$i<$self->size();$i++) {
		$self->getx($i)->add_deps($modu,$deps);
	}
}

1;

__END__

=head1 NAME

Meta::Lang::Perl::Perlpkgs - store information for a perl packages.

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

	MANIFEST: Perlpkgs.pm
	PROJECT: meta
	VERSION: 0.09

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Perl::Perlpkgs qw();
	my($object)=Meta::Lang::Perl::Perlpkgs->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module stores multiple perl package information.

=head1 FUNCTIONS

	new_file($)
	new_deve($)
	add_deps($$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new_file($)>

This method will read an XML file that contains Perlpkgs information
using the Meta::Xml::Parser::Perlpkgs parser.

=item B<new_deve($)>

This method is exactly like new_file except it searches for the
requested file in the development path.

=item B<add_deps($$$)>

This method will add dependency information for the set of perl
packages.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging
	0.01 MV perl packaging again
	0.02 MV perl packaging again
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV thumbnail project basics
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.