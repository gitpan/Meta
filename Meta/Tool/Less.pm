#!/bin/echo This is a perl module and should not be run

package Meta::Tool::Less;

use strict qw(vars refs subs);
use Meta::Utils::Utils qw();
use Meta::Utils::File::File qw();
use Meta::Utils::System qw();
use Meta::Utils::File::Remove qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw();

#sub show_file($);
#sub show_data($);

#__DATA__

sub show_file($) {
	my($file)=@_;
	Meta::Utils::System::system("less",["-csi",$file]);
}

sub show_data($) {
	my($data)=@_;
	my($name)=Meta::Utils::Utils::get_temp_file();
	Meta::Utils::File::File::save($name,$data);
	&show_file($name);
	Meta::Utils::File::Remove::rm($name);
}

1;

__END__

=head1 NAME

Meta::Tool::Less - run the less pager for you.

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

	MANIFEST: Less.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Tool::Less qw();
	my($object)=Meta::Tool::Less->new();
	my($result)=$object->method();

=head1 DESCRIPTION

When you want to show something using the less pager don't do it
yourself - give this module the job.

=head1 FUNCTIONS

	show_file($)
	show_data($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<show_file($)>

This method will show a file using the less pager.

=item B<show_data($)>

Pass this method some data and it will show it using the less pager.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV import tests
	0.01 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-is there a way (using some CPAN module?) to feed the string to the less pager without writing it first into a file ?
