#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Aegis - tool to ease interaction with Aegis.

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

MANIFEST: Aegis.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Aegis qw();>
C<my($object)=Meta::Tool::Aegis->new();>
C<my($revision)=$object->history("config");>

=head1 DESCRIPTION

This module will enable you to interact with Aegis cleanly and will hide
the complexity of doing so from you.

=head1 EXPORTS

C<history($)>

=cut

package Meta::Tool::Aegis;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Revision::Revision qw();
use Meta::Revision::Entry qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub history($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<history($)>

This method will return a Meta::Revision::Revision object representing the
revisions of the module supplied to it.

=cut

sub history($) {
	my($file)=@_;
	my(@args);
	my($prog)="aegis";
	push(@args,"-Report");
	push(@args,"-File");
	push(@args,Meta::Baseline::Aegis::which("aegi/repo/file_hstry.rpt"));
	push(@args,$file);
	push(@args,"-TERse");
	my($text)=Meta::Utils::System::system_out($prog,\@args);
#	Meta::Utils::Output::print("text is [".$$text."]\n");
	my(@lines)=split("\n",$$text);
	my($revision)=Meta::Revision::Revision->new();
	for(my($i)=0;$i<=$#lines;$i++) {
		my($line)=$lines[$i];
#		Meta::Utils::Output::print("line is [".$line."]\n");
		my($type,$action,$delta,$weekday,$month,$day,$hour,$year,$change,$number,$remark)=
			($line=~/^(\w+) (\w+) (\d+) (\w+) (\w+) *(\d+) (\d\d:\d\d:\d\d) (\d+) (\d+) (\d+|current) (.*)$/);
		my($date)=join(" ",$weekday,$month,$day,$hour,$year);
		my($initials)="MV";
		my($curr)=Meta::Revision::Entry->new();
		$curr->set_number($number);
		$curr->set_date($date);
		$curr->set_initials($initials);
		$curr->set_remark($remark);
		$curr->set_action($action);
		$curr->set_change($change);
		$curr->set_delta($delta);
		$revision->push($curr);
	}
	return($revision);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Thu Feb  8 00:23:21 2001	MV	betern general cook schemes
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add to my special report a feature to also print the name of the developer doing the change and add that to the parsing here and translate it to the initials instead of the current hardcoded stuff.

-if the file is in the current change then print another entry. (should that be
	in the report ?)

-use my text parser here (will be more stream lined).

=cut
