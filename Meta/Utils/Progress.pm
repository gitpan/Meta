#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Progress;

use strict qw(vars refs subs);
use Class::MethodMaker qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw();

#sub BEGIN();
#sub init($);
#sub start($);
#sub report($);
#sub finish($);

#__DATA__

sub BEGIN() {
	Class::MethodMaker->new_with_init("new");
	Class::MethodMaker->get_set(
		-java=>"_index",
	);
}

sub init($) {
	my($self)=@_;
	$self->set_index(0);
}

sub start($) {
	my($self)=@_;
}

sub report($) {
	my($self)=@_;
	Meta::Utils::Output::print("index is [".$self->get_index()."]\n");
	$self->set_index($self->get_index()+1);
}

sub finish($) {
	my($self)=@_;
	$self->set_index(0);
}

1;

__END__

=head1 NAME

Meta::Utils::Progress - progress reporter which will be enhanced later.

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

	MANIFEST: Progress.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Progress qw();
	my($object)=Meta::Utils::Progress->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is basically an abstract API for a progress repoting device.
Instantiations could be a GTK widget, a text console widget, text
console running numbers or what ever.

=head1 FUNCTIONS

	BEGIN()
	init($)
	start($)
	report($)
	finish($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This method sets up the get/set routines for the following attributes:
index - current progress indicator value.

=item B<init($)>

Initializes the object. Internal method.

=item B<start($)>

Start the progress indication session.

=item B<report($)>

Reports progress.

=item B<finish($)>

Closes the object down.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV dbman package creation
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
