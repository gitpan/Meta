#!/bin/echo This is a perl module and should not be run

package Meta::Lang::Cpp::Libs;

use strict qw(vars refs subs);
use Meta::Ds::Graph qw();
use Meta::Xml::Parsers::Graph qw();

our($VERSION,@ISA);
$VERSION="0.08";
@ISA=qw(Meta::Ds::Graph);

#sub new($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($file)=Meta::Baseline::Aegis::which("xmlx/graph/libs.xml");
	my($parser)=Meta::Xml::Parsers::Graph->new();
	$parser->parsefile($file);
	my($self)=$parser->get_result();
	bless($self,$clas);
	return($self);
}

1;

__END__

=head1 NAME

Meta::Lang::Cpp::Libs - handle external library dependencies.

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

	MANIFEST: Libs.pm
	PROJECT: meta
	VERSION: 0.08

=head1 SYNOPSIS

	package foo;
	use Meta::Lang::Cpp::Libs qw();
	my($object)=Meta::Lang::Cpp::Libs->new();

=head1 DESCRIPTION

This class reads, stores and supplies information about external library
dependencies. This will enable you to specify just the external libraries
you really need and this system will resolve the rest.

=head1 FUNCTIONS

	new($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Lang::Cpp::Libs object.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV c++ stuff
	0.01 MV convert dtd to html
	0.02 MV perl packaging
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV movies and small fixes
	0.07 MV thumbnail user interface
	0.08 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
