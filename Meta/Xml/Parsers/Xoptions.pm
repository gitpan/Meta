#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Xoptions;

use strict qw(vars refs subs);
use XML::Parser qw();
use Meta::Utils::Xoptions qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw(XML::Parser::Expat);

#sub new($);
#sub get_result($);
#sub handle_char($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=XML::Parser::Expat->new();
	$self->{RESULT}=Meta::Utils::Xoptions->new();
	if(!$self) {
		Meta::Utils::System::die("didn't get a parser");
	}
	$self->setHandlers(
		"Char"=>\&handle_char,
	);
	bless($self,$clas);
	return($self);
}

sub get_result($) {
	my($self)=@_;
	return($self->{RESULT});
}

sub handle_char($$) {
	my($self,$elem)=@_;
	my($context)=join(".",$self->context());
	$self->{RESULT}->insert($context,$elem);
}

1;

__END__

=head1 NAME

Meta::Xml::Parsers::Xoptions - Object to parse XML option files.

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

	MANIFEST: Xoptions.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Xoptions qw();
	my($dbdef)=Meta::Xml::Parsers::Xoptions->new();
	$dbdef->parsefile($file);
	my($num_table)=$syntax->num_table();

=head1 DESCRIPTION

This object will create a Meta::Utils::Xoptions for you from an xml definition
for a database structure. The object extends the XML::Parser object and
overrides parsing handles to achieve what it does.
The reason we dont inherit from XML::Parser is that the parser which actually
gets passed to the handlers is XML::Parser::Expat (which is the low level
object) and we inherit from that to get more object orientedness.

=head1 FUNCTIONS

	new($)
	get_result($)
	handle_char($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a parser.

=item B<get_result($)>

This method retrieves the result of the parsing process.

=item B<handle_char($$)>

This will handle actual text.
This currently, according to context, sets attributes for the various objects.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl reorganization
	0.01 MV real deps for docbook files
	0.02 MV fix up xml parsers
	0.03 MV perl packaging
	0.04 MV more perl packaging
	0.05 MV md5 project
	0.06 MV database
	0.07 MV perl module versions in files
	0.08 MV movies and small fixes
	0.09 MV thumbnail user interface
	0.10 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
