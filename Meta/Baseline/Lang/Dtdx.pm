#!/bin/echo This is a perl module and should not be run

package Meta::Baseline::Lang::Dtdx;

use strict qw(vars refs subs);
use Meta::Baseline::Lang qw();
use Meta::Baseline::Utils qw();
use XML::Doctype qw();
use File::Basename qw();

our($VERSION,@ISA);
$VERSION="0.14";
@ISA=qw(Meta::Baseline::Lang);

#sub c2deps($);
#sub c2chec($);
#sub c2html($);
#sub my_file($$);

#__DATA__

sub c2deps($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

sub c2chec($) {
	my($buil)=@_;
	my($dtd)=XML::Doctype->new();
	my($base,$path,$suffix)=File::Basename::fileparse($buil->get_srcx(),"\.dtd");
	my($res)=$dtd->parse_dtd_file($base,$buil->get_srcx());
	if($res) {
		Meta::Baseline::Utils::file_emblem($buil->get_targ());
	}
	return($res);
}

sub c2html($) {
	my($buil)=@_;
	Meta::Baseline::Utils::file_emblem($buil->get_targ());
	return(1);
}

sub my_file($$) {
	my($self,$file)=@_;
	if($file=~/^dtdx\/.*\.dtd$/) {#actual dtd files
		return(1);
	}
	if($file=~/^dtdx\/.*\.cat$/) {#dtd catalogs
		return(1);
	}
	if($file=~/^dtdx\/.*\.ent$/) {#dtd entities
		return(1);
	}
	if($file=~/^dtdx\/.*\.mod$/) {#dtd modules
		return(1);
	}
	if($file=~/^dtdx\/.*\.gml$/) {#general markup language
		return(1);
	}
	if($file=~/^dtdx\/.*\.dcl$/) {#dtd declarations
		return(1);
	}
	if($file eq "dtdx/CATALOG") {#main catalogs
		return(1);
	}
	return(0);
}

1;

__END__

=head1 NAME

Meta::Baseline::Lang::Dtdx - handle DTDs in the project.

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

	MANIFEST: Dtdx.pm
	PROJECT: meta
	VERSION: 0.14

=head1 SYNOPSIS

	package foo;
	use Meta::Baseline::Lang::Dtdx qw();
	my($resu)=Meta::Baseline::Lang::Dtdx::env();

=head1 DESCRIPTION

This package contains stuff specific to Dtdx in the baseline:
Its mainly here to authorize entries of DTD files to the baseline.
Maybe someday I'll do syntax checks on those also...:)

=head1 FUNCTIONS

	c2deps($)
	c2chec($)
	c2html($)
	my_file($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<c2deps($)>

This will convert dtd files to dependencies.

=item B<c2chec($)>

This will check a dtd file.

=item B<c2html($)>

This will convert a dtd file to html format (documenting it).

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

	0.00 MV history change
	0.01 MV add rtf format to website,work on papers,add dtd lang
	0.02 MV introduce docbook xml and docbook deps
	0.03 MV good xml support
	0.04 MV convert dtd to html
	0.05 MV perl packaging
	0.06 MV BuildInfo object change
	0.07 MV XSLT, website etc
	0.08 MV md5 project
	0.09 MV database
	0.10 MV perl module versions in files
	0.11 MV movies and small fixes
	0.12 MV md5 progress
	0.13 MV thumbnail user interface
	0.14 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-get the DTD checking code throught XML::Doctype out of here and into a module.