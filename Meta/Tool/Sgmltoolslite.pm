#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Sgmltoolslite - run sgmltools-lite for you.

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

MANIFEST: Sgmltoolslite.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Sgmltoolslite qw();>
C<my($object)=Meta::Tool::Sgmltoolslite->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module is here to ease the job of running sgmltools for you if
you wish to use them (I think it's better to use the Jade.pm module
which runs jade or Openjade.pm which runs openjade directly).

Sgmltoolslite is quite problematic:
1. Sgmltoolslite has a --jade-opt option but you CANT specify several options this
	way - you have to join everything into one thing.

Sgmltoolslite runs openjade by default (it will also run jade but only
if it doesnt find openjade).

=head1 EXPORTS

C<check($)>
C<c2texx($)>
C<c2dvix($)>
C<c2psxx($)>
C<c2txtx($)>
C<c2html($)>
C<c2rtfx($)>
C<c2mifx($)>
C<c2pdfx($)>
C<tool($$$)>

=cut

package Meta::Tool::Sgmltoolslite;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();
use Meta::Utils::Text::Lines qw();
use Meta::Utils::File::Copy qw();
use Meta::Utils::File::Remove qw();
use Meta::Utils::File::Move qw();
use Meta::Utils::Utils qw();
use Meta::Baseline::Utils qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub check($);
#sub c2texx($);
#sub c2dvix($);
#sub c2psxx($);
#sub c2txtx($);
#sub c2html($);
#sub c2rtfx($);
#sub c2mifx($);
#sub c2pdfx($);
#sub tool($$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<check($)>

Run a check on the SGML document using the sgmlcheck utility.

=cut

sub check($) {
	my($buil)=@_;
	return(1);
}

=item B<c2texx($)>

This routine will convert sgml DocBook files to Tex.

=cut

sub c2texx($) {
	my($buil)=@_;
	return(tool($buil,"tex","jadetex"));
}

=item B<c2dvix($)>

This routine will convert sgml DocBook files to Dvi.

=cut

sub c2dvix($) {
	my($buil)=@_;
	return(tool($buil,"dvi","dvi"));
}

=item B<c2psxx($)>

This routine will convert sgml DocBook files to Postscript.

=cut

sub c2psxx($) {
	my($buil)=@_;
	return(tool($buil,"ps","ps"));
}

=item B<c2txtx($)>

This routine will convert sgml DocBook files to Text.

=cut

sub c2txtx($) {
	my($buil)=@_;
	return(tool($buil,"txt","txt"));
}

=item B<c2html($)>

This routine will convert sgml DocBook files to HTML.

=cut

sub c2html($) {
	my($buil)=@_;
	return(tool($buil,"html","onehtml"));
}

=item B<c2rtfx($)>

This routine will convert sgml DocBook files to Rtf (Rich Text Format).

=cut

sub c2rtfx($) {
	my($buil)=@_;
	return(tool($buil,"rtf","rtf"));
}

=item B<c2mifx($)>

This routine will convert sgml DocBook files to Mif (Microsoft Interchange Format).
Currently this does not do the actual convertion because sgml tool do not
support this so it just put an emblem.

=cut

sub c2mifx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	#return(tool($buil,"mif","mif"));
	return(1);
}

=item B<c2pdfx($)>

This routine will convert sgml DocBook files to Pdf (Portable Documentation
Format).
This way of prducing pdfs seems to be broken (I have not been able to see
the resulting pdf using xpdf).
In any case - this backend IS supported by sgmltools altough you cannot see
this in the documentation.

=cut

sub c2pdfx($) {
	my($buil)=@_;
	return(tool($buil,"pdf","pdf"));
}

=item B<tool($$$)>

This is the actual wrapper code. We pass directory search paths to jade
via the option in sgmltools to pass options to jade...:)
The problem is that sgmltools does not allow the option to specify the
output file and so we do all the work using a temporary file and then
move the result.

=cut

sub tool($$$) {
	my($buil,$suff,$back)=@_;
	my($modu)=$buil->get_modu();
	my($srcx)=$buil->get_srcx();
	my($targ)=$buil->get_targ();
	my($path)=$buil->get_path();
	my($file)=Meta::Utils::Utils::get_temp_file();
	my($resu)=$file."\.".$suff;
	Meta::Utils::File::Copy::copy($srcx,$file);
	Meta::Utils::Env::remove("SGML_CATALOG_FILES");
	Meta::Utils::Env::remove("SGML_PATH");
	my($prog)="sgmltools";
	#my($prog)="sgmltools.v1";
	my(@args);
	push(@args,"--backend=".$back);
	#push(@args,"--output=".$back);
	my(@pths)=split(':',$path);
	my(@dirs);
	for(my($i)=0;$i<=$#pths;$i++) {
		my($curr)=$pths[$i];
		#add search directory for entire search path
		my($docb)=$curr."/chun/sgml";
		if(-d $docb) {
			push(@dirs,"-D".$docb);
			#push(@args,"--include".$docb);
		}
		#search for DTDs in the baseline
		my($dtdx)=$curr."/dtdx";
		if(-d $dtdx) {
			push(@dirs,"-D".$dtdx);
			#push(@args,"--include".$dtdx);
		}
		#search for DTDs in the baseline catalog
		my($dtdxcata)=$curr."/dtdx/CATALOG";
		if(-f $dtdxcata) {
			push(@dirs,"-c".$dtdxcata);
			#push(@args,"-c".$dtdxcata);
		}
		#search for DSLs in the baseline
		my($dslx)=$curr."/dslx";
		if(-d $dslx) {
			push(@dirs,"-D".$dslx);
			#push(@args,"--include".$dslx);
		}
		#search for DSLs in the baseline catalog
		my($dslxcata)=$curr."/dslx/CATALOG";
		if(-f $dslxcata) {
			push(@dirs,"-c".$dslxcata);
			#push(@args,"-c".$dslxcata);
		}
	}
	push(@args,"--jade-opt=\'".join(" ",@dirs)."\'",$file);
	my($text);
	#Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	my($scod)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	Meta::Utils::File::Remove::rm($file);
	if(!$scod) {#code is bad (there should be no result but we rm it still)
		Meta::Utils::Output::print($text);
		Meta::Utils::File::Remove::rm_nodie($resu);
	} else {
		my($obj)=Meta::Utils::Text::Lines->new();
		$obj->set_text($text,"\n");
		$obj->remove_line_nre("\<OSFD\>");
		$text=$obj->get_text_fixed();
		if($text ne "") {#code is ok but there is error text
			$scod=0;
			Meta::Utils::Output::print($text);
			Meta::Utils::File::Remove::rm($resu);
		} else {#all is well - code is ok and no error text
			Meta::Utils::File::Move::mv($resu,$targ);
		}
	}
	return($scod);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

start of revision info
end of revision info

=head1 SEE ALSO

Nothing.

=head1 TODO

-how can I stop jade from looking in /usr/lib/sgml and finding junk there ?

-remmember to restore SGML_CATALOG_FILES after invocation.

-do the actual code for c2pdfx

-try to use symlinks instead of the copies here (it will be faster).

-add a C<-o> option to sgmltools so I wont need to bypass them here.

=cut
