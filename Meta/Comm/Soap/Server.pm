#!/bin/echo This is a perl module and should not be run

package Meta::Comm::Soap::Server;

use strict qw(vars refs subs);
use SOAP::Transport::TCP qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw(SOAP::Transport::TCP::Server);

#sub new($);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=SOAP::Transport::TCP::Server->new(
		LocalAddr=>'localhost',
		LocalPort=>10001,
		Listen=>5,
		Reuse=>1,
	);
	my($list)=Meta::Baseline::Aegis::search_path_list();
	$self->dispatch_to("Meta::Info::Author");
	$self->objects_by_reference("Meta::Info::Author");
	#$self->uri("uri");
	#$self->objects_by_reference
	#bless($self,$clas);# this somehow prevents server from running
	return($self);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Comm::Soap::Server - a SOAP server class.

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

	MANIFEST: Server.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Comm::Soap::Server qw();
	my($object)=Meta::Comm::Soap::Server->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class is a class to derive Soap servers from. It
provides some easy functionality for using SOAP without
weird perl calling conventions.

=head1 FUNCTIONS

	new($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Comm::Soap::Server object.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

SOAP::Transport::TCP::Server(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
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
	0.08 MV website construction
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), SOAP::Transport::TCP(3), strict(3)

=head1 TODO

Nothing.
