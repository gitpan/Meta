#!/bin/echo This is a perl module and should not be run

package Meta::Utils::Debug;

use strict qw(vars refs subs);
use Meta::Ds::Set qw();
use Meta::Utils::Output qw();

our($VERSION,@ISA);
$VERSION="0.25";
@ISA=qw();

#sub debug();
#sub msg($);

#__DATA__

my($set);

sub debug() {
	# this should check whether the routine is on the list.
	return(0);
}

BEGIN {
#	my($file)="data/baseline/debug.txt";
#	$file=Meta::Baseline::Aegis::which($file);
#	$set=Meta::Ds::Set->new();
#	$set->read($file);
#	Meta::Utils::Output::print("size of set is [".$set->size()."]\n");
}

sub msg($) {
	my($mess)=@_;
	Meta::Utils::Output::print($mess."\n");
}

1;

__END__

=head1 NAME

Meta::Utils::Debug - handle debug of perl scripts in base.

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

	MANIFEST: Debug.pm
	PROJECT: meta
	VERSION: 0.25

=head1 SYNOPSIS

	package foo;
	use Meta::Utils::Debug qw();
	Meta::Utils::Debug::debug_use();

=head1 DESCRIPTION

This package handles perl debugging in base and makes sure that if
you're not a perl developer you will not suffer from the lags of doing
things like: use strict qw(vars refs subs);
use diagnostics;etc...
For all programmers that change this package - this package is the first
that gets used in every package in base - keep it lean and mean...

=head1 FUNCTIONS

	debug()
	msg($)

=head1 FUNCTION DOCUMENTATION

=over 4

=item B<set>

This is the set which has all the functions that need debug.

=item B<debug()>

This functions returns a boolean telling you whether your'e in debug mode
or not.

=item B<BEGIN BLOCK>

This begin block makes sure that the code in it gets run in compile
time which will load up the debugging libs if indeed the variable
BASE_PERL_DEBU is set.

=item B<msg($)>

This method will output debug message.
currently it just prints to stderr.

=back

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mark2776@yahoo.com
	WWW: http://www.geocities.com/mark2776
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV check that all uses have qw
	0.05 MV fix todo items look in pod documentation
	0.06 MV more on tests/more checks to perl
	0.07 MV more perl code quality
	0.08 MV more perl code quality
	0.09 MV finish Simul documentation
	0.10 MV perl code quality
	0.11 MV more perl quality
	0.12 MV more perl quality
	0.13 MV perl documentation
	0.14 MV more perl quality
	0.15 MV perl qulity code
	0.16 MV more perl code quality
	0.17 MV revision change
	0.18 MV languages.pl test online
	0.19 MV perl packaging
	0.20 MV md5 project
	0.21 MV database
	0.22 MV perl module versions in files
	0.23 MV movies and small fixes
	0.24 MV thumbnail user interface
	0.25 MV more thumbnail issues

=head1 SEE ALSO

Nothing.

=head1 TODO

Nothing.
