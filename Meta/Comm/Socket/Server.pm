#!/bin/echo This is a perl module and should not be run

package Meta::Comm::Socket::Server;

use strict qw(vars refs subs);
use IO::Socket::INET qw();
use Meta::Utils::Output qw();
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.06";
@ISA=qw(IO::Socket::INET);

#sub new($);
#sub run($);
#sub handle($$$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	$self->{SERVER}=IO::Socket::INET->new(
		LocalPort=>9000,
		LocalHost=>"localhost",
		Proto=>"tcp",
		Type=>IO::Socket::SOCK_STREAM,
		Reuse=>1,
		Listen=>10);
	if(!$self->{SERVER}) {
		Meta::Utils::System::die("unable to start server [".$!."]");
	}
	$self->{SERVER}->autoflush(1);
	Meta::Utils::Output::print("server listening\n");
	bless($self,$clas);
	return($self);
}

sub run($) {
	my($self)=@_;
#	Meta::Utils::Output::print("in run\n");
	while(my($client)=$self->{SERVER}->accept()) {
		Meta::Utils::Output::print("got comm\n");
		my($mess);
		while($client->recv($mess,1000)) {
#		while(my($mess)=<$client> || 0) {
			$self->handle($client,$mess);
		}
#		print $client "hello from server\n";
#		my($kidpid)=CORE::fork();
#		if(!defined($kidpid)) {
#			Meta::Utils::System::die("unable to fork");
#		}
#		if($kidpid) {
#			Meta::Utils::Output::print("in server in fork\n");
#			$self->{SERVER}->close();
#			my($pid)=CORE::fork();
#			if(!defined($pid)) {
#				Meta::Utils::System::die("unable to fork");
#			}
#			if($pid) {
#				my($mess);
#				while($client->recv($mess,5)) {
#				while($mess=<$client> || 0) {
#					Meta::Utils::Output::print("in loop\n");
#					$self->handle($client,$mess);
#				}
#				Meta::Utils::System::exit(1);
#			} else {
#			}
#			Meta::Utils::System::exit(1);
#		}
#		Meta::Utils::Output::print("in server out fork\n");
	}
	$self->{SERVER}->close();
}

sub handle($$$) {
	my($self,$client,$mess)=@_;
	Meta::Utils::Output::print("in handle with data [".$mess."]\n");
#	print $client "response\n";
	if(!$client->send("Goodbye\n")) {
		Meta::Utils::System::die("unable to send");
	}
	Meta::Utils::Output::print("data sent\n");
}

1;

__END__

=head1 NAME

Meta::Comm::Socket::Server - TCP/IP server class.

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
	VERSION: 0.06

=head1 SYNOPSIS

	package foo;
	use Meta::Comm::Socket::Server qw();
	my($object)=Meta::Comm::Socket::Server->new();
	my($result)=$object->run();

=head1 DESCRIPTION

This class eases the job of making a TCP/IP server.
Inherit from this class and you are on your way.

=head1 FUNCTIONS

	new($)
	run($)
	handle($$$)
	close($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Comm::Socket::Server object.

=item B<run($)>

This method runs the server, listens for TCP/IP calls and handles them
using the handle method.

=item B<handle($$$)>

This is the handle method. In this virtual server it does nothing.

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
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV movies and small fixes
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
