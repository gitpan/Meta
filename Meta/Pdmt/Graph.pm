#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Graph;

use strict qw(vars refs subs);
use Meta::Ds::Dgraph qw();

our($VERSION,@ISA);
$VERSION="0.19";
@ISA=qw(Meta::Ds::Dgraph);

#__DATA__

sub build($$) {
	my($self,$list)=@_;
	for(my($i)=0;$i<=$#$list;$i++) {
		my($curr_res);
		my($curr)=$list->[$i];
		# if the node is a file then apply the stat rule to it
		if($self->node_data($curr) eq "file") {
			my($outf)=$self->edge_ou($curr);
		}
		# tags are always executed
		if($self->node_data($curr) eq "tag") {
			my($data)=$self->node_data($curr);
			# run the procedure.
		}
	}
}

1;

__END__

=head1 NAME

Meta::Pdmt::Graph - data structure that represents a Pdmt graph.

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

	MANIFEST: Graph.pm
	PROJECT: meta
	VERSION: 0.19

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Graph qw();

=head1 DESCRIPTION

This is the dependency graph object for the Pdmt.

=head1 FUNCTIONS

	build()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<build($$)>

This is the most important method - the build method.
The method returns the result of the build.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl quality change
	0.01 MV perl code quality
	0.02 MV more perl quality
	0.03 MV more perl quality
	0.04 MV perl documentation
	0.05 MV more perl quality
	0.06 MV more perl code quality
	0.07 MV revision change
	0.08 MV languages.pl test online
	0.09 MV misc fixes
	0.10 MV spelling and papers
	0.11 MV PDMT/SWIG support
	0.12 MV Pdmt stuff
	0.13 MV perl packaging
	0.14 MV md5 project
	0.15 MV database
	0.16 MV perl module versions in files
	0.17 MV movies and small fixes
	0.18 MV thumbnail user interface
	0.19 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
