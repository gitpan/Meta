#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Sgml2 - run old sgmltools sgml2 tools.

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

MANIFEST: Sgml2.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Sgml2 qw();>
C<my($object)=Meta::Tool::Sgml2->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module is here to ease the job of running sgmltools for you if
you wish to use them (I think it's better to use the Jade.pm module
which runs jade or openjade directly).

=head1 EXPORTS

C<c2html($$$$)>
C<c2late($$$$)>
C<c2lyxx($$$$)>
C<c2info($$$$)>
C<c2rtfx($$$$)>
C<c2txtx($$$$)>

=cut

package Meta::Tool::Sgml2;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();
use Meta::Baseline::Utils qw();
use Meta::Utils::Output qw();
use Meta::Utils::Text::Lines qw();
use Meta::Utils::File::Copy qw();
use Meta::Utils::File::Remove qw();
use Meta::Utils::File::Move qw();
use Meta::Utils::Utils qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub c2html($$$$);
#sub c2late($$$$);
#sub c2lyxx($$$$);
#sub c2info($$$$);
#sub c2rtfx($$$$);
#sub c2txtx($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<c2html($$$$)>

This routine will convert sgml DocBook files to HTML.

=cut

sub c2html($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	Meta::Baseline::Utils::file_emblem($targ);
	return(1);
}

=item B<c2late($$$$)>

This routine will convert sgml DocBook files to Latex.

=cut

sub c2late($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	Meta::Baseline::Utils::file_emblem($targ);
	return(1);
}

=item B<c2lyxx($$$$)>

This routine will convert sgml DocBook files to Lyx documentation.

=cut

sub c2lyxx($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	Meta::Baseline::Utils::file_emblem($targ);
	return(1);
}

=item B<c2info($$$$)>

This routine will convert sgml DocBook files to GNU info documentation.

=cut

sub c2info($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
#	Meta::Baseline::Utils::file_emblem($targ);
#	return(1);
	my($file)=Meta::Utils::Utils::get_temp_file();
	my($resu)=$file.".info";
	Meta::Utils::File::Copy::copy($srcx,$file);
	my($prog)="sgml2info";
	my(@args);
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
	push(@args,"--pass=\'".join(" ",@dirs)."\'",$file);
	my($text);
	Meta::Utils::Output::print("args are [".CORE::join(",",@args)."]\n");
	Meta::Utils::Utils::chdir("/tmp");
	my($scod)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	if(!$scod) {
		Meta::Utils::Output::print($text);
	} else {
		my($obj)=Meta::Utils::Text::Lines->new();
		$obj->set_text($text,"\n");
		$obj->remove_line_nre("\<OSFD\>");
		$text=$obj->get_text_fixed();
		if($text ne "") {
			$scod=0;
			Meta::Utils::Output::print($text);
			Meta::Utils::File::Remove::rm($file);
			Meta::Utils::File::Remove::rm($resu);
		} else {
			Meta::Utils::File::Move::mv($resu,$targ);
		}
	}
	Meta::Utils::File::Remove::rm($file);
	return($scod);
}

=item B<c2rtfx($$$$)>

This routine will convert sgml DocBook files to RTF (Rich Text Format).

=cut

sub c2rtfx($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	Meta::Baseline::Utils::file_emblem($targ);
	return(1);
}

=item B<c2txtx($$$$)>

This routine will convert sgml DocBook files to plain ASCII text. 

=cut

sub c2txtx($$$$) {
	my($modu,$srcx,$targ,$path)=@_;
	Meta::Baseline::Utils::file_emblem($targ);
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

Nothing.

=cut
