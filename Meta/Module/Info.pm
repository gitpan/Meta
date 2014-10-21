#!/bin/echo This is a perl module and should not be run

package Meta::Module::Info;

use strict qw(vars refs subs);
use Module::Info qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(Module::Info);

#sub modules_used($);
#sub TEST($);

#__DATA__

sub modules_used($) {
	my($self)=@_;
	my(@list)=$self->SUPER::modules_used();
	my(@sorted_list)=CORE::sort(@list);
	return(@sorted_list);
}

sub TEST($) {
	my($context)=@_;
	my($object)=Meta::Module::Info->new_from_file(Meta::Baseline::Aegis::which("perl/lib/Meta/Module/Info.pm"));
	my(@list)=$object->modules_used();
	#now check the list
	return(1);
}

1;

__END__

=head1 NAME

Meta::Module::Info - extend Module::Info.

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

	MANIFEST: Info.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Module::Info qw();
	my($object)=Meta::Module::Info->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module is here to extend the capablities of the CPAN module Module::Info.

First reason that I need this is that Module::Info returns same lists but in
different order when using the modules_used and similar methods according to
context at which the method was used which is bad (not consistant behaviour).

Other extensions may follow.

=head1 FUNCTIONS

	modules_used($)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<modules_used($)>

This method overrides the original Module::Info implementation of it and sorts
the result so the result returned is always consistant regardless of module
usage pattern used before running the method (for consistency sake).

=item B<TEST($)>

This is a testing suite for the Meta::Module::Info module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

=back

=head1 SUPER CLASSES

Module::Info(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV SEE ALSO section fix

=head1 SEE ALSO

Module::Info(3), strict(3)

=head1 TODO

Nothing.
