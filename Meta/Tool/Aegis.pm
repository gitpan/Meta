#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Aegis;

use strict qw(vars refs subs);
use Meta::Revision::Revision qw();
use Meta::Revision::Entry qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.16";
@ISA=qw();

#sub history($);
#sub history_add($);
#sub TEST($);

#__DATA__

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

sub history_add($) {
	my($file)=@_;
	my($revision)=history($file);
	my($curr)=Meta::Revision::Entry->new();
	$curr->set_number($revision->size());
	$curr->set_initials("MV");
	$curr->set_remark(Meta::Baseline::Aegis::change_description());
	$revision->push($curr);
	return($revision);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Tool::Aegis - tool to ease interaction with Aegis.

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

	MANIFEST: Aegis.pm
	PROJECT: meta
	VERSION: 0.16

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Aegis qw();
	my($object)=Meta::Tool::Aegis->new();
	my($revision)=$object->history("config");

=head1 DESCRIPTION

This module will enable you to interact with Aegis cleanly and will hide
the complexity of doing so from you.

=head1 FUNCTIONS

	history($)
	history_add($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<history($)>

This method will return a Meta::Revision::Revision object representing the
revisions of the module supplied to it.

=item B<history_add($)>

This method is the same as the history method above except it also
adds the current change into the list.

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

	0.00 MV better general cook schemes
	0.01 MV languages.pl test online
	0.02 MV history change
	0.03 MV more c++ stuff
	0.04 MV Revision in DocBook files stuff
	0.05 MV PDMT stuff
	0.06 MV C++ and temp stuff
	0.07 MV perl packaging
	0.08 MV md5 project
	0.09 MV database
	0.10 MV perl module versions in files
	0.11 MV movies and small fixes
	0.12 MV thumbnail user interface
	0.13 MV more thumbnail issues
	0.14 MV website construction
	0.15 MV web site automation
	0.16 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Revision::Entry(3), Meta::Revision::Revision(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

-add to my special report a feature to also print the name of the developer doing the change and add that to the parsing here and translate it to the initials instead of the current hardcoded stuff.

-if the file is in the current change then print another entry. (should that be
	in the report ?)

-use my text parser here (will be more stream lined).

-the add method is not exactly correct (has hardcodings).

-remove the MV which is hardcoded here.
