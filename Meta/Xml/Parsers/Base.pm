#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Xml::Parsers::Base - object to derive XML parsers from.

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

MANIFEST: Base.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Xml::Parsers::Base qw();>
C<my($def_parser)=Meta::Xml::Parsers::Base->new();>
C<$def_parser->parsefile($file);>
C<my($def)=$def_parser->get_result();>

=head1 DESCRIPTION

Derive all your XML/Expat parsers from this one.

=head1 EXPORTS

C<new($)>
C<in_context($$$)>
C<in_ccontext($$)>
C<in_abs_context($$$)>
C<in_abs_ccontext($$)>
C<handle_externent($$$$)>

=cut

package Meta::Xml::Parsers::Base;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use XML::Parser::Expat qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::File qw();
use Meta::Utils::Utils qw();

$VERSION="1.00";
@ISA=qw(Exporter XML::Parser::Expat);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub in_context($$$);
#sub in_ccontext($$);
#sub in_abs_context($$$);
#sub in_abs_ccontext($$);
#sub handle_externent($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new object for a parser.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=XML::Parser::Expat->new();
	if(!$self) {
		Meta::Utils::System::die("didn't get a parser");
	}
	$self->setHandlers(
		'ExternEnt'=>\&handle_externent,
	);
	bless($self,$clas);
	return($self);
}

=item B<in_context($$$)>

This method will return true if you are in a postfix context.
This is a service method to derived classes.

=cut

sub in_context($$$) {
	my($self,$stri,$elem)=@_;
	my($context)=join(".",$self->context(),$elem);
#	Meta::Utils::Output::print("checking [".$stri."] [".$context."]\n");
	my($res)=Meta::Utils::Utils::is_suffix($context,$stri);
#	Meta::Utils::Output::print("res is [".$res."]\n");
	return($res);
}

=item B<in_ccontext($$)>

Same as the above in_context except for char handling.

=cut

sub in_ccontext($$) {
	my($self,$stri)=@_;
	my($context)=join(".",$self->context());
#	Meta::Utils::Output::print("checking [".$stri."] [".$context."]\n");
	my($res)=Meta::Utils::Utils::is_suffix($context,$stri);
#	Meta::Utils::Output::print("res is [".$res."]\n");
	return($res);
}

=item B<in_abs_context($$$)>

This method will return true if you are in a specific context.
This is a service method to derived classes.

=cut

sub in_abs_context($$$) {
	my($self,$stri,$elem)=@_;
	my($context)=join(".",$self->context(),$elem);
	return($stri eq $context);
}

=item B<in_abs_ccontext($$)>

Same as the above in_abs_context except for char handling.

=cut

sub in_abs_ccontext($$) {
	my($self,$stri)=@_;
	my($context)=join(".",$self->context());
	return($stri eq $context);
}

=item B<handle_externent($$$$)>

This method will handle resolving external references.

=cut

sub handle_externent($$$$) {
	my($self,$base,$sysi,$pubi)=@_;
	my($find)=Meta::Baseline::Aegis::which($sysi);
	my($data)=Meta::Utils::File::File::load($find);
	#Meta::Utils::Output::print("in handle_externent\n");
	#Meta::Utils::Output::print("base is [".$base."]\n");
	#Meta::Utils::Output::print("sysi is [".$sysi."]\n");
	#Meta::Utils::Output::print("pubi is [".$pubi."]\n");
	return($data);
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