#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Baseline::Test qw();
use Meta::Info::MailMessage qw();
use Meta::Utils::Output qw();

my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

#Meta::Baseline::Test::redirect_on();

my($user)=Meta::Baseline::Test::get_user();
my($host)=Meta::Baseline::Test::get_host();
my($domain)=Meta::Baseline::Test::get_domain();

my($message)=Meta::Info::MailMessage->new();
$message->set_subject("message header");
$message->set_text("foo,foo");
$message->set_from($user."\@".$domain);
$message->get_recipients()->push($user."\@".$host);
my($scod)=$message->send();
if(!$scod) {
	Meta::Utils::Output::print("error was [".$message->get_error()."]\n");
}

#Meta::Baseline::Test::redirect_off();

Meta::Utils::System::exit($scod);

__END__

=head1 NAME

mailmessage.pl - testing program for the Meta::Info::MailMessage.pm module.

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

	MANIFEST: mailmessage.pl
	PROJECT: meta
	VERSION: 0.11

=head1 SYNOPSIS

	mailmessage.pl

=head1 DESCRIPTION

This script tests the Meta::Info::MailMessage module.
It creates an email message and sends it.

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

	0.00 MV perl packaging again
	0.01 MV more Perl packaging
	0.02 MV license issues
	0.03 MV md5 project
	0.04 MV database
	0.05 MV perl module versions in files
	0.06 MV thumbnail user interface
	0.07 MV more thumbnail issues
	0.08 MV website construction
	0.09 MV improve the movie db xml
	0.10 MV web site automation
	0.11 MV SEE ALSO section fix

=head1 SEE ALSO

Meta::Baseline::Test(3), Meta::Info::MailMessage(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

Nothing.
