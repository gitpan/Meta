#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Revision::Entry - a single revision of a source file entry.

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

MANIFEST: Entry.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Revision::Entry qw();>
C<my($object)=Meta::Revision::Entry->new();>
C<my($result)=$object->printd($xml);>

=head1 DESCRIPTION

This object represents a single revision entry in a list of revisions
made to a source file. It has a couple of basic elements in it: the
revisors initials, the revision number, the date of the revision and
remarks that accompanied the revision.

=head1 EXPORTS

C<new($)>
C<set_number($$)>
C<get_number($)>
C<set_date($$)>
C<get_date($)>
C<set_initials($$)>
C<get_initials($)>
C<set_remark($$)>
C<get_remark($)>
C<set_action($$)>
C<get_action($)>
C<set_change($$)>
C<get_change($)>
C<set_delta($$)>
C<get_delta($)>
C<print($$)>
C<printd($$)>
C<string($)>

=cut

package Meta::Revision::Entry;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Array);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub set_number($$);
#sub get_number($);
#sub set_date($$);
#sub get_date($);
#sub set_initials($$);
#sub get_initials($);
#sub set_remark($$);
#sub get_remark($);
#sub set_action($$);
#sub get_action($);
#sub set_change($$);
#sub get_change($);
#sub set_delta($$);
#sub get_delta($);
#sub print($$);
#sub printd($$);
#sub string($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This is a constructor for the Meta::Revision::Entry object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{NUMBER}=defined;
	$self->{DATE}=defined;
	$self->{INITIALS}=defined;
	$self->{REMARK}=defined;
	$self->{ACTION}=defined;
	$self->{CHANGE}=defined;
	$self->{DELTA}=defined;
	return($self);
}

=item B<set_number($$)>

This method will set the number of the current revision.

=cut

sub set_number($$) {
	my($self,$valx)=@_;
	$self->{NUMBER}=$valx;
}

=item B<get_number($)>

This method will retrieve the number of the current revision.

=cut

sub get_number($) {
	my($self)=@_;
	return($self->{NUMBER});
}

=item B<set_date($$)>

This method will set the date of the current revision.

=cut

sub set_date($$) {
	my($self,$valx)=@_;
	$self->{DATE}=$valx;
}

=item B<get_date($)>

This method will retrieve the date of the current revision.

=cut

sub get_date($) {
	my($self)=@_;
	return($self->{DATE});
}

=item B<set_initials($$)>

This method will set the initials of the current revision.

=cut

sub set_initials($$) {
	my($self,$valx)=@_;
	$self->{INITIALS}=$valx;
}

=item B<get_initials($)>

This method will retrieve the initials of the current revision.

=cut

sub get_initials($) {
	my($self)=@_;
	return($self->{INITIALS});
}

=item B<set_remark($$)>

This method will set the remark of the current revision.

=cut

sub set_remark($$) {
	my($self,$valx)=@_;
	$self->{REMARK}=$valx;
}

=item B<get_remark($)>

This method will retrieve the remark accompanying the current revision.

=cut

sub get_remark($) {
	my($self)=@_;
	return($self->{REMARK});
}

=item B<set_action($$)>

This method will set the action of the current revision.

=cut

sub set_action($$) {
	my($self,$valx)=@_;
	$self->{ACTION}=$valx;
}

=item B<get_action($)>

This method will retrieve the action of the current revision.

=cut

sub get_action($) {
	my($self)=@_;
	return($self->{ACTION});
}

=item B<set_change($$)>

This method will set the change of the current revision.

=cut

sub set_change($$) {
	my($self,$valx)=@_;
	$self->{CHANGE}=$valx;
}

=item B<get_change($)>

This method will retrieve the change of the current revision.

=cut

sub get_change($) {
	my($self)=@_;
	return($self->{CHANGE});
}

=item B<set_delta($$)>

This method will set the delta of the current revision.

=cut

sub set_delta($$) {
	my($self,$valx)=@_;
	$self->{DELTA}=$valx;
}

=item B<get_delta($)>

This method will retrieve the delta of the current revision.

=cut

sub get_delta($) {
	my($self)=@_;
	return($self->{DELTA});
}

=item B<print($$)>

This method prints the revision object to a regular file.

=cut

sub print($$) {
	my($self,$file)=@_;
	print $file "revnumber is [".$self->get_number()."]\n";
	print $file "date is [".$self->get_date()."]\n";
	print $file "authorinitials is [".$self->get_initials()."]\n";
	print $file "revremark is [".$self->get_remark()."]\n";
	print $file "action is [".$self->get_action()."]\n";
	print $file "change is [".$self->get_change()."]\n";
	print $file "delta is [".$self->get_delta()."]\n";
}

=item B<printd($$)>

This method will print the current object in DocBook XML format using a
writer object received.

=cut

sub printd($$) {
	my($self,$writ)=@_;
	$writ->startTag("revision");
	$writ->startTag("revnumber");
	$writ->characters($self->get_number());
	$writ->endTag("revnumber");
	$writ->startTag("date");
	$writ->characters($self->get_date());
	$writ->endTag("date");
	$writ->startTag("authorinitials");
	$writ->characters($self->get_initials());
	$writ->endTag("authorinitials");
	$writ->startTag("revremark");
	$writ->characters($self->get_remark());
	$writ->endTag("revremark");
	$writ->endTag("revision");
}

=item B<string($)>

This method will return a string representing the entire information for this
entry.

=cut

sub string($) {
	my($self)=@_;
	my($retu)=join("\t",$self->get_number(),$self->get_date(),$self->get_initials(),$self->get_remark())."\n";
	return($retu);
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
3	Thu Feb  8 00:23:21 2001	MV	betern general cook schemes
4	Fri Feb  9 03:09:51 2001	MV	revision in files
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
