#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Sgmlcheck;

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.07";
@ISA=qw();

#sub check($$);

#__DATA__

sub check($$) {
	my($file,$path)=@_;
	my($prog)="sgmlcheck";
	my(@args);
	push(@args,$file);
	my($text);
	my($code)=Meta::Utils::System::system_err_nodie(\$text,$prog,\@args);
	if(!$code) {
		Meta::Utils::Output($text);
	} else {
		if($text ne "") {
			Meta::Utils::Output($text);
			$code=0;
		}
	}
	return($code);
}

1;

__END__

=head1 NAME

Meta::Tool::Sgmlcheck - run sgmlcheck for you (from sgmltools).

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

	MANIFEST: Sgmlcheck.pm
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Sgmlcheck qw();
	my($object)=Meta::Tool::Sgmlcheck->new();
	my($result)=$object->method();

=head1 DESCRIPTION

Put a lot of documentation here to show what your class does.

=head1 FUNCTIONS

	check($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<check($$)>

This is a constructor for the Meta::Tool::Sgmlcheck object.

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
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
