#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Pdmt;

use strict qw(vars refs subs);
use Meta::Pdmt::Graph qw();
use Meta::Pdmt::Handlers qw();
use Meta::Pdmt::Listen qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub new($);
#sub get_graph($);
#sub get_handlers($);
#sub listen($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{GRAPH}=Meta::Pdmt::Graph->new();
	$self->{HANDLERS}=Meta::Pdmt::Handlers->new();
	return($self);
}

sub get_graph($) {
	my($self)=@_;
	return($self->{GRAPH});
}

sub get_handlers($) {
	my($self)=@_;
	return($self->{HANDLERS});
}

sub listen($) {
	my($self)=@_;
	my($listen)=Meta::Pdmt::Listen->new();
	$listen->listen();
}

1;

__END__

=head1 NAME

Meta::Pdmt::Pdmt - this is the pdmt object (master).

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

	MANIFEST: Pdmt.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Pdmt qw();
	my($object)=Meta::Pdmt::Pdmt->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Put a lot of documentation here to show what your class does.

=head1 FUNCTIONS

	new($)
	get_graph($)
	get_handlers($)
	listen($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Pdmt::Pdmt object.

=item B<get_graph($)>

This will give you the graph object.

=item B<get_handlers($)>

This will give you the handlers object.

=item B<listen($)>

This method will receive events and will handle them.
The events are: build [nodes],print_graph.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV misc fixes
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
