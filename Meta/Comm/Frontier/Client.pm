#!/bin/echo This is a perl module and should not be run

package Meta::Comm::Frontier::Client;

use strict qw(vars refs subs);
use Frontier::Client qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw(Frontier::Client);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($xmlrpc_proto)="http";
	my($xmlrpc_host)="localhost";
	my($xmlrpc_port)=1080;
	my($xmlrpc_subdir)="RPC2";
	my($fullurl)=$xmlrpc_proto."://".$xmlrpc_host.":".$xmlrpc_port."/".$xmlrpc_subdir;
	my($self)=Frontier::Client->new(
		'url'=>$fullurl
	);
	bless($self,$clas);
	return($self);
}

1;

__END__

=head1 NAME

Meta::Comm::Frontier::Client - object which does an xml/rpc client.

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

	MANIFEST: Client.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Comm::Frontier::Client qw();
	my($object)=Meta::Comm::Frontier::Client->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This package implements an xml/rpc client which inherits from
Frontier::Client (from the Frontier::RPC package).

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This method instantiates a new object.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging again
	0.01 MV stuff
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
