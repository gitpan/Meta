#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use GnuPG qw();
use Meta::Utils::Output qw();
use Meta::Info::Author qw();
use Meta::Development::Module qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($file)="xmlx/author/author.xml";
my($module)=Meta::Development::Module->new();
$module->set_name($file);
my($author)=Meta::Info::Author->new_modu($module);

my($file_to_encrypt)="/etc/passwd";
my($outfile)="/tmp/passwd.gpg";
my($gpg)=GnuPG->new();

$gpg->encrypt(
	plaintext=>$file_to_encrypt,
	output=>$outfile,
#	symmetric=>1,
	recipient=>$author->get_email(),
	armor=>0,
	sign=>0,
	passphrase=>$author->get_passphrase(),
);

#my($enc)=$gpg->encrypt($content,$author->get_email());
#Meta::Utils::Output::print("enc is [".$enc."]\n");

Meta::Utils::System::exit(1);

__END__

=head1 NAME

demo_gnupg.pl - demo usage of the GnuPG module.

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

	MANIFEST: demo_gnupg.pl
	PROJECT: meta
	VERSION: 0.00

=head1 SYNOPSIS

	gnupg.pl [options]

=head1 DESCRIPTION

This program demostrates using the GnuPG module for encryption. 

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

	0.00 MV finish papers

=head1 SEE ALSO

GnuPG(3), Meta::Development::Module(3), Meta::Info::Author(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
