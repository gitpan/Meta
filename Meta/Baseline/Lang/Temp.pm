#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Lang::Temp;

use strict qw(vars refs subs);
use Meta::Baseline::Utils qw();
use Template qw();
use Meta::Baseline::Aegis qw();
use Meta::Tool::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.11";
@ISA=qw(Meta::Baseline::Lang);

#sub c2chec($);
#sub c2deps($);
#sub c2some($);
#sub my_file($$);

#__DATA__

sub c2chec($) {
	my($buil)=@_;
	my($resu)=1;
	if($resu) {
		Meta::Baseline::Utils::file_emblem($buil->get_targ());
	}
	return($resu);
}

sub c2deps($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

sub c2some($) {
	my($buil)=@_;
	my($template)=Template->new(
		INCLUDE_PATH=>Meta::Baseline::Aegis::search_path(),
		RELATIVE=>1,
		ABSOLUTE=>1,
	);
	my($modu)=$buil->get_modu();
	my($author_obje)=Meta::Info::Author::new_deve("xmlx/author/author.xml");
	my($copy)=$author_obje->get_html_copyright();
	my($vars)={
		"docbook_revhistory"=>Meta::Tool::Aegis::history($modu)->docbook_revhistory(),
		"docbook_edition"=>Meta::Tool::Aegis::history($modu)->docbook_edition(),
		"docbook_date"=>Meta::Tool::Aegis::history($modu)->docbook_date(),
		"html_last"=>Meta::Tool::Aegis::history($modu)->html_last(),
		"html_copyright"=>"<p><small>".$copy."</small></p>",
	};
	my($scod)=$template->process($buil->get_srcx(),$vars,$buil->get_targ());
	return($scod);
}

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^temp\/.*\.temp$/) {
		return(1);
	}
	return(0);
}

1;

__END__

=head1 NAME

Meta::Baseline::Lang::Temp - doing Template specific stuff in the baseline.

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

	MANIFEST: Temp.pm
	PROJECT: meta
	VERSION: 0.11

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Lang::Temp qw();
	my($resu)=Meta::Baseline::Lang::Temp::env();

=head1 DESCRIPTION

This package contains stuff specific to Templates in the baseline:
0. Checks the template files.
1. Created dependencies for the template files.
2. Converts the template files to docbook documents.

=head1 FUNCTIONS

	c2chec($)
	c2deps($)
	c2some($)
	my_file($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<c2chec($)>

This routine verifies template source files.
Currently it does nothing.

=item B<c2deps($)>

This routine will print out dependencies in cook fashion for template sources.
Currently it does nothing.

=item B<c2some($)>

This routine will convert Template files to DocBook files.
Currently it does nothing.

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV Revision in DocBook files stuff
	0.01 MV PDMT stuff
	0.02 MV C++ and temp stuff
	0.03 MV perl packaging
	0.04 MV BuildInfo object change
	0.05 MV md5 project
	0.06 MV database
	0.07 MV perl module versions in files
	0.08 MV movies and small fixes
	0.09 MV thumbnail user interface
	0.10 MV more thumbnail issues
	0.11 MV md5 project

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
