#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Tool::Nm qw();
use Meta::Utils::Output qw();

my($symbol);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_stri("symbol","what symbol should I search for ?",undef,\$symbol);
$opts->set_free_allo(1);
$opts->set_free_stri("[args]");
$opts->set_free_mini(1);
$opts->set_free_noli(1);
$opts->analyze(\@ARGV);

for(my($i)=0;$i<=$#ARGV;$i++) {
	my($curr)=$ARGV[$i];
	my($hash)=Meta::Tool::Nm::read($curr);
	if(exists($hash->{$symbol})) {
		Meta::Utils::Output::print("file [".$curr."] contains the symbol\n");
	}
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

develop_find_sym.pl - find where a symbol is defined in a list of libs.

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

	MANIFEST: develop_find_sym.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	develop_find_sym.pl [options]

=head1 DESCRIPTION

Give this script a set of libraries and a symbol that you cant seem
to find and he'll tell you which of the libraries implement that
symbol.

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<description> (type: bool, default: 0)

show description and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<symbol> (type: stri, default: )

what symbol should I search for ?

=back

minimum of [1] free arguments required
no maximum limit on number of free arguments placed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV move tests to modules

=head1 SEE ALSO

Meta::Tool::Nm(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
