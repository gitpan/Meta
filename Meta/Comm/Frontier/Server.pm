#!/bin/echo This is a perl module and should not be run

package Meta::Comm::Frontier::Server;

use strict qw(vars refs subs);
use Frontier::Daemon qw();
use Meta::Lang::Perl::Interface qw();
use Meta::Utils::Output qw();
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw(Frontier::Daemon);

#sub new($);
#sub set_obje($$);
#sub run($);
#sub quit($);
#sub test($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Frontier::Daemon->new(
		LocalPort=>1080,
		methods=>{
			'test'=>\&test,
			'quit'=>\&quit,
		},
	);
	if(!$self) {
		Meta::Utils::System::die("cannot create server");
	}
	#bless($self,$clas);
	return($self);
}

sub set_obje($$) {
	my($self,$obje)=@_;
	$self->{OBJE}=$obje;
}

sub run($) {
	my($self)=@_;
	my($hash)=Meta::Lang::Perl::Interface::get_method_hash($self->{OBJE});
	my($methods)={};
	while(my($key,$val)=each(%$hash)) {
		Meta::Utils::Output::print("in here with key [".$key."] val [".$val."]\n");
		$methods->{$key}=\&quit;
#		sub
#		{
#			my(@args)=@_;
#			my($object)=Meta::Comm::Frontier::Server::get_object();
#			$object->$key(@args);
#		};
	}
	$methods->{"quit"}=\&quit;
	my($xmlrpc_protocol)="http";
	my($xmlrpc_host)="localhost";
	my($xmlrpc_port)=1080;
	my($xmlrpc_subdir)="RPC2";
	my($server)=Frontier::Daemon->new(
		methods=>$methods,
#		LocalAddr=>$xmlrpc_host,
		LocalPort=>$xmlrpc_port,
	);
}

sub quit($) {
	my($self)=@_;
	CORE::exit(1);
	return(1);
}

sub test($) {
	return(1972);
}

1;

__END__

=head1 NAME

Meta::Comm::Frontier::Server - what does your module/class do.

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
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Comm::Frontier::Server qw();
	my($object)=Meta::Comm::Frontier::Server->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class is an extension of the Frontier::Daemon class that does
a server communication class.

=head1 FUNCTIONS

	new($)
	set_obje($$)
	run($)
	quit($)
	test($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Comm::Frontier::Server object.

=item B<set_obje($$)>

This method will set the object specified.

=item B<run($)>

This method will run the server.

=item B<quit($)>

This method quits the server.

=item B<test($)>

This method tests the server.

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
