#!/bin/echo This is a perl module and should not be run

package Meta::File::MMagic;

use strict qw(vars refs subs);
use Meta::Baseline::Aegis qw();
use File::MMagic qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(File::MMagic);

#sub new($);
#sub is_image($$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)=File::MMagic->new();
	bless($self,$clas);
	$self->addFileExts('\.css$',"text/css");
	return($self);
}

sub is_image($$) {
	my($self,$file)=@_;
	my($type)=$self->checktype_filename($file);
#	Meta::Utils::Output::print("type is [".$type."]\n");
	if($type=~/^image\//) {
		return(1);
	} else {
		return(0);
	}
}

sub TEST($) {
	my($context)=@_;
	my($file)="cssx/projects/Website/main.css";
	my($abso)=Meta::Baseline::Aegis::which($file);
	my($mm)=Meta::File::MMagic->new();
	my($type)=$mm->checktype_byfilename($abso);
	if($type ne "text/css") {
		return(0);
	}
	my($image_file)="jpgx/mark/mark_chess2.jpg";
	my($abso_image)=Meta::Baseline::Aegis::which($image_file);
	if(!($mm->is_image($abso_image))) {
		return(0);
	}
	return(1);
}

1;

__END__

=head1 NAME

Meta::File::MMagic - extend File::MMagic.

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

	MANIFEST: MMagic.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::File::MMagic qw();
	my($object)=Meta::File::MMagic->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class extends the functionality found in File::MMagic
until some improvements to that class are made.

=head1 FUNCTIONS

	new($)
	is_image($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

This is a constructor for the Meta::File::MMagic object.
Currently it adds the ability to recognize css file types
by using the addFileExts method.

=item B<is_image($$)>

This method will return whether the specified file is an
image. It finds the mime type and checks whether it has
"image" in it.

=item B<TEST($)>

This is a testing suite for the Meta::File::MMagic module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.

=back

=head1 SUPER CLASSES

File::MMagic(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV download scripts

=head1 SEE ALSO

File::MMagic(3), Meta::Baseline::Aegis(3), strict(3)

=head1 TODO

-add caching capabilities to this class using Cache::MemoryCache.

-make a "best" method for matching. It is not obvious whether check_filename or check_byfilename is the best method of File::MMagic and so I need a killer combination.
