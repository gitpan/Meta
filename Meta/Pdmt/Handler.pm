#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Handler;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub new($);
#sub set_graph($$);
#sub get_graph($);
#sub handle_init($);
#sub handle_add_node($$);
#sub handle_del_node($$);
#sub handle_update_node($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	return($self);
}

sub set_graph($$) {
	my($self)=@_;
}

sub handle_init($) {
	my($self)=@_;
}

1;

__END__

=head1 NAME

Meta::Pdmt::Handler - what does your module/class do.

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

	MANIFEST: Handler.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Handler qw();
	my($object)=Meta::Pdmt::Handler->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Put a lot of documentation here to show what your class does.

=head1 FUNCTIONS

	new($)
	set_graph($$)
	handle_init($)
	handle_add_node($$)
	handle_del_node($$)
	handle_update_node($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Pdmt::Handler object.

=item B<set_graph($$)>

This will set the graph so it will be accessible to the handler.

=item B<handle_init($)>

This method will init the handler.
In this meta handler it does nothing.

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
