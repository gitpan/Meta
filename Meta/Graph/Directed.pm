#!/bin/echo This is a perl module and should not be run

package Meta::Graph::Directed;

use strict qw(vars refs subs);
use Graph::Directed qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Graph::Directed);

#sub new($);
#sub vertices_num($);
#sub edges_num($);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Graph::Directed->new();
	bless($self,$clas);
	return($self);
}

sub vertices_num($) {
	my($self)=@_;
	my($res);
	$res=$self->vertices();
	return($res);
}

sub edges_num($) {
	my($self)=@_;
	my($res);
	$res=$self->degree(undef);
	return($res);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Graph::Directed - enhance Graph::Directed.

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

	MANIFEST: Directed.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Graph::Directed qw();
	my($object)=Meta::Graph::Directed->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class is here to provide a place to add method to the Graph::Directed
module available from CPAN. I know that Graph::Directed looks pretty nice but
still if I need any convenience methods or maybe a small algorithm or two it
will be nice to add them at the graph level.

=head1 FUNCTIONS

	new($)
	vertices_num($)
	edges_num($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Constructor for the Meta::Graph::Directed object. This method is needed since if
it absent then objected created with this package will be blessed into
the Meta::Graph package.

=item B<vertices_num($)>

This method returns the number of vertices in the graph. It's true that the method
vertices in Graph returns this number if called in a scalar context but I hate having
methods behave differently in different contexes.

=item B<edges_num($)>

This method returns the number of edges in the graph.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Graph::Directed(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV web site automation
	0.01 MV SEE ALSO section fix

=head1 SEE ALSO

Graph::Directed(3), strict(3)

=head1 TODO

Nothing.
