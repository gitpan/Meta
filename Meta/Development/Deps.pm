#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Development::Deps - what does your module/class do.

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

MANIFEST: Deps.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Development::Deps qw();>
C<my($object)=Meta::Development::Deps->new();>

=head1 DESCRIPTION

This is a graph object storing dependency information between files in
a project.

=head1 EXPORTS

C<new($)>

=cut

package Meta::Development::Deps;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);
use Meta::Ds::Graph qw();

$VERSION="1.00";
@ISA=qw(Exporter Meta::Ds::Graph);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub new($);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<new($)>

This is a constructor for the Meta::Development::Deps object.

=cut

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Graph->new();
	bless($self,$clas);
	return($self);
}

1;

=back

=head1 BUGS

None.

=head1 AUTHOR

Mark Veltzer <mark2776@yahoo.com>

=head1 HISTORY

None.

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.

=cut
