#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Tool::Groff qw();
use Meta::Utils::Output qw();
use Meta::Utils::File::File qw();
use Compress::Zlib qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($file)="/usr/share/man/man1/ls.1.gz";
my($content)=Meta::Utils::File::File::load($file);
#Meta::Utils::Output::print("content is [".$content."]\n");
my($uncompressed)=Compress::Zlib::memGunzip($content);
if(!defined($uncompressed)) {
	Meta::Utils::System::die("unable to uncompress");
}
#Meta::Utils::Output::print("uncompressed is [".$uncompressed."]\n");
my($out)=Meta::Tool::Groff::process($uncompressed);
Meta::Utils::Output::print("out is [".$out."]\n");

Meta::Utils::System::exit(1);

__END__

=head1 NAME

groff.pl - demo the groff class.

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

	MANIFEST: groff.pl
	PROJECT: meta
	VERSION: 0.05

=head1 SYNOPSIS

	groff.pl [options]

=head1 DESCRIPTION

Put your programs description here.

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

	0.00 MV import tests
	0.01 MV more thumbnail issues
	0.02 MV website construction
	0.03 MV improve the movie db xml
	0.04 MV web site automation
	0.05 MV SEE ALSO section fix

=head1 SEE ALSO

Compress::Zlib(3), Meta::Tool::Groff(3), Meta::Utils::File::File(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
