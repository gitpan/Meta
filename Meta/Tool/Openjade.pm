#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Openjade - run open jade for various stuff.

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

MANIFEST: Openjade.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Openjade qw();>
C<my($object)=Meta::Tool::Openjade->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module will hide the complexity of running Openjade from you.
This is the best way to work with sgml and not use other types of
wrapper like sgmltools sgmltools-lite sgml2x docbook-utils etc...
Openjade also supplies an sgml2xml converter and we use it.

=head1 EXPORTS

C<c2psxx($)>
C<c2txtx($)>
C<c2html($)>
C<c2rtfx($)>
C<c2mifx($)>
C<c2pdfx($)>
C<c2xmlx($)>
C<c2some($)>

=cut

package Meta::Tool::Openjade;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::Output qw();
use Meta::Utils::System qw();
use Meta::Baseline::Utils qw();
use Meta::Baseline::Aegis qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub c2psxx($);
#sub c2txtx($);
#sub c2html($);
#sub c2rtfx($);
#sub c2mifx($);
#sub c2pdfx($);
#sub c2xmlx($);
#sub c2some($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<c2psxx($)>

This will run open jade and will convert it to postscript.

=cut

sub c2psxx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2txtx($)>

This will run open jade and will convert it to plain text.

=cut

sub c2txtx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2html($)>

This will run open jade and will convert it to a single html file.

=cut

sub c2html($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2rtfx($)>

This will run open jade and will convert it to a single rtf file.

=cut

sub c2rtfx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2mifx($)>

This will run open jade and will convert it to a single mif file.

=cut

sub c2mifx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2pdfx($)>

This will run open jade on the given SGML file and will convert it to PDF
(Portable Documentation Format from Adobe) format.

=cut

sub c2pdfx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

=item B<c2xmlx($)>

This method will convert SGML input to XML.

=cut

sub c2xmlx($) {
	my($buil)=@_;
	Meta::Baseline::Utils::xmlfile_emblem($buil->get_targ());
	return(1);
}

=item B<c2some($)>

This will run open jade and will convert sgml to several formats.

=cut

sub c2some($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($modu)=$buil->get_modu();
	my($targ)=$buil->get_targ();
	my($path)=$buil->get_path();
	my($prog)="openjade";
	my(@args);
	#use the tex backend
	push(@args,"-Vtex-backend");
	my(@pths)=split(':',$path);
	for(my($i)=0;$i<=$#pths;$i++) {
		my($curr)=$pths[$i];
		# where to find dtd catalogs
		my($cata)=$curr."/dtdx/CATALOG";
		if(-f $cata) {
			push(@args,"-c",$cata);
		}
		# where to find docbook include files
		my($dtdx)=$curr."/chun";
		if(-d $dtdx) {
			push(@args,"-D",$dtdx);
		}
	}
	#where is the print dsl
	my($dsl)=Meta::Baseline::Aegis::which("dslx/print.dsl");
	push(@args,"-d",$dsl);
	#output type is tex
	push(@args,"-t","tex");
	#what is the output file
	push(@args,"-o",$targ);
	#warn of all things
	push(@args,"-Wall");
	push(@args,$srcx);
	my($text);
	#Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	my($scod)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	if(!$scod) {
		Meta::Utils::Output::print($text);
	} else {
		#filter $text here to see if there are any other errros
		my($prog)="tex";
		my(@args);
		push(@args,"&pdfjadetex");
		push(@args,$targ);
		my($text);
		Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
		Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
		Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
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

-use the -w option when running openjade to get warnings.

=cut
