#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Pdmt::Graph - data structure that represents a Pdmt graph.

=head1 COPYRIGHT

Copyright (C) 2001 Mark Veltzer;
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

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Pdmt::Graph qw();>

=head1 DESCRIPTION

This is the dependency graph object for the Pdmt.

=head1 EXPORTS

C<build()>

=cut

package Meta::Pdmt::Graph;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Dgraph qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Dgraph);
@EXPORT_OK=qw();
@EXPORT=qw();

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<build($$)>

This is the most important method - the build method.
The method returns the result of the build.

=cut

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

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Sat Jan 27 19:56:28 2001	MV	perl quality change
2	Sun Jan 28 02:34:56 2001	MV	perl code quality
3	Sun Jan 28 13:51:26 2001	MV	more perl quality
3	Tue Jan 30 03:03:17 2001	MV	more perl quality
4	Sat Feb  3 23:41:08 2001	MV	perl documentation
5	Mon Feb  5 03:21:02 2001	MV	more perl quality
6	Tue Feb  6 07:02:13 2001	MV	more perl code quality
7	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
