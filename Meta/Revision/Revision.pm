#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Revision::Revision - an object representing full revision history.

=head1 COPYRIGHT

Copyright (C) 2001 Mark Veltzer;
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

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Revision::Revision qw();>
C<my($object)=Meta::Revision::Revision->new();>
C<my($result)=$object->printd($xml);>

=head1 DESCRIPTION

This object represents a full revision history of a module.
The object is able to print itself in DocBook xml format.

=head1 EXPORTS

C<new($)>
C<print($$)>
C<string($)>
C<docbook_revhistory_print($$)>
C<docbook_revhistory($)>
C<docbook_edition_print($$)>
C<docbook_edition($)>
C<docbook_date_print($$)>
C<docbook_date($)>
C<html_last_print($$)>
C<html_last($)>

=cut

package Meta::Revision::Revision;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Array qw();
use IO::String qw();
use XML::Writer qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Array);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub print($$);
#sub string($);
#sub docbook_revhistory_print($$);
#sub docbook_revhistory($);
#sub docbook_edition_print($$);
#sub docbook_edition($);
#sub docbook_date_print($$);
#sub docbook_date($);
#sub html_last_print($$);
#sub html_last($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<print($$)>

This method prints the object to a regular file.
The format is debug.

=cut

sub print($$) {
	my($self,$file)=@_;
	print $file "size is [".$self->size()."]\n";
	for(my($i)=0;$i<$self->size();$i++) {
		$self->getx($i)->print($file);
	}
}

=item B<string($)>

This method will create a string representing the current revision information.
The format is perl revision.

=cut

sub string($) {
	my($self)=@_;
	my($retu)="";
	$retu.="start of revision info\n";
	for(my($i)=0;$i<$self->size();$i++) {
		$retu.=$self->getx($i)->string();
	}
	$retu.="end of revision info";
	return($retu);
}

=item B<docbook_revhistory_print($$)>

This method prints the Revision history to an XML file writer.
This format is XML docbook.

=cut

sub docbook_revhistory_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("revhistory");
	for(my($i)=0;$i<$self->size();$i++) {
		$self->getx($i)->printd($writ);
	}
	$writ->endTag("revhistory");
}

=item B<docbook_revhistory($)>

This method will create an XML string representing the current revision information.

=cut

sub docbook_revhistory($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_revhistory_print($writer);
	$io->close();
	return($string);
}

=item B<docbook_edition_print($$)>

This will print the edition information to a XML::Writer type object.

=cut

sub docbook_edition_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("edition");
	my($last)=$self->getx($self->size()-1);
	$writ->characters($last->get_number());
	$writ->endTag("edition");
}

=item B<docbook_edition($)>

This method will create an XML string representing the current edition information.

=cut

sub docbook_edition($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_edition_print($writer);
	$io->close();
	return($string);
}

=item B<docbook_date_print($$)>

This will print the date information to a XML::Writer type object.

=cut

sub docbook_date_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("date");
	my($first)=$self->getx(0);
	$writ->characters($first->get_date());
	$writ->endTag("date");
}

=item B<docbook_date($)>

This method will create an XML string representing the current date information.

=cut

sub docbook_date($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->docbook_date_print($writer);
	$io->close();
	return($string);
}

=item B<html_last_print($$)>

This will print a "page last modified at" html notice.

=cut

sub html_last_print($$) {
	my($self,$writ)=@_;
	$writ->startTag("p");
	$writ->startTag("small");
	my($last)=$self->getx($self->size()-1);
	$writ->characters("Page last modified at ".$last->get_date());
	$writ->endTag("small");
	$writ->endTag("p");
}

=item B<html_last($)>

This method will create an XML string representing the last modified information.

=cut

sub html_last($) {
	my($self)=@_;
	my($string);
	my($io)=IO::String->new($string);
	my($writer)=XML::Writer->new(OUTPUT=>$io);
	$self->html_last_print($writer);
	$io->close();
	return($string);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Tue Feb  6 07:02:13 2001	MV	more perl code quality
2	Tue Feb  6 22:19:51 2001	MV	revision change
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
