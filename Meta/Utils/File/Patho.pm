#!/bin/echo This is a perl module and should not be run

package Meta::Utils::File::Patho;

use strict qw(vars refs subs);
use Meta::Ds::Array qw();
use Meta::Utils::Env qw();
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.02";
@ISA=qw(Meta::Ds::Array);

#sub new($);
#sub new_data($$$);
#sub new_env($$$);
#sub minimize($$$);
#sub exists($$);
#sub resolve($$);
#sub append_data($$$);
#sub check($);
#sub compose($$);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=Meta::Ds::Array->new();
	bless($self,$clas);
	return($self);
}

sub new_data($$$) {
	my($clas,$path,$sepa)=@_;
	my($object)=Meta::Utils::File::Patho->new();
	$object->append_data($path,$sepa);
	return($object);
}

sub new_env($$$) {
	my($clas,$var,$sepa)=@_;
	return(Meta::Utils::File::Patho->new_data(Meta::Utils::Env::get($var),$sepa));
}

sub minimize($) {
	my($self)=@_;
}

sub exists($$) {
	my($self,$file)=@_;
	for(my($i)=0;$i<$self->size();$i++) {
		my($curr)=$self->getx($i);
		my($test)=$curr."/".$file;
		if(-f $test) {
			return(1);
		}
	}
	return(0);
}

sub resolve($$) {
	my($self,$file)=@_;
	for(my($i)=0;$i<$self->size();$i++) {
		my($curr)=$self->getx($i);
		my($test)=$curr."/".$file;
		if(-f $test) {
			return($test);
		}
	}
	return(undef);
}

sub append_data($$$) {
	my($self,$path,$sepa)=@_;
	my(@arra)=split($sepa,$path);
	for(my($i)=0;$i<=$#arra;$i++) {
		$self->push($arra[$i]);
	}
}

sub check($) {
	my($self)=@_;
	for(my($i)=0;$i<$self->size();$i++) {
		my($curr)=$self->getx($i);
		if(!(-d $curr)) {
			Meta::Utils::System::die("component [".$curr."] is not a directory");
		}
	}
}

sub compose($$) {
	my($self,$sepa)=@_;
	return($self->join($sepa));
}

1;

__END__

=head1 NAME

Meta::Utils::File::Patho - Path object.

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

	MANIFEST: Patho.pm
	PROJECT: meta
	VERSION: 0.02

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::File::Patho qw();
	my($object)=Meta::Utils::File::Patho->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module gives you an object which encapsulates a path.

A Path is an ordered set of directories used to enable hierarchical
search for files (executables, source files etc). This path object
is exactly that - an ordered set of directories. You can initialize
the object from a string and a separator, from an environment
variable or by adding the components yourself. After that you can
resolve a file name according to the path and perform other
operations.

=head1 FUNCTIONS

	new($)
	new_data($$$)
	new_env($$$)
	minimize($)
	exists($$)
	resolve($$)
	append_data($$$)
	check($)
	compose($$)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::Utils::File::Patho object.

=item B<new_data($$$)>

Give this constructor a path and a separator and you'll get
a path object initialized for that path.

=item B<new_env($$$)>

This method will create a new instance from data taken from an
environment variable. You have to supply the separator yourself.

=item B<minimize($)>

This method will remove redundant componets in the path. Redundant
components in the path are components which repeat them selves.
The paths structure (the order of resolution) will remain the same.

=item B<exists($$)>

This method will returns whether a file given exists according to
the path. The file can have directory components in it and must
be relative to the path.

=item B<resolve($$)>

This method will return a file resolved according to a path.

=item B<append_data($$$)>

This method will append a path to the end of the current one.

=item B<check($)>

This method will check that each component in the path is indeed a directory.

=item B<compose($$)>

This method will return a string describing the path using the separator specified.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV md5 progress
	0.01 MV thumbnail user interface
	0.02 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-in the check method also check that the components are ABSOLUTE directory names.

-in the minimize method convert the elements into some kind of cannonical representation so I'll know that two directory names are not the same name for the same directory.

-can I have the Array object supply some kind of join method so that the code for compose be cleaner and faster ?