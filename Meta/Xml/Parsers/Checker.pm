#!/bin/echo This is a perl module and should not be run

package Meta::Xml::Parsers::Checker;

use strict qw(vars refs subs);
use XML::Checker::Parser qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::File qw();

our($VERSION,@ISA);
$VERSION="0.06";
@ISA=qw(XML::Checker::Parser);

#sub new($);
#sub handle_externent($$$$);

#__DATA__

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

__END__

=head1 NAME

Meta::Xml::Parsers::Checker - an XML checker class.

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

	MANIFEST: Checker.pm
	PROJECT: meta
	VERSION: 0.06

=head1 SYNOPSIS

	package foo;
	use Meta::Xml::Parsers::Checker qw();
	my($def_parser)=Meta::Xml::Parsers::Checker->new();
	$def_parser->parsefile($file);
	my($def)=$def_parser->get_result();

=head1 DESCRIPTION

This is a Checker class for baseline XML files. The reason
we cannot use the original XML::Checker::Parser is because
of external file resolution which should be done according
to the search path and that is precisely the only method
which is derived here over the regular checker.

=head1 FUNCTIONS

	new($)
	handle_externent($$$$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This gives you a new object for a parser.

=item B<handle_externent($$$$)>

This method will handle resolving external references.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging
	0.01 MV md5 project
	0.02 MV database
	0.03 MV perl module versions in files
	0.04 MV movies and small fixes
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
