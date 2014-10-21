#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Aspell;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Text::Unique qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub checksgml($);
#sub checkhtml($);
#sub checktxt($);

#__DATA__

sub checksgml($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($path)=$buil->get_path();
	my($prog)="aspell";
	my(@args);
	#dont check tags and remarks in sgml - just data
	push(@args,"--mode=sgml");
	#dont run interactivly - just show the wrong spellings
	push(@args,"--list");
	#a personal word list
	push(@args,"--personal",Meta::Baseline::Aegis::which("data/baseline/dict.txt"));
	#the source file to check (has to be stdin)
	push(@args,"< ",$srcx);
	#text to hold errors
	my($text);
	my($scod)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	#aspell should always succeed (yes! even if there were spelling mistakes)
	if(!$scod) {
		Meta::Utils::System::die("strange error");
	}
	my($code);
	#the return code is determined according to the size of the output
	if(length($text)>0) {
		$text=Meta::Utils::Text::Unique::filter($text,"\n");
		Meta::Utils::Output::print("spelling problems:\n");
		Meta::Utils::Output::print($text."\n");
		$code=0;
	} else {
		$code=1;
	}
	return($code);
}

sub checkhtml($) {
	my($buil)=@_;
	return(checksgml($buil));
}

sub checktxt($) {
	my($buil)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Tool::Aspell - run aspell for you to check spelling.

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

	MANIFEST: Aspell.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Aspell qw();
	my($object)=Meta::Tool::Aspell->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module hides the complexity of running aspell on SGML documents
from you.

=head1 FUNCTIONS

	checksgml($)
	checkhtml($)
	checktxt($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<checksgml($)>

This method will check an sgml source file for spell correctness.
It returns a boolean specifiying whether it is correct or not.
There are several problems in aspell:
0. If you dont want it to run interactivly you have to use the --list
	(-l) flag but when using this option you cannot use
	aspell to check a file but only stdin.
1. Aspell's exit code does not imply if the document was correct or
	not. In order to do that you have to check that the output
	list is empty.
At the end, this module uses my Unique module to produce a list of different
words which were not spelled correctly.

Another problem is that Aspell that not recurse into included docbook documents.

=item B<checkhtml($)>

This method will check an HTML file for syntax errors.
Currently it just calls the SGML version because all
our HTML documents are SGML compliant.

=item B<checktxt($)>

This method will check a regular text file.
Currently it is unimplemented and just returns true.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV history change
	0.01 MV spelling and papers
	0.02 MV fix docbook and other various stuff
	0.03 MV perl packaging
	0.04 MV BuildInfo object change
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
