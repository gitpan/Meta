#!/bin/echo This is a perl module and should not be run

package Meta::Info::Vcard;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw();

#sub new($);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	return($self);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Info::Vcard - encapsulate VCARD type data manipulation.

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

	MANIFEST: Vcard.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Info::Vcard qw();
	my($object)=Meta::Info::Vcard->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This object is here to encapsulate Vcard type data. It is still not complete
in that it only contains stuff that I know about that is present in Vcard.

Here is how I got to know the Vcard status:
I filled out a full cards in netscape and evolution and saved them as Vcards
and got the format from there.

Services that this class provides:
0. parsing of text of a vcard and populating the object.
1. direct manipulatio of the objects fields.
2. writing of the object in VCARD type format.
3. reading and writing of the object in my own XML/DTD type format.
4. sending the object via sms to GSM type phones using GSM::SMS and others.
5. conversion of this object to various other formats.

=head1 FUNCTIONS

	new($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Info::Vcard object.

=item B<TEXT($)>

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

	0.00 MV web site development
	0.01 MV web site automation
	0.02 MV SEE ALSO section fix

=head1 SEE ALSO

strict(3)

=head1 TODO

-get references to Vcards from the net and work to comply with the entire standard.
