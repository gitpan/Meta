#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Distrib::Cpan qw();
use Meta::Lang::Perl::Perlpkgs qw();

my($package_file);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_devf("package","which package description to use ?","xmlx/perlpkgs/meta.xml",\$package_file);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($packs)=Meta::Lang::Perl::Perlpkgs::new_deve($package_file);
for(my($i)=0;$i<$packs->size();$i++) {
	my($pack)=$packs->getx($i);
	my($author)=$pack->get_author();
	Meta::Distrib::Cpan::upload($author->get_cpanid(),$author->get_cpanpassword(),$pack->get_pack_file_name());
}

Meta::Utils::System::exit(1);

__END__

=head1 NAME

distrib_cpan_upload.pl - upload a module to CPAN.

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

	MANIFEST: distrib_cpan_upload.pl
	PROJECT: meta
	VERSION: 0.07

=head1 SYNOPSIS

	distrib_cpan_upload.pl [options]

=head1 DESCRIPTION

This program will upload a development target/source to CPAN for you.
It will save you the hassle of using a web browser etc...

You need to give this program a single XML file describing the package
you are uploading. This XML description has everything the script
needs which are three things:
0. CPAN user id (contained in the author information).
1. CPAN user password (contained in the author information).
3. Product name to upload (can be derived from the package description).

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

=item B<package> (type: devf, default: xmlx/perlpkgs/meta.xml)

which package description to use ?

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

	0.00 MV database
	0.01 MV perl module versions in files
	0.02 MV thumbnail user interface
	0.03 MV more thumbnail issues
	0.04 MV website construction
	0.05 MV improve the movie db xml
	0.06 MV web site automation
	0.07 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Distrib::Cpan(3), Meta::Lang::Perl::Perlpkgs(3), Meta::Utils::Opts::Opts(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
