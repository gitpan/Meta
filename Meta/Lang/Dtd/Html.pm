#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Dtd::Html;

use strict qw(vars refs subs);
use XML::Handler::Dtd2Html qw();
use XML::Parser::PerlSAX qw();
use IO::String qw();
#use IO::File qw();
use Meta::Utils::File::File qw();
use Meta::Utils::Output qw();
#use Meta::Lang::Xml::Xml qw();
use Meta::Lang::Xml::Resolver qw();
use Meta::Utils::Utils qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw();

#sub c2html($);
#sub TEST($);

#__DATA__

sub c2html($) {
	my($build)=@_;
	my($modu)=$build->get_modu();
	my($srcx)=$build->get_srcx();
	my($targ)=$build->get_targ();
	my($path)=$build->get_path();
	my($handler)=XML::Handler::Dtd2Html->new();
	my($resolver)=Meta::Lang::Xml::Resolver->new();
	my($parser)=XML::Parser::PerlSAX->new(
		Handler=>$handler,
		EntityResolver=>$resolver,
		ParseParamEnt=>1);
	my($content)=Meta::Utils::File::File::load($srcx);
#	Meta::Utils::Output::print("content is [".$content."]\n");
	my($string)=$content=~m/EMPTY\n([[:ascii:]\n]*)\n-->$/;
	#my($string)=$content=~/This(.*)reference/;
#	Meta::Utils::Output::print("string is [".$string."]\n");
#	my($string)="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE unknown PUBLIC \"-//META//DTD UNKNOWN V1.0//EN\" \"".$srcx."\">";
#	my($io)=IO::String->new($string);
#	my($io)=IO::File->new($srcx,"r");
#	STAM: Meta::Lang::Xml::Xml
	my($opts_f)=undef;# whether you want frames or not
	my($opts_t)="";
	my($opts_C)=1;
#	my($opts_M)=0;
#	my($opts_Z)=0;
	my($doc)=$parser->parse(Source=>{String=>$string});

	my($no_suff_target)=Meta::Utils::Utils::remove_suffix($targ);
	$doc->generateHTML(
		$no_suff_target,#this needs to be without the suffix which is added automatically
		$opts_f,#whether you want frames or not (not)
		$opts_t,#the title
		$opts_C,#translate comments in the body of the dtd (thats the whole point isnt it.
	);
	#	$opts_M,
	#	$opts_Z
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Lang::Dtd::Html - handle conversion of DTDs to HTMLs.

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

	MANIFEST: Html.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Dtd::Html qw();
	my($build)=...
	Meta::Lang::Dtd::Html::c2html($build);

=head1 DESCRIPTION

This module knows how to translate DTD files to html documentation
derived from XML comments embedded in them. It uses XML::Handler::Dtd2Html
to do it's thing.

=head1 FUNCTIONS

	c2html($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<c2html($)>

This is the method which does all of the work.

=item B<TEST($)>

This is a testing suite for the Meta::Lang::Dtd::Html module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

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

	0.00 MV move tests into modules

=head1 SEE ALSO

IO::String(3), Meta::Lang::Xml::Resolver(3), Meta::Utils::File::File(3), Meta::Utils::Output(3), Meta::Utils::Utils(3), XML::Handler::Dtd2Html(3), XML::Parser::PerlSAX(3), strict(3)

=head1 TODO

Nothing.
