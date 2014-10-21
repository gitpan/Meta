#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Lang::Aspe;

use strict qw(vars refs subs);
use Meta::Baseline::Lang qw();

our($VERSION,@ISA);
$VERSION="0.19";
@ISA=qw(Meta::Baseline::Lang);

#sub my_file($$);

#__DATA__

sub my_file($$) {
	my($self,$file)=@_;
	return(0);
}

1;

__END__

=head1 NAME

Meta::Baseline::Lang::Aspe - doing Aspell specific stuff in the baseline.

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

	MANIFEST: Aspe.pm
	PROJECT: meta
	VERSION: 0.19

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Lang::Aspe qw();
	my($resu)=Meta::Baseline::Lang::Aspe::check([params]);

=head1 DESCRIPTION

This package runs aspell in the baseline.

=head1 FUNCTIONS

	my_file($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<my_file($$)>

This method will return true if the file receives is a file which should
be handled by this language.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV spelling change
	0.01 MV perl quality change
	0.02 MV perl code quality
	0.03 MV more perl quality
	0.04 MV more perl quality
	0.05 MV perl documentation
	0.06 MV more perl quality
	0.07 MV perl qulity code
	0.08 MV more perl code quality
	0.09 MV revision change
	0.10 MV better general cook schemes
	0.11 MV revision for perl files and better sanity checks
	0.12 MV languages.pl test online
	0.13 MV perl packaging
	0.14 MV md5 project
	0.15 MV database
	0.16 MV perl module versions in files
	0.17 MV movies and small fixes
	0.18 MV thumbnail user interface
	0.19 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
