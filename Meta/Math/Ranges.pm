#!/bin/echo This is a perl module and should not be run

package Meta::Math::Ranges;

use strict qw(vars refs subs);

our($VERSION,@ISA);
$VERSION="0.28";
@ISA=qw();

#sub new($);
#sub insert($$$);
#sub num_ranges($);
#sub min_value($$);
#sub max_value($$);
#sub TEST($);

#__DATA__

sub new($) {
	my($clas)=@_;
	my($self)={};
	bless($self,$clas);
	$self->{MINX}=[];
	$self->{MAXX}=[];
	$self->{SIZE}=0;
	return($self);
}

sub insert($$$) {
	my($self,$minx,$maxx)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Math::Ranges");
	my($minl)=$self->{MINX};
	push(@$minl,$minx);
	my($maxl)=$self->{MAXX};
	push(@$maxl,$maxx);
	$self->{SIZE}++;
}

sub num_ranges($) {
	my($self)=@_;
#	Meta::Utils::Arg::check_arg($self,"Meta::Math::Ranges");
	return($self->{SIZE});
}

sub min_value($$) {
	my($self,$inde)=@_;
	return($self->{MINX}->[$inde]);
}

sub max_value($$) {
	my($self,$inde)=@_;
	return($self->{MAXX}->[$inde]);
}

sub TEST($) {
	my($context)=@_;
	return(1);
}

1;

__END__

=head1 NAME

Meta::Math::Ranges - Data structure to describe a list of ranges.

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

	MANIFEST: Ranges.pm
	PROJECT: meta
	VERSION: 0.28

=head1 SYNOPSIS

	package foo;
	use Meta::Math::Ranges qw();
	my($range)=Meta::Math::Ranges->new();
	$range->insert(5,10);

=head1 DESCRIPTION

This is an object to describe a list of mathematical ranges (min-max type)
which are disjoint.

=head1 FUNCTIONS

	new($)
	insert($$$)
	num_ranges($)
	min_value($$)
	max_value($$)
	TEST($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<new($)>

Gives you a new Ranges object.

=item B<insert($$$)>

Inserts an element into the ranges object.

=item B<num_ranges($)>

This returns the number of ranges in the object.

=item B<min_value($$)>

This returns the minimum value of each range.

=item B<max_value($$)>

This returns the maximum value of each range.

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

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV check that all uses have qw
	0.04 MV fix todo items look in pod documentation
	0.05 MV more on tests/more checks to perl
	0.06 MV more perl code quality
	0.07 MV change new methods to have prototypes
	0.08 MV perl code quality
	0.09 MV more perl quality
	0.10 MV more perl quality
	0.11 MV perl documentation
	0.12 MV more perl quality
	0.13 MV perl qulity code
	0.14 MV more perl code quality
	0.15 MV revision change
	0.16 MV languages.pl test online
	0.17 MV PDMT/SWIG support
	0.18 MV perl packaging
	0.19 MV md5 project
	0.20 MV database
	0.21 MV perl module versions in files
	0.22 MV movies and small fixes
	0.23 MV more thumbnail stuff
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues
	0.26 MV website construction
	0.27 MV web site automation
	0.28 MV SEE ALSO section fix

=head1 SEE ALSO

strict(3)

=head1 TODO

Nothing.
