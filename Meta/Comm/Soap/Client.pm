#!/bin/echo This is a perl module and should not be run

package Meta::Comm::Soap::Client;

use strict qw(vars refs subs);
use SOAP::Lite qw();
use Meta::Utils::System qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw(SOAP::Lite);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	Meta::Utils::Output::print("in 1\n");
	my($self)=SOAP::Lite->uri('http://localhost/Meta::Info::Author');
	Meta::Utils::Output::print("in 2\n");
	if(!defined($self)) {
		Meta::Utils::System::die("cant get object");
	}
	#bless($self,$clas);# this prevents the client from running
	#$self->uri("uri");
	Meta::Utils::Output::print("in 3\n");
	$self->proxy("tcp://localhost:10001");
	Meta::Utils::Output::print("in 4\n");
	return($self);
}

1;

__END__

=head1 NAME

Meta::Comm::Soap::Client - extend the SOAP client.

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
	use Meta::Comm::Soap::Client qw();
	my($object)=Meta::Comm::Soap::Client->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Use this class to derive your SOAP client.

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Comm::Soap::Client object.

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
