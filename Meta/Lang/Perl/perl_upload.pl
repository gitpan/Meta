#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Lang::Perl::Upload qw();

my($verbose,$do_ftp,$do_http,$perlpkg);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("verbose","noisy or quiet ?",0,\$verbose);
$opts->def_bool("ftp","do the ftp part ?",1,\$do_ftp);
$opts->def_bool("http","noisy or quiet ?",1,\$do_http);
$opts->def_devf("perlpkg","what package description to use ?","xmlx/temp/xmlx/perlpkgs/meta.xml",\$perlpkg);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($uploader)=Meta::Lang::Perl::Upload->new();
$uploader->set_verbose($verbose);
$uploader->init();
$uploader->upload($perlpkg,$do_ftp,$do_http);
$uploader->finish();

Meta::Utils::System::exit(1);

__END__

=head1 NAME

perl_upload.pl - upload a package to CPAN.

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

	MANIFEST: perl_upload.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	perl_upload.pl [options]

=head1 DESCRIPTION

This program takes an XML/PERLPKG description of a perl package and uploads
the package to CPAN. The XML/PERLPKG file should have all the relevant
infomation in order for the upload to take place (CPAN id, password etc...).
This program makes use of the Meta::Lang::Perl::Upload module to do it's
thing.

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

=item B<verbose> (type: bool, default: 0)

noisy or quiet ?

=item B<ftp> (type: bool, default: 1)

do the ftp part ?

=item B<http> (type: bool, default: 1)

noisy or quiet ?

=item B<perlpkg> (type: devf, default: xmlx/temp/xmlx/perlpkgs/meta.xml)

what package description to use ?

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

Meta::Lang::Perl::Upload(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
