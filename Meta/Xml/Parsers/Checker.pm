#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Xml::Parsers::Checker - an XML checker class.

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

MANIFEST: Checker.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Xml::Parsers::Checker qw();>
C<my($def_parser)=Meta::Xml::Parsers::Checker->new();>
C<$def_parser->parsefile($file);>
C<my($def)=$def_parser->get_result();>

=head1 DESCRIPTION

This is a Checker class for baseline XML files. The reason
we cannot use the original XML::Checker::Parser is because
of external file resolution which should be done according
to the search path and that is precisely the only method
which is derived here over the regular checker.

=head1 EXPORTS

C<new($)>
C<handle_externent($$$$)>

=cut

package Meta::Xml::Parsers::Checker;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use XML::Checker::Parser qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::File qw();

$VERSION="1.00";
@ISA=qw(Exporter XML::Checker::Parser);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);
#sub handle_externent($$$$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This gives you a new object for a parser.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=XML::Checker::Parser->new();
	if(!$self) {
		Meta::Utils::System::die("didn't get a parser");
	}
	$self->setHandlers(
		'ExternEnt'=>\&handle_externent,
	);
	bless($self,$clas);
	return($self);
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
