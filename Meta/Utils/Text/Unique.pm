#!/bin/echo This is a perl module and should not be run

=head1 NAME

Meta::Utils::Text::Unique - do the same job as cmd line uniq.

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

MANIFEST: Unique.pm
PROJECT: meta

=head1 SYNOPSIS

C<package foo;>
C<use Meta::Utils::Text::Unique qw();>
C<my($object)=Meta::Utils::Text::Unique->new();>
C<my($result)=$object->method();>

=head1 DESCRIPTION

Give this class some text and it will give you only the unique
lines (no repetitions).

=head1 EXPORTS

C<filter($$)>

=cut

package Meta::Utils::Text::Unique;

use strict qw(vars refs subs);
use Exporter qw();
use vars qw($VERSION @ISA @EXPORT_OK @EXPORT);

$VERSION="1.00";
@ISA=qw(Exporter);
@EXPORT_OK=qw();
@EXPORT=qw();

#sub filter($$);

#__DATA__

=head1 FUNCTION DOCUMENTATION

=over

=item B<filter($$)>

This method gets some text with a delimiter and returns the same text
with the same delimiter with only unique values in it.

=cut

sub filter($$) {
	my($text,$sepa)=@_;
	my(@vals)=split($sepa,$text);
	my(%hash);
	for(my($i)=0;$i<=$#vals;$i++) {
		my($curr)=$vals[$i];
		$hash{$curr}=defined;
	}
	return(join($sepa,keys(%hash)));
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
