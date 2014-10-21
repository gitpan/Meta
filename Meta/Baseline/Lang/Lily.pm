#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Lang::Lily;

use strict qw(vars refs subs);
use Meta::Baseline::Lang qw();
use Meta::Tool::Lilypond qw();

our($VERSION,@ISA);
$VERSION="0.30";
@ISA=qw(Meta::Baseline::Lang);

#sub c2chec($);
#sub c2midi($);
#sub c2texx($);
#sub c2psxx($);
#sub c2dvix($);
#sub c2deps($);
#sub my_file($$);
#sub TEST($);

#__DATA__

sub c2chec($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2chec($buil));
}

sub c2midi($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2midi($buil));
}

sub c2texx($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2texx($buil));
}

sub c2psxx($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2psxx($buil));
}

sub c2dvix($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2dvix($buil));
}

sub c2deps($) {
	my($buil)=@_;
	return(Meta::Tool::Lilypond::c2deps($buil));
}

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^lily\/.*\.ly$/) {
		return(1);
	}
	return(0);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Baseline::Lang::Lily - doing Lilypond specific stuff in the baseline.

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

	MANIFEST: Lily.pm
	PROJECT: meta
	VERSION: 0.30

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Lang::Lily qw();
	my($resu)=Meta::Baseline::Lang::Lily::env();

=head1 DESCRIPTION

This package contains stuff specific to Lilypond in the baseline:
0. verification.
1. compilation to postscript, midi, dvi, tex.
2. authorization for lilypond files to enter the baseline.
This package uses the Lilypond tool to do it's thing.

=head1 FUNCTIONS

	c2chec($)
	c2midi($)
	c2texx($)
	c2psxx($)
	c2dvix($)
	c2deps($)
	my_file($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<c2chec($)>

This routine verifies the lilypond source.
Currently it does nothing.
This method returns an error code.

=item B<c2midi($)>

This routine will convert lilypond files to midi files.
This method returns an error code.

=item B<c2texx($)>

This routine will convert lilypond files to tex.
This method returns an error code.

=item B<c2psxx($)>

This routine will convert lilypond files to Postscript.
This method returns an error code.

=item B<c2dvix($)>

This routine will convert lilypond files to Dvi format.
This method returns an error code.

=item B<c2deps($)>

This method will convert lilypond source files to dependency listings.
This method returns an error code.

=item B<my_file($$)>

This method will return true if the file received should be handled by this
module.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Meta::Baseline::Lang(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV spelling change
	0.01 MV make lilypond work
	0.02 MV lilypond stuff
	0.03 MV more organization
	0.04 MV perl quality change
	0.05 MV perl code quality
	0.06 MV more perl quality
	0.07 MV more perl quality
	0.08 MV get basic Simul up and running
	0.09 MV perl documentation
	0.10 MV more perl quality
	0.11 MV perl qulity code
	0.12 MV more perl code quality
	0.13 MV revision change
	0.14 MV better general cook schemes
	0.15 MV revision for perl files and better sanity checks
	0.16 MV languages.pl test online
	0.17 MV add rtf format to website,work on papers,add dtd lang
	0.18 MV pics with db support
	0.19 MV perl packaging
	0.20 MV BuildInfo object change
	0.21 MV md5 project
	0.22 MV database
	0.23 MV perl module versions in files
	0.24 MV movies and small fixes
	0.25 MV thumbnail user interface
	0.26 MV more thumbnail issues
	0.27 MV website construction
	0.28 MV web site development
	0.29 MV web site automation
	0.30 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Lang(3), Meta::Tool::Lilypond(3), strict(3)

=head1 TODO

None.
