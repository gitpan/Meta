#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Graph;

use strict qw(vars refs subs);
use Meta::Graph::Directed qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.22";
@ISA=qw(Meta::Graph::Directed);

#sub build($$);
#sub calc_need_rebuilding($);
#sub need_rebuilding($$);
#sub can_remove($$);
#sub TEST($);

#__DATA__

sub build($$) {
	my($self,$node)=@_;
	my(@nodes)=$self->successors($node);
	for(my($j)=0;$j<=$#nodes;$j++) {
		my($curr)=$nodes[$j];
		Meta::Utils::Output::print("building [".$curr->get_name()."]\n");
		$self->build($curr);
	}
	if(!$node->uptodate($self)) {
		Meta::Utils::Output::print("building [".$node->get_name()."]\n");
		$node->build($self);
	}
}

sub calc_need_rebuilding($) {
	my($self)=@_;
	my($list)=$self->get_roots();
	for(my($i)=0;$i<$list->size();$i++) {
		my($curr)=$list->elem($i);
		$self->need_rebuilding($curr);
	}
}

sub need_rebuilding($$) {
	my($self,$node)=@_;
}

sub can_remove($$) {
	my($self,$node)=@_;
	if($self->edge_ou($node)->size()==0) {
		return(1);
	} else {
		return(0);
	}
}

sub TEST($) {
	my($context)=@_;
	return(1);
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
	VERSION: 0.22

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Graph qw();

=head1 DESCRIPTION

This is the dependency graph object for the Pdmt project.
The graph is a graph which represents object (files, db records or whatever)
that need to be maintained up to date one relative to the other.

Each node in the graph needs to implement two methods:
uptodate and build.

uptodate is a method which returns whether this file is up to date.
build is the method which builds the nodes from other nodes.

both of these method of the node receive the graph that it is a member of.

=head1 FUNCTIONS

	build($$)
	calc_need_rebuilding($)
	can_remove($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<build($$)>

This is the most important method - the build method.
The method returns the result of the build.
The method receives a list of nodes to be built.

The method is recursive. The method recursivly builds all ingredients
for the node to be built. When returning (i.e. all ingrediants are built)
the method checks if the node needs to be updated using the requires_update
method. If it does need updating then it activates the nodes "build" method.

If the method receives a graph with cycles then it will go into an endless
loop. This needs to be fixed in the future.

This object inherits from a graph object which must give these services for
this object to do it's work effectivly:
1. O(1) tag all nodes as unvisited.
2. O(1) check if the graph has cycles (at the expense of more time at each
	insert of node). The underlying graph may just reject insertion
	of nodes which create cycles.
3. O(1) retrieval of edges going in or out of a node. 
4. Ability to store any object in the node.
5. Ability to have different types of archs and specify which types of archs
	do you want to get (and specifying a sort of mask to get several
	types of archs).
6. The graph needs to be directed.
7. The graph must not enforce connectivity (forest).
8. The graph must remove all edges in or out of a node if the node is removed.
9. O(1) answer if an edge (n,m) exists.
10. O(1) tag a specific node as visited.
11. O(1) get roots of all trees.
12. The graph is supposed to provide fast translation between module names to
	nodes (or is it not the job of the graph ?).

The idea is for this object to always know what needs rebuilding. Each object can
say whether it responds to triggers or not and do whatever it needs to update this
information.

The object (graph) needs to supply (quickly) the forest of things to be done.

=item B<calc_need_rebuilding($)>

This method calculates which nodes in the graph need rebuilding.
The algorithm:
1. get the roots of all trees.
2. recusivly calc for each node if it needs rebuilding.

=item B<need_rebuilding($$)>

This method returns whether a specific node needs rebuilding.

=item B<can_remove($$)>

This method will return whether removing a certain node from Pdmt is allowed.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Meta::Graph::Directed(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.20 MV website construction
	0.21 MV web site automation
	0.22 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Graph::Directed(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
