#!/bin/echo This is a perl module and should not be run

package Meta::Revision::Revision;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();
use IO::String qw();
use XML::Writer qw();
use Meta::Math::Pad qw();

our($VERSION,@ISA);
$VERSION="0.16";
@ISA=qw(Meta::Ds::Array);

#sub print($$);
#sub perl_pod($);
#sub perl_current($);
#sub docbook_revhistory_print($$);
#sub docbook_revhistory($);
#sub docbook_edition_print($$);
#sub docbook_edition($);
#sub docbook_date_print($$);
#sub docbook_date($);
#sub html_last_print($$);
#sub html_last($);
#sub TEST($);

#__DATA__

sub print($$) {
	my($self,$file)=@_;
	print $file "size is [".$self->size()."]\n";
	for(my($i)=0;$i<$self->size();$i++) {
		$self->getx($i)->print($file);
	}
}

sub perl_pod($) {
	my($self)=@_;
	my($retu)="";
	#$retu.="start of revision info\n";
	for(my($i)=0;$i<$self->size();$i++) {
		$retu.=$self->getx($i)->perl_pod_line($i);
	}
	#$retu.="end of revision info";
	return($retu);
}

sub perl_current($) {
	my($self)=@_;
	return("0.".Meta::Math::Pad::pad($self->size()-1,2));
}

sub docbook_revhistory_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("revhistory");
	for(my($i)=0;$i<$self->size();$i++) {
		$self->getx($i)->printd($writ);
	}
	$writ->endTag("revhistory");
}

sub docbook_revhistory($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_revhistory_print($writer);
	$io->close();
	return($string);
}

sub docbook_edition_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("edition");
	my($last)=$self->getx($self->size()-1);
	$writ->characters($last->get_number());
	$writ->endTag("edition");
}

sub docbook_edition($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_edition_print($writer);
	$io->close();
	return($string);
}

sub docbook_date_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("date");
	my($first)=$self->getx(0);
	$writ->characters($first->get_date());
	$writ->endTag("date");
}

sub docbook_date($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_date_print($writer);
	$io->close();
	return($string);
}

sub html_last_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("p");
	$writ->startTag("small");
	my($last)=$self->getx($self->size()-1);
	$writ->characters("Page last modified at ".$last->get_date());
	$writ->endTag("small");
	$writ->endTag("p");
}

sub html_last($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->html_last_print($writer);
	$io->close();
	return($string);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Revision::Revision - an object representing full revision history.

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

	MANIFEST: Revision.pm
	PROJECT: meta
	VERSION: 0.16

=head1 SYNOPSIS

	package foo;
	use Meta::Revision::Revision qw();
	my($object)=Meta::Revision::Revision->new();
	my($result)=$object->printd($xml);

=head1 DESCRIPTION

This object represents a full revision history of a module.
The object is able to print itself in DocBook xml format.

=head1 FUNCTIONS

	new($)
	print($$)
	perl_pod($)
	perl_current($)
	docbook_revhistory_print($$)
	docbook_revhistory($)
	docbook_edition_print($$)
	docbook_edition($)
	docbook_date_print($$)
	docbook_date($)
	html_last_print($$)
	html_last($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<print($$)>

This method prints the object to a regular file.
The format is debug.

=item B<perl_pod($)>

This method will create a string representing the current revision information.
The format is perl revision.

=item B<perl_current($)>

This method will return a the current perl module version of the X.YY form.

=item B<docbook_revhistory_print($$)>

This method prints the Revision history to an XML file writer.
This format is XML docbook.

=item B<docbook_revhistory($)>

This method will create an XML string representing the current revision information.

=item B<docbook_edition_print($$)>

This will print the edition information to a XML::Writer type object.

=item B<docbook_edition($)>

This method will create an XML string representing the current edition information.

=item B<docbook_date_print($$)>

This will print the date information to a XML::Writer type object.

=item B<docbook_date($)>

This method will create an XML string representing the current date information.

=item B<html_last_print($$)>

This will print a "page last modified at" html notice.

=item B<html_last($)>

This method will create an XML string representing the last modified information.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Meta::Ds::Array(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV more perl code quality
	0.01 MV revision change
	0.02 MV languages.pl test online
	0.03 MV Revision in DocBook files stuff
	0.04 MV PDMT stuff
	0.05 MV C++ and temp stuff
	0.06 MV perl packaging
	0.07 MV md5 project
	0.08 MV database
	0.09 MV perl module versions in files
	0.10 MV movies and small fixes
	0.11 MV md5 progress
	0.12 MV thumbnail user interface
	0.13 MV more thumbnail issues
	0.14 MV website construction
	0.15 MV web site automation
	0.16 MV SEE ALSO section fix

=head1 SEE ALSO

IO::String(3), Meta::Ds::Array(3), Meta::Math::Pad(3), XML::Writer(3), strict(3)

=head1 TODO

-do we really need the print method here ? (doesnt the array have one like that ?)

-the date method here returns the data of the first edition. Is that right ?
