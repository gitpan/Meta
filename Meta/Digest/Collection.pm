#!/bin/echo This is a perl module and should not be run

package Meta::Digest::Collection;

use strict qw(vars refs subs);
use Meta::Ds::Hash qw();
use Meta::Digest::MD5 qw();

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw();

#sub new($);
#sub add($$$);
#sub add_file($$);
#sub has_file($$);
#sub has_sum($$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{FILES}=Meta::Ds::Hash->new();
	$self->{SUMS}=Meta::Ds::Hash->new();
	return($self);
}

sub add($$$) {
	my($self,$name,$sum)=@_;
	$self->{FILES}->insert($name,$sum);
	$self->{SUMS}->insert($sum,$name);
}

sub add_file($$) {
	my($self,$name)=@_;
	my($sum)=Meta::Digest::MD5::get_filename_digest($name);
	$self->add($name,$sum);
}

sub has_file($$) {
	my($self,$name)=@_;
	return($self->{FILES}->has($name));
}

sub has_sum($$) {
	my($self,$sum)=@_;
	return($self->{SUMS}->has($sum));
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Digest::Collection - a collection of MD5 signatures for files.

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

	MANIFEST: Collection.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Digest::Collection qw();
	my($object)=Meta::Digest::Collection->new();
	$object->add_file("/etc/passwd");

=head1 DESCRIPTION

This object encapsulates a collection of MD5. This collection maps
files to signatures and signatures to maps.

The class is two hashes - one mapping files to sums and the other
mapping sums to files.

=head1 FUNCTIONS

	new($)
	add($$$)
	add_file($$)
	has_file($$)
	has_sum($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Digest::Collection object.

=item B<add($$$)>

This will add a file name and a sum to the map.

=item B<add_file($$)>

Read a file, calculate it's sum and add it to the map.

=item B<has_file($$)>

Return whether the file exists in the collection.

=item B<has_sum($$)>

Return whether the sum exists in the collection.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

None.

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV web site development
	0.01 MV web site automation
	0.02 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Digest::MD5(3), Meta::Ds::Hash(3), strict(3)

=head1 TODO

Nothing.
