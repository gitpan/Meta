#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Lang::Texx;

use strict qw(vars refs subs);
use Meta::Baseline::Lang qw();

our($VERSION,@ISA);
$VERSION="0.09";
@ISA=qw(Meta::Baseline::Lang);

#sub my_file($$);

#__DATA__

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^texx\/.*\.tex$/) {
		return(1);
	}
	return(0);
}

1;

__END__

=head1 NAME

Meta::Baseline::Lang::Texx - language for Tex files.

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

	MANIFEST: Texx.pm
	PROJECT: meta
	VERSION: 0.09

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Lang::Texx qw();
	my($resu)=Meta::Baseline::Lang::Texx::env();

=head1 DESCRIPTION

This package contains stuff specific to Tex in the baseline:
Its mainly here to authorize entries of Tex files to the baseline.
Maybe someday I'll do syntax checks on those also...:) or convert them
into something...:)

=head1 FUNCTIONS

	my_file($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV revision in files
	0.01 MV revision for perl files and better sanity checks
	0.02 MV languages.pl test online
	0.03 MV perl packaging
	0.04 MV md5 project
	0.05 MV database
	0.06 MV perl module versions in files
	0.07 MV movies and small fixes
	0.08 MV thumbnail user interface
	0.09 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.