#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Baseline::Lang::Sgml - doing Sgml specific stuff in the baseline.

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

MANIFEST: Sgml.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Baseline::Lang::Sgml qw();>
C<my($resu)=Meta::Baseline::Lang::Sgml::env();>

=head1 DESCRIPTION

This package contains stuff specific to Sgml in the baseline:
0. verifies docbook source files using nsgmls/onsgmls/DOM.
1. converts docbook sources to various formats (postscript,Rtf,Pdf,Dvi,HTML,
	multi HTML,plain text,Tex etc...) using various tools (jade,openjade,
	sgmltools,sgml2).
2. authorizes entry for docbook sources into the baseline.

It is better to do convertions directly through openjade and not through tools
for which the API is not yet stable like sgmltools or others.

=head1 EXPORTS

C<c2chec($)>
C<c2deps($)>
C<c2texx($)>
C<c2dvix($)>
C<c2psxx($)>
C<c2txtx($)>
C<c2html($)>
C<c2rtfx($)>
C<c2manx($)>
C<c2mifx($)>
C<c2info($)>
C<c2pdfx($)>
C<c2chun($)>
C<c2xmlx($)>
C<c2late($)>
C<c2lyxx($)>
C<c2gzxx($)>
C<my_file($$)>

=cut

package Meta::Baseline::Lang::Sgml;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Baseline::Utils qw();
use Meta::Baseline::Lang qw();
use Meta::Tool::Onsgmls qw();
use Meta::Tool::Aspell qw();
use Meta::Tool::Sgmltoolslite qw();
use Meta::Tool::Sgmltools qw();
use Meta::Lang::Xml qw();
use Meta::Lang::Sgml qw();
use Meta::Baseline::Cook qw();
use Meta::Tool::Sgml2 qw();
use Meta::Tool::Docbook2 qw();
use Meta::Tool::Openjade qw();
use Meta::Tool::Gzip qw();

#tools that we are currently not using
#use Meta::Tool::Jade qw();
#use Meta::Tool::Nsgmls qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Baseline::Lang);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub c2chec($);
#sub c2deps($);
#sub c2texx($);
#sub c2dvix($);
#sub c2psxx($);
#sub c2txtx($);
#sub c2html($);
#sub c2rtfx($);
#sub c2manx($);
#sub c2mifx($);
#sub c2info($);
#sub c2pdfx($);
#sub c2chun($);
#sub c2xmlx($);
#sub c2late($);
#sub c2lyxx($);
#sub c2gzxx($);
#sub my_file($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<c2chec($)>

This routine verifies docbook sources using the following methods:
0. runs nsgmls on it and checks the result.

=cut

sub c2chec($) {
	my($buil)=@_;
	my($resu)=1;
	#my($cod0)=Meta::Tool::Nsgmls::dochec($buil->get_srcx(),$buil->get_path());
	#if(!$cod0) {
	#	$resu=0;
	#}
	my($cod1)=Meta::Tool::Onsgmls::dochec($buil);
	if(!$cod1) {
		$resu=0;
	}
	my($cod2)=Meta::Tool::Aspell::checksgml($buil);
	if(!$cod2) {
		$resu=0;
	}
	my($cod3)=Meta::Tool::Sgmltoolslite::check($buil);
	if(!$cod3) {
		$resu=0;
	}
	if($resu) {
		Meta::Baseline::Utils::file_emblem($buil->get_targ());
	}
	return($resu);
}

=item B<c2deps($)>

This routine will print out dependencies in cook fashion for docbook sources.
It will use other perl module to do that (scan the external entities used
and print paths to them).
Currently it does nothing.

=cut

sub c2deps($) {
	my($buil)=@_;
	my($deps)=Meta::Lang::Sgml::c2deps($buil->get_modu(),$buil->get_srcx());
	Meta::Baseline::Cook::print_deps($deps,$buil->get_targ());
}

=item B<c2texx($)>

This routine will convert DocBook files to Tex.

=cut

sub c2texx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2texx($buil));
#	return(Meta::Tool::Openjade::c2texx($buil));
}

=item B<c2dvix($)>

This routine will convert sgml DocBook files to Dvi.

=cut

sub c2dvix($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2dvix($buil));
#	return(Meta::Tool::Openjade::c2dvix($buil));
}

=item B<c2psxx($)>

This routine will convert sgml DocBook files to Postscript.

=cut

sub c2psxx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2psxx($buil));
#	return(Meta::Tool::Openjade::c2psxx($buil));
}

=item B<c2txtx($)>

This routine will convert sgml DocBook files to text.

=cut

sub c2txtx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2txtx($buil));
#	return(Meta::Tool::Openjade::c2txtx($buil));
}

=item B<c2html($)>

This routine will convert sgml DocBook files to Html.

=cut

sub c2html($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2html($buil));
#	return(Meta::Tool::Openjade::c2html($buil));
}

=item B<c2rtfx($)>

This routine will convert sgml DocBook files to Rtf.

=cut

sub c2rtfx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2rtfx($buil));
#	return(Meta::Tool::Openjade::c2rtfx($buil));
}

=item B<c2manx($)>

This routine will convert sgml DocBook files to manual page format.

=cut

sub c2manx($) {
	my($buil)=@_;
	return(Meta::Tool::Docbook2::c2manx($buil));
}

=item B<c2mifx($)>

This routine will convert sgml DocBook files to Mif.

=cut

sub c2mifx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2mifx($buil));
#	return(Meta::Tool::Openjade::c2mifx($buil));
}

=item B<c2info($)>

This routine will convert sgml DocBook files to GNU info.

=cut

sub c2info($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltools::c2info($buil));
#	return(Meta::Tool::Sgmltoolslite::c2info($buil));
#	return(Meta::Tool::Sgml2::c2info($buil));
#	return(Meta::Tool::Openjade::c2info($buil));
}

=item B<c2pdfx($)>

This routine will convert sgml DocBook files to Pdf (Portable Documentation
Format from Adobe).

=cut

sub c2pdfx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltoolslite::c2pdfx($buil));
#	return(Meta::Tool::Openjade::c2pdfx($buil));
}

=item B<c2chun($)>

This routine will convert sgml DocBook files to files without DocBook headers
in them (DOCTYPE) etc... so they chould be included as chunks for other documents.

=cut

sub c2chun($) {
	my($buil)=@_;
	return(Meta::Lang::Xml::c2chun($buil));
}

=item B<c2xmlx($)>

This routine will convert DocBook files to XML.

=cut

sub c2xmlx($) {
	my($buil)=@_;
	return(Meta::Tool::Openjade::c2xmlx($buil));
}

=item B<c2late($)>

This will convert DocBook files to Latex.

=cut

sub c2late($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltools::c2late($buil));
}

=item B<c2lyxx($)>

This will convert DocBook files to LyX.

=cut

sub c2lyxx($) {
	my($buil)=@_;
	return(Meta::Tool::Sgmltools::c2lyxx($buil));
}

=item B<c2gzxx($)>

This will convert DocBook files to compressed docbook files.

=cut

sub c2gzxx($) {
	my($buil)=@_;
	return(Meta::Tool::Gzip::c2gzxx($buil));
}

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=cut

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^sgml\/.*\.sgml$/) {
		return(1);
	}
	return(0);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
1	Sun Jan 14 02:26:10 2001	MV	introduce docbook into the baseline
2	Thu Jan 18 01:55:38 2001	MV	spelling change
3	Sun Jan 21 21:38:59 2001	MV	remove sandbox
4	Sat Jan 27 19:56:28 2001	MV	perl quality change
5	Sun Jan 28 02:34:56 2001	MV	perl code quality
6	Sun Jan 28 13:51:26 2001	MV	more perl quality
7	Mon Jan 29 20:54:18 2001	MV	chess and code quality
7	Tue Jan 30 03:03:17 2001	MV	more perl quality
8	Wed Jan 31 15:28:22 2001	MV	get basic Simul up and running
9	Wed Jan 31 19:51:08 2001	MV	get papers in good condition
10	Sat Feb  3 03:39:36 2001	MV	make all papers papers
11	Sat Feb  3 23:41:08 2001	MV	perl documentation
12	Sun Feb  4 10:05:44 2001	MV	get graph stuff going
13	Mon Feb  5 03:21:02 2001	MV	more perl quality
14	Tue Feb  6 01:04:52 2001	MV	perl qulity code
15	Tue Feb  6 07:02:13 2001	MV	more perl code quality
16	Tue Feb  6 22:19:51 2001	MV	revision change
17	Thu Feb  8 22:43:16 2001	MV	pictures in docbooks
18	Fri Feb  9 09:22:45 2001	MV	revision for perl files and better sanity checks
19	Sun Feb 11 04:08:15 2001	MV	languages.pl test online
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-add the following sanity check to c2chec: that I never use sect1, sect2 etc but rather use <section> (the better way). Are there any other things I may want to check ? the KDE team said they have a restricted version of docbook that they use - check it out. Should I do it in Lang::Sgml or what ?!?

=cut
