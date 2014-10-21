#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Convert::UU qw();
use Meta::Baseline::Aegis qw();
use Meta::Digest::MD5 qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

Meta::Baseline::Test::redirect_on();

my($file)=Meta::Baseline::Aegis::which("data/baseline/cook/opts.txt");
my($sum)=Meta::Digest::MD5::get_filename_digest($file);
my($encode)=Convert::UU::uuencode($sum);
Meta::Utils::Output::print("encode is [".$encode."]\n");
my($decode)=Convert::UU::uudecode($encode);
if($decode ne $sum) {
	Meta::Utils::System::die("decode and sum are not equal");
}

Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

uu.pl - test the external Convert::UU module.

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

	MANIFEST: uu.pl
	PROJECT: meta
	VERSION: 0.10

=head1 SYNOPSIS

	uu.pl

=head1 DESCRIPTION

This is a test suite for the Convert::UU package.
Currently it reads a file, creates a signature for it (to get
some binary data), encodes it, decodes it, and checks that
the results are the same.

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

=item B<history> (type: bool, default: 0)

show history and exit

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

	0.00 MV more perl packaging
	0.01 MV license issues
	0.02 MV md5 project
	0.03 MV database
	0.04 MV perl module versions in files
	0.05 MV thumbnail user interface
	0.06 MV more thumbnail issues
	0.07 MV website construction
	0.08 MV improve the movie db xml
	0.09 MV web site automation
	0.10 MV SEE ALSO section fix

=head1 SEE ALSO

Convert::UU(3), Meta::Baseline::Aegis(3), Meta::Baseline::Test(3), Meta::Digest::MD5(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
