#!/bin/echo This is a perl module and should not be run

package Meta::Pdmt::Node;

use strict qw(vars refs subs);
use Meta::Class::MethodMaker qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.10";
@ISA=qw();

#sub BEGIN();
#sub build($$);
#sub uptodate($$);
#sub TEST($);

#__DATA__

sub BEGIN() {
	Meta::Class::MethodMaker->new("new");
	Meta::Class::MethodMaker->get_set(
		-java=>"_name",
		-java=>"_rule",
	);
	Meta::Class::MethodMaker->print(["name","rule"]);
}

sub build($$) {
	my($self,$pdmt)=@_;
	my($rule)=$self->get_rule();
	#Meta::Utils::Output::print("rule is [".$rule."]\n");
	if(!defined($rule)) {
		Meta::Utils::Output::print("no rule to make target [".$self->get_name()."]\n");
	} else {
		$rule->($self,$pdmt);
	}
}

sub uptodate($$) {
	my($self,$pdmt)=@_;
	return(1);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Pdmt::Node - A PDMT graph node.

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

	MANIFEST: Node.pm
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	package foo;
	use Meta::Pdmt::Node qw();
	my($object)=Meta::Pdmt::Node->new();
	my($result)=$object->method();

=head1 DESCRIPTION

This is a PDMT graph node. The node implements all the basic methods
that child nodes need to override.

=head1 FUNCTIONS

	BEGIN()
	build($$)
	uptodate($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<BEGIN()>

This is an initializer for the class. It takes care for a:
1. default constructor for the class.
2. accessor get_ set_ methods for the attributes name,rule.
3. print method for the class.

=item B<build($$)>

This method actually builds a node. In this generic node it does nothing.

=item B<uptodate($$)>

This method should be overriden by child nodes.
This method should return whether the file is uptodate.
This basic implementation returns true always.

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

	0.00 MV spelling and papers
	0.01 MV perl packaging
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV movies and small fixes
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues
	0.08 MV website construction
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Class::MethodMaker(3), Meta::Utils::Output(3), strict(3)

=head1 TODO

Nothing.
