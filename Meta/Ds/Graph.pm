#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Ds::Graph - data structure that represents a graph.

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
C<use Meta::Ds::Graph qw();>
C<my($graph)=Meta::Ds::Graph->new();>
C<$graph->node_insert("mark");>
C<$graph->node_insert("doron");>
C<$graph->edge_insert("mark","doron");>

=head1 DESCRIPTION

This is a library to let you create a graph like data structure.
The library gives services like the n'th node, n'th edge etc...
The graphs are directional.

=head1 EXPORTS

C<new($)>
C<nodes($)>
C<node_size($)>
C<node_has($$)>
C<node_insert($$)>
C<node_remove($$)>
C<edges($)>
C<edge_size($)>
C<edge_has($$$)>
C<edge_insert($$$)>
C<edge_remove($$$)>
C<edge_ou($$)>
C<edge_ou_size($$)>
C<edge_in($$)>
C<edge_in_size($$)>
C<print($$)>
C<numb_cycl($$$)>
C<all_ou($$$$)>

=cut

package Meta::Ds::Graph;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Oset qw();
use Meta::Utils::Output qw();
use Meta::Utils::Arg qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub nodes($);
#sub node_size($);
#sub node_has($$);
#sub node_insert($$);
#sub node_remove($$);
#sub edges($);
#sub edge_size($);
#sub edge_has($$$);
#sub edge_insert($$$);
#sub edge_remove($$$);
#sub edge_ou($$);
#sub edge_ou_size($$);
#sub edge_in($$);
#sub edge_in_size($$);
#sub print($$);
#sub numb_cycl($$$);
#sub all_ou($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

Gives you a new Graph object.

=cut

sub new($) {
	my($clas)=@_;
	Meta::Utils::Arg::check_arg($clas,"SCALAR");
	my($self)={};
	bless($self,$clas);
	$self->{NODE}=Meta::Ds::Oset->new();
	$self->{EDGE}=Meta::Ds::Oset->new();
	$self->{EDGE_OU}={};
	$self->{EDGE_IN}={};
	return($self);
}

=item B<nodes($)>

Return the set of nodes in the graph.

=cut

sub nodes($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,1);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	return($self->{NODE});
}

=item B<node_size($)>

return number of nodes in the graph.

=cut

sub node_size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,1);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	return($self->{NODE}->size());
}

=item B<node_has($$)>

This will return whether the graph has this node or not.

=cut

sub node_has($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	return($self->{NODE}->has($node));
}

=item B<node_insert($$)>

Insert a new node into the graph.

=cut

sub node_insert($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	if(!$self->node_has($node)) {
		$self->{NODE}->insert($node);
		$self->{EDGE_OU}->{$node}=Meta::Ds::Oset->new();
		$self->{EDGE_IN}->{$node}=Meta::Ds::Oset->new();
	}
}

=item B<node_remove($$)>

This removes a node with all edges attached

=cut

sub node_remove($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	my($seto)=$self->{EDGE_OU}->{$node};
	$seto->reset();
	while(!$seto->over()) {
		my($curr)=$seto->curr();
		$self->edge_remove($node,$curr);
		$seto->next();
	}
	my($seti)=$self->{EDGE_IN}->{$node};
	$seti->reset();
	while(!$seti->over()) {
		my($curr)=$seti->curr();
		$self->edge_remove($curr,$node);
		$seti->next();
	}
	$self->{EDGE_OU}->{$node}=undef;#remove the edge out
	$self->{EDGE_IN}->{$node}=undef;#remove the edge in
	$self->{NODE}->remove($node);
}

=item B<edges($)>

Return the set of edges in the graph.

=cut

sub edges($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,1);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	return($self->{EDGE});
}

=item B<edge_size($)>

Returns number of edges in the graph.

=cut

sub edge_size($) {
	my($self)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,1);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	return($self->{EDGE}->size());
}

=item B<edge_has($$$)>

This method returns whether there is already an edge in the graph with
the nodes you request.

=cut

sub edge_has($$$) {
	my($self,$nod1,$nod2)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,3);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($nod1,"ANY");
	Meta::Utils::Arg::check_arg($nod2,"ANY");
	$self->{NODE}->check_elem($nod1);
	$self->{NODE}->check_elem($nod2);
	my($newe)=$nod1.$;.$nod2;
	return($self->{EDGE}->has($newe));
}

=item B<edge_insert($$$)>

Insert a new edge into the graph.

=cut

sub edge_insert($$$) {
	my($self,$nod1,$nod2)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,3);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($nod1,"ANY");
	Meta::Utils::Arg::check_arg($nod2,"ANY");
	$self->{NODE}->check_elem($nod1);
	$self->{NODE}->check_elem($nod2);
	if(!$self->edge_has($nod1,$nod2)) {
		my($newe)=$nod1.$;.$nod2;
		$self->{EDGE}->insert($newe);
		$self->{EDGE_OU}->{$nod1}->insert($nod2);
		$self->{EDGE_IN}->{$nod2}->insert($nod1);
#		Meta::Utils::Output::print($nod1."\n");
#		Meta::Utils::Output::print($nod2."\n");
#		$nod1->print(Meta::Utils::Output::get_file());
#		$nod2->print(Meta::Utils::Output::get_file());
	}
}

=item B<edge_remove($$$)>

This removes an edge from the graph (both nodes remain in the graph).

=cut

sub edge_remove($$$) {
	my($self,$nod1,$nod2)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,3);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($nod1,"ANY");
	Meta::Utils::Arg::check_arg($nod2,"ANY");
	$self->{NODE}->check_elem($nod1);
	$self->{NODE}->check_elem($nod2);
	my($newe)=$nod1.$;.$nod2;
	$self->{EDGE}->check_elem($newe);
	$self->{EDGE}->remove($newe);
	$self->{EDGE_OU}->{$nod1}->remove($nod2);
	$self->{EDGE_IN}->{$nod2}->remove($nod1);
}

=item B<edge_ou($$)>

This gives you the set of all nodes this edge connects to.

=cut

sub edge_ou($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	return($self->{EDGE_OU}->{$node});
}

=item B<edge_ou_size($$)>

This gives you how many edges go out of a node.

=cut

sub edge_ou_size($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	return($self->edge_ou($node)->size());
}

=item B<edge_in($$)>

This gives you the set of all nodes this edge connects from.

=cut

sub edge_in($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	return($self->{EDGE_IN}->{$node});
}

=item B<edge_in_size($$)>

This gives you how many edges go in to a node.

=cut

sub edge_in_size($$) {
	my($self,$node)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	return($self->edge_in($node)->size());
}

=item B<print($$)>

Print the current graph to a file.
The input is the file to print to.

=cut

sub print($$) {
	my($self,$file)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,2);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($file,"ANY");
	print $file "nodes:\n";
	$self->{NODE}->print($file);
	print $file "edges:\n";
	my($edge)=$self->{EDGE};
	for(my($i)=0;$i<$edge->size();$i++) {
		my($curr)=$edge->elem($i);
		my($from,$to)=split($;,$curr);
		$from->print($file);
		$to->print($file);
	}
}

=item B<numb_cycl($$$)>

This method returns the number of cycles in the graph and acts verbosly
accoding to the flag given to it.
This is also receives the name of the file to be verbose into...

=cut

sub numb_cycl($$$) {
	my($self,$verb,$file)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,3);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($verb,"ANY");
	Meta::Utils::Arg::check_arg($file,"ANY");
#	my($unvi)=Meta::Ds::Set::copy("Meta::Ds::Set",$self->nodes());
	my($unvi);
	my($resu)=0;
	while($unvi->size()>0) {
		my($prim)=$unvi->any();
		my($stac)=Meta::Ds::Stack->new();
		my($csta)=Meta::Ds::Stack->new();
		$stac->push($prim);
		while($stac->size()) {
			my($curr)=$stac->pop();
			if($unvi->hasnt($curr)) {
				$resu++;
				if($verb) {
					print $file "cycle [".$curr."]\n";
					print $file "=============\n";
					$csta->print($file);
				}
			} else {
				$unvi->remove($curr);
				$csta->push($curr);
				$stac->push_set($self->edge_ou($curr));
#				$self->node_remove($curr);
			}
		}
	}
	return($resu);
}

=item B<all_ou($$$$)>

This method will add the nodes which are outwardly connected (recursivly)
to the hash given to it.

=cut

sub all_ou($$$$) {
	my($self,$node,$hash,$list)=@_;
	Meta::Utils::Arg::check_arg_num(\@_,4);
	Meta::Utils::Arg::check_arg($self,"Meta::Ds::Graph");
	Meta::Utils::Arg::check_arg($node,"ANY");
	Meta::Utils::Arg::check_arg($hash,"HASHref");
	Meta::Utils::Arg::check_arg($list,"ARRAYref");
	if(!$self->node_has($node)) {
		Meta::Utils::System::die("don't have the node [".$node."]\n");
	}
	my($edge_ou)=$self->edge_ou($node);
	for(my($i)=0;$i<$edge_ou->size();$i++) {
		my($curr)=$edge_ou->elem($i);
		#Meta::Utils::Output::print("adding [".$curr."]\n");
		if(!defined($hash->{$curr})) {
			$hash->{$curr}=defined;
			push(@$list,$curr);
		}
	}
	for(my($i)=0;$i<$edge_ou->size();$i++) {
		my($curr)=$edge_ou->elem($i);
		$self->all_ou($curr,$hash,$list);
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
1	Mon Jan  1 16:38:12 2001	MV	initial code brought in
2	Tue Jan  2 06:08:54 2001	MV	bring databases on line
2	Thu Jan  4 13:36:17 2001	MV	ok. This is for real
3	Sat Jan  6 11:39:39 2001	MV	make quality checks on perl code
4	Sat Jan  6 17:14:09 2001	MV	more perl checks
5	Tue Jan  9 18:15:19 2001	MV	check that all uses have qw
5	Tue Jan  9 19:29:31 2001	MV	fix todo items look in pod documentation
6	Wed Jan 10 12:05:55 2001	MV	more on tests/more checks to perl
7	Tue Jan 23 14:08:51 2001	MV	Java simulation framework
8	Sun Jan 28 02:34:56 2001	MV	perl code quality
9	Sun Jan 28 13:51:26 2001	MV	more perl quality
10	Tue Jan 30 03:03:17 2001	MV	more perl quality
11	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
12	Sat Feb  3 23:41:08 2001	MV	perl documentation
13	Mon Feb  5 03:21:02 2001	MV	more perl quality
14	Tue Feb  6 01:04:52 2001	MV	perl qulity code
15	Tue Feb  6 07:02:13 2001	MV	more perl code quality
16	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
