#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::FileNode;

use strict qw(vars refs subs);
use Meta::Pdmt::Node qw();
use Meta::Utils::File::File qw();
use Meta::Class::MethodMaker qw();
use Meta::Utils::File::Time qw();

our($VERSION,@ISA);
$VERSION="0.01";
@ISA=qw(Meta::Pdmt::Node);

#sub BEGIN();
#sub exist($);
#sub remove($);
#sub date($);
#sub uptodate($$);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_path",
		-java=>"_md5",
	);
	Meta::Class::MethodMaker->print(["path","md5"]);
}

sub exist($) {
	my($self)=@_;
	return(Meta::Utils::File::File::exist($self->get_path()));
}

sub remove($) {
	my($self)=@_;
	return(Meta::Utils::File::File::rm_nodie($self->get_path()));
}

sub date($) {
	my($self)=@_;
	my($res)=Meta::Utils::File::Time::new_time($self->get_path());
	Meta::Utils::Output::print("path is [".$self->get_path()."]\n");
	Meta::Utils::Output::print("returning [".$res."]\n");
	return($res);
}

sub uptodate($$) {
	my($self,$pdmt)=@_;
	if(!$self->exist()) {
		return(0);
	}
	#get all nodes which this edge depends on
	my($date)=$self->date();
	my(@nodes)=$pdmt->successors($self);
	for(my($i)=0;$i<=$#nodes;$i++) {
		my($curr)=$nodes[$i];
		if($curr->date()>$date) {
			return(0);
		}
	}
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Pdmt::FileNode - a node representing a file.

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

	MANIFEST: FileNode.pm
	PROJECT: meta
	VERSION: 0.01

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::FileNode qw();
	my($object)=Meta::Pdmt::FileNode->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is a node in the PDMT graph representing a file in the file system.

=head1 FUNCTIONS

	BEGIN()
	exist($)
	remove($)
	date($)
	uptodate($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This initialization method sets up a default constructor and accessor methods
for the following attributes:
1. path.
2. md5

=item B<exist($)>

This method returns whether the file exists or not.

=item B<remove($)>

This file removes the current file ("make clean").

=item B<date($)>

This method returns the modification date of the current file.

=item B<uptodate($$)>

This is an overriding method to implement what does it mean for a disk
file to be up to date.

=item B<TEST($)>

Test suite for this module.

=back

=head1 SUPER CLASSES

Meta::Pdmt::Node(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV web site automation
	0.01 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Class::MethodMaker(3), Meta::Pdmt::Node(3), Meta::Utils::File::File(3), Meta::Utils::File::Time(3), strict(3)

=head1 TODO

Nothing.
