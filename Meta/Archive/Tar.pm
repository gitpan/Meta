#!/bin/echo This is a perl module and should not be run

package Meta::Archive::Tar;

use strict qw(vars refs subs);
use Meta::Baseline::Aegis qw();
use Meta::Utils::File::File qw();
use Archive::Tar qw();
use Meta::Utils::File::Remove qw();
use Class::MethodMaker qw();
use Meta::Utils::Output qw();
use Meta::Utils::Utils qw();
use Meta::Utils::System qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw(Archive::Tar);

#sub BEGIN();
#sub new($);
#sub add_data($$$);
#sub add_file($$$);
#sub add_deve($$$);
#sub write($$);
#sub TEST();

#__DATA__

sub BEGIN() {
	Class::MethodMaker->get_set(
		-java=>"_type",
		-java=>"_uname",
		-java=>"_gname",
	);
}

sub new($) {
	my($clas)=@_;
	my($self)=Archive::Tar->new();
	bless($self,$clas);
	return($self);
}

sub add_data($$$) {
	my($self,$name,$data)=@_;
	# the next paragraph is a bug work around
	if($data eq "") {#make the data have something so It will go into the archive
		$data=" ";
		#add data with specified length
		#$self->SUPER::add_data($name,$data,{ "size"=>0 });
		#$self->SUPER::add_data($name,$data);
	}
	my($hash)={};
	if($self->get_uname() ne defined) {
		$hash->{"uname"}=$self->get_uname();
	}
	if($self->get_gname() ne defined) {
		$hash->{"gname"}=$self->get_gname();
	}
	$self->SUPER::add_data($name,$data,$hash);
}

sub add_file($$$) {
	my($self,$name,$file)=@_;
	my($data)=Meta::Utils::File::File::load($file);
	return($self->add_data($name,$data));
}

sub add_deve($$$) {
	my($self,$name,$file)=@_;
	my($file)=Meta::Baseline::Aegis::which($file);
	return($self->add_file($name,$file));
}

sub write($$) {
	my($self,$targ)=@_;
	$self->SUPER::write($targ,9);
}

sub TEST() {
	my($tar)=Meta::Archive::Tar->new();
	$tar->add_data("foo.c","");
	$tar->add_deve("movies.xml","xmlx/movie/movie.xml");
	my(@list)=$tar->list_files();
	Meta::Utils::Output::print(join("\n",@list)."\n");
	my($temp)=Meta::Utils::Utils::get_temp_file();
	$tar->write($temp,9);
	Meta::Utils::System::system("tar",["ztvf",$temp]);
	Meta::Utils::File::Remove::rm($temp);
	return(1);
}

1;

__END__

=head1 NAME

Meta::Archive::Tar - extended Archive::Tar class.

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

	MANIFEST: Tar.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Archive::Tar qw();
	my($object)=Meta::Archive::Tar->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This class extends the Archive::Tar class.
It adds services like adding a file under a different name,
and adding a baseline relative file.

Currently, because of the underlying Archive::Tar
implementation, only the gzip mode is supported.

=head1 FUNCTIONS

	BEGIN()
	new($)
	add_data($$$)
	add_file($$$)
	add_deve($$$)
	write($$)
	TEST()

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

Setup method for this class which sets up get/set methods for
the following attributes:
type - type of archive (gzip,zip,bzip2).
uname - user name under which the archive will be created.
gname - group name under which the archive will be created.

=item B<new($)>

This is a constructor for the Meta::Archive::Tar object.

=item B<add_data($$$)>

This method overrides the default add_data since the default
method does not handle empty data well (it does not put them
in the archive and I written that as a bug to mail the author).

=item B<add_file($$$)>

This method will add a file you specify under the name you specify.

=item B<add_deve($$$)>

This method will add a file relative to the baseline.
Parameters are:
0. Meta::Archive::Tar object handle.
1. name under which to store the file.
2. file name relative to the baseline root.

=item B<write($$)>

This method will write the archive. This method overrides the Archive::Tar
method by the same name because that method passes the gzip compression factor
in the activation too (which I think is bad practice).

=item B<TEST()>

This is a test suite for the Meta::Archive::Tar package.
Currently it just creates an archive with some data.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV perl packaging
	0.01 MV validate writing
	0.02 MV PDMT
	0.03 MV fix database problems
	0.04 MV md5 project
	0.05 MV database
	0.06 MV perl module versions in files
	0.07 MV movies and small fixes
	0.08 MV thumbnail user interface
	0.09 MV import tests
	0.10 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

-once the author of Archive::Tar gets ridd of the bug where empty data files could not be created then fix the code here.
