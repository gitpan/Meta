#!/bin/echo This is a perl module and should not be run

package Meta::Ds::Enumerated;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.06";
@ISA=qw();

#sub new($);
#sub new_value($$);
#sub get_enum();
#sub set($$);
#sub get($);
#sub TEXT();

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	my($enum)=$self->get_enum();
	$self->{VAL}=$enum->get_default();
	return($self);
}

sub new_value($$) {
	my($clas,$valx)=@_;
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->set($valx);
	return($self);
}

sub get_enum() {
	Meta::Utils::System::die("you shouldnt call this");
	return(undef);
}

sub set($$) {
	my($self,$valx)=@_;
	my($enum)=$self->get_enum();
	$enum->check_elem($valx);
	$self->{VAL}=$valx;
}

sub get($) {
	my($self)=@_;
	return($self->{VAL});
}

sub TEST($) {
	my($context)=@_;
	#my($object)=Meta::Ds::Enumerated->new();
	return(1);
}

1;

__END__

=head1 NAME

Meta::Ds::Enumerated - enumerated class.

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

	MANIFEST: Enumerated.pm
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	package foo;
	use Meta::Ds::Enumerated qw();
	my($object)=Meta::Ds::Enumerated->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class is a base class for inheriting enumerated object which
share a set of values from which they can be assigned.

=head1 FUNCTIONS

	new($)
	new_value($$)
	get_enum($)
	set($$)
	get($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Ds::Enumerated object.

=item B<new_value($$)>

This method will create a new variable initialized to a specific value.

=item B<get_enum()>

This method is the method you should override. The method should
return the Meta::Ds::Enum object which will be used to validate
the values used in this type.

=item B<set($$)>

This method will set the value of the variable.

=item B<get($)>

This method will retrieve the value of the variable.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more thumbnail code
	0.01 MV thumbnail user interface
	0.02 MV import tests
	0.03 MV more thumbnail issues
	0.04 MV website construction
	0.05 MV web site automation
	0.06 MV SEE ALSO section fix

=head1 SEE ALSO

strict(3)

=head1 TODO

Nothing.
