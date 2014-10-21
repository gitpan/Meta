#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Digest::MD5 qw();
use Meta::Utils::Output qw();

my($file);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_file("file","what file to calculate ?",undef,\$file);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($sum)=Meta::Digest::MD5::get_filename_hexdigest($file);
Meta::Utils::Output::print("md5sum is [".$sum."]\n");

Meta::Utils::System::exit(1);

__END__

=head1 NAME

md5_sum.pl - calculate MD5 sums and display them.

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

	MANIFEST: md5_sum.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	md5_sum.pl [options]

=head1 DESCRIPTION

This program does the same thing as the famous md5sum(1) but only
in perl. The reason is for greater command line flexibility, code
sharing (the md5 calculation is shared by all perl modules as it
is implemented in a single module) and cleanliness.

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

=item B<file> (type: file, default: )

what file to calculate ?

=back

no free arguments are allowed

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

Meta::Digest::MD5(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
