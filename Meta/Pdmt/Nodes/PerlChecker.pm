#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Nodes::PerlChecker;

use strict qw(vars refs subs);
use Meta::Pdmt::TargetFileNode qw();
use Meta::Baseline::Utils qw();
use Meta::Utils::Output qw();
use Meta::Baseline::Lang::Perl qw();
use Meta::Baseline::Aegis qw();

our($VERSION,@ISA);
$VERSION="0.00";
@ISA=qw(Meta::Pdmt::TargetFileNode);

#sub build($$);
#sub TEST($);

#__DATA__

sub build($$) {
	my($node,$pdmt)=@_;
	my($targ)=$node->get_path();
	my($source_node)=$pdmt->get_single_succ($node);
	my($name)=$source_node->get_name();
	my($path)=$source_node->get_path();
	my($abs_path)=Meta::Baseline::Aegis::which($path);
	#Meta::Utils::Output::print("name is [".$name."]\n");
	#Meta::Utils::Output::print("path is [".$path."]\n");
	#Meta::Utils::Output::print("abs_path is [".$abs_path."]\n");
	my($res)=Meta::Baseline::Lang::Perl::check($name,$abs_path,Meta::Baseline::Aegis::search_path());
	if($res) {
		Meta::Baseline::Utils::mkdir_emblem($targ);
	}
	return($res);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Pdmt::Nodes::PerlChecker - PDMT node to check perl source files.

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

	MANIFEST: PerlChecker.pm
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Nodes::PerlChecker qw();
	my($object)=Meta::Pdmt::Nodes::PerlChecker->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This module will check perl source files.

=head1 FUNCTIONS

	build($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<build($$)>

This method does the actual building.

=item B<TEST($)>

This is a testing suite for the Meta::Pdmt::Nodes::PerlChecker module.
This test is should be run by a higher level management system at integration
or release time or just as a regular routine to check that all is well.
This test currently does nothing.

=back

=head1 SUPER CLASSES

Meta::Pdmt::TargetFileNode(3)

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV teachers project

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Baseline::Lang::Perl(3), Meta::Baseline::Utils(3), Meta::Pdmt::TargetFileNode(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
