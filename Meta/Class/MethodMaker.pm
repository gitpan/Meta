#!/bin/echo This is a perl module and should not be run

package Meta::Class::MethodMaker;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Class::MethodMaker);

#sub print($$);

#__DATA__

sub print($$) {
	my($class,$arra)=@_;
	my($code)='sub { my($self,$file)=@_;';
	for(my($i)=0;$i<=$#$arra;$i++) {
		my($curr)=$arra->[$i];
		$code.='print $file "'.$curr.' is [".$self->get_'.$curr.'()."]\n";';
	}
	$code.="}";
#	Meta::Utils::Output::print("code is [".$code."]\n");
	my(%methods);
	$methods{"print"}=eval($code);
#		sub {
#			my($self,$file)=@_;
#			print $file $self->get_$arra[0]()."\n";
#		};
	$class->install_methods(%methods);
}

1;

__END__

=head1 NAME

Meta::Class::MethodMaker - add capabilities to Class::MethodMaker.

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

	MANIFEST: MethodMaker.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Class::MethodMaker qw();
	my($object)=Meta::Class::MethodMaker->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class extends Class::MethodMaker (see that classes documentation)
and adds some capabilities to it.

=head1 FUNCTIONS

	print($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<print($$)>

This method will auto-generate a print method.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
