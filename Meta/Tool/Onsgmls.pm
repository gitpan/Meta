#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Tool::Onsgmls - run onsgmls for you.

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

MANIFEST: Onsgmls.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Tool::Onsgmls qw();>
C<my($object)=Meta::Tool::Onsgmls->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

This module will ease the work of running onsgmls for you.

=head1 EXPORTS

C<dochec($)>

=cut

package Meta::Tool::Onsgmls;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();
use Meta::Lang::Docb::Params qw();

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub dochec($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<dochec($)>

This method will check an sgml file using nsgmls and will return a boolean
value according to whether that file is correct.

=cut

sub dochec($) {
	my($buil)=@_;
	my($srcx)=$buil->get_srcx();
	my($path)=$buil->get_path();
	my($prog)="/local/tools/bin/onsgmls";
	my(@args);
	push(@args,"--no-output");#do not use onsgmls as convertor but as checker
	push(@args,"--warning=all");#all warnings
	push(@args,"--warning=no-mixed");#docbook dtds violate this
	push(@args,"--open-elements");#print open elements when printing errors
	push(@args,"--open-entities");#print open entities when printing errors
	my(@lpth)=split(":",$path);
	for(my($i)=0;$i<=$#lpth;$i++) {
		my($curr)=$lpth[$i];
		my($dtdx)=$curr."/dtdx";
		if(-d $dtdx) {
			push(@args,"--directory=".$dtdx);
		}
		my($docb)=$curr."/chun/sgml";
		if(-d $docb) {
			push(@args,"--directory=".$docb);
		}
		my($cata)=$curr."/dtdx/CATALOG";
		if(-f $cata) {
			push(@args,"--catalog=".$cata);
		}
	}
	my(@epth)=split(":",Meta::Lang::Docb::Params::get_extra());
	for(my($i)=0;$i<=$#epth;$i++) {
		my($curr)=$epth[$i];
		my($dtdx)=$curr;
		if(-d $dtdx) {
			push(@args,"--directory=".$dtdx);
		}
		my($cata)=$curr."/CATALOG";
		if(-f $cata) {
			push(@args,"--catalog=".$cata);
		}
	}
	push(@args,$srcx);
	my($text);
#	Meta::Utils::Output::print("args are [".join(",",@args)."]\n");
	my($code)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
#	Meta::Utils::Output::print("text is [".$text."]\n");
	#make sure that no errors are printed (even if exit code is good).
	if($code) {
		if($text ne "") {
			Meta::Utils::Output::print($text);
			$code=0;
		}
	} else {
		Meta::Utils::Output::print($text);
	}
	return($code);
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

-fix the docbook dtd and remove the -wno-mixed flag that I use here to bypass it.

-get the path for onsgmls (/local/tools/bin) out of here and into some external options file.

=cut
